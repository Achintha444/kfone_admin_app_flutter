import uuid

from flask import Flask
import jwt
import requests
from functools import wraps
from flask import request, abort, jsonify, make_response
from typing import List
import base64
import json
from enum import Enum
from cryptography.hazmat.primitives.asymmetric import rsa, ec
from cryptography.hazmat.primitives import serialization
from cryptography.hazmat.backends import default_backend

app = Flask(__name__)

JWKS_URL = 'https://api.asgardeo.io/t/kfonebusiness/oauth2/jwks'
AUD = "g78TWkBfdMqBLDqFMQ5abdPFbyYa"
ADMIN_GROUP = "admin"
SALES_GROUP = "sales"
MARKETING_GROUP = "marketing"


# Device model
class Device:
    def __init__(self, device_id, name, image_uri, qty, description, price, promo_id_list=None):
        self.device_id = device_id
        self.name = name
        self.image_uri = image_uri
        self.qty = qty
        self.description = description
        self.price = price
        self.promo_id_list = promo_id_list


class DeviceEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, Device):
            return obj.__dict__
        elif isinstance(obj, list):
            return [item.__dict__ for item in obj if item is not None]
        return json.JSONEncoder.default(self, obj)


class Tier(Enum):
    Silver = 1
    Gold = 2
    Platinum = 3
    NoneTier = 4


# Promotion model
class Promotion:

    def __init__(self, promo_id, promo_code, discount, tier_list=None):
        self.promo_id = promo_id
        self.promo_code = promo_code
        self.discount = discount
        self.tier_list = tier_list

    def get_tier_enums(self: List[str]) -> List[Tier]:
        return [Tier[tier] for tier in self]


class PromotionEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, Promotion):
            data = {
                'promo_id': obj.promo_id,
                'promo_code': obj.promo_code,
                'discount': obj.discount,
                'tier_list': [tier.name for tier in obj.tier_list] if obj.tier_list else []
            }
            return data
        return super().default(obj)


# Sample data
devices = [
    Device(1, 'Device 1', 'image1.png', 15, 'Description 1', 100, [1, 2]),
    Device(2, 'Device 2', 'image2.png', 5, 'Description 2', 200, [2, 3]),
    Device(3, 'Device 3', 'image3.png', 8, 'Description 3', 200)
]

promotions = [
    Promotion(1, 'PROMO1', 10, [Tier.Silver]),
    Promotion(2, 'PROMO2', 20, [Tier.Gold]),
    Promotion(3, 'PROMO3', 30, [Tier.Platinum])
]


# Get device by ID
def get_device(device_id):
    for device in devices:
        if device.device_id == device_id:
            return device
    return None


# Get promotion by ID
def get_promotion(promo_id):
    for promotion in promotions:
        if promotion.promo_id == promo_id:
            return promotion
    return None


# Define a custom Flask decorator for JWT authentication
def requires_auth(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        # Get JWT access token from the Authorization header
        token = request.headers.get('Authorization').split()[1]
        decoded_token = None
        if not token:
            abort(401)  # Unauthorized

        try:
            # Get the JWT header and extract the kid
            # jwt_header = jwt.get_unverified_header(token.split()[1])
            jwt_header = jwt.get_unverified_header(token)
            kid = jwt_header['kid']

            # Get the JWKS from the JWKS endpoint and find the public key for the kid
            jwks = get_jwks(JWKS_URL)
            public_key = None
            for jwk in jwks['keys']:
                if jwk['kid'] == kid:
                    public_key = jwk_to_public_key(jwk)
                    break

            # Decode JWT access token and verify signature using the public key
            decoded_token = jwt.decode(token, public_key, algorithms=['RS256'], audience=AUD, verify=True)
        except:
            abort(401)  # Unauthorized

        return f(decoded_token, *args, **kwargs)

    return decorated


# API endpoints
@app.route('/devices', methods=['GET'])
@requires_auth
def get_devices(decoded_token):
    if ADMIN_GROUP not in decoded_token['groups']:
        return jsonify({'message': 'Unauthorized'}), 403
    # devices_dict_list = [d.__dict__ for d in devices]
    # return jsonify({"devices": devices_dict_list})
    # return jsonify({"devices": json.dumps(devices, cls=DeviceEncoder)})
    # return jsonify({"devices": json.dumps(devices, cls=DeviceEncoder)})
    return json.dumps({"devices": devices}, cls=DeviceEncoder), 200, {'content-type': 'application/json'}


@app.route('/devices/<int:device_id>', methods=['GET'])
@requires_auth
def get_device_by_id(decoded_token, device_id):
    if ADMIN_GROUP not in decoded_token['groups']:
        return jsonify({'message': 'Forbidden'}), 403
    device = get_device(device_id)
    if device:
        return json.dumps(device, cls=DeviceEncoder), 200, {'content-type': 'application/json'}
    else:
        return jsonify({'message': 'Device not found'}), 404


# Search device by name
@app.route('/devices/search/<string:device_name>', methods=['GET'])
@requires_auth
def search_device_by_name(decoded_token, device_name):
    if ADMIN_GROUP not in decoded_token['groups']:
        return jsonify({'message': 'Forbidden'}), 403
    device_list = []
    for device in devices:
        if device_name.lower() in device.name.lower():
            device_list.append(device)
    return json.dumps({"devices": device_list}, cls=DeviceEncoder), 200, {'content-type': 'application/json'}


@app.route('/devices', methods=['POST'])
@requires_auth
def add_device(decoded_token):
    if ADMIN_GROUP not in decoded_token['groups']:
        return jsonify({'message': 'Forbidden'}), 403
    device_data = request.get_json()
    device_id = len(devices) + 1
    if 'name' not in device_data or 'image_uri' not in device_data or 'qty' not in device_data or \
            'description' not in device_data or 'price' not in device_data:
        return jsonify({'message': 'Missing required fields'}), 400
    promo_id_list = []
    if 'promo_id' in device_data:
        promo_id_list = device_data['promo_id']
    new_device = Device(device_id, device_data['name'], device_data['image_uri'], device_data['qty'],
                        device_data['description'], device_data['price'], promo_id_list)
    devices.append(new_device)
    return jsonify({'device': new_device.__dict__}), 201


@app.route('/devices/<int:device_id>', methods=['PUT', 'PATCH'])
@requires_auth
def update_device(decoded_token, device_id):
    if ADMIN_GROUP not in decoded_token['groups']:
        return jsonify({'message': 'Forbidden'}), 403
    device = get_device(device_id)
    if not device:
        return jsonify({'message': 'Device not found'}), 404

    device_data = request.get_json()
    if 'name' in device_data:
        device.name = device_data['name']
    if 'image_uri' in device_data:
        device.image_uri = device_data['image_uri']
    if 'qty' in device_data:
        device.qty = device_data['qty']
    if 'description' in device_data:
        device.description = device_data['description']
    if 'price' in device_data:
        device.price = device_data['price']
    if 'promo_id' in device_data:
        device.promo_id = device_data['promo_id']

    return jsonify({'device': device.__dict__}), 200


@app.route('/devices/<int:device_id>', methods=['DELETE'])
@requires_auth
def delete_device(decoded_token, device_id):
    if ADMIN_GROUP not in decoded_token['groups']:
        return jsonify({'message': 'Forbidden'}), 403
    device = [d for d in devices if d.device_id == device_id]
    if len(device) == 0:
        response = make_response(jsonify(message=f"Device with ID {device_id} not found"), 404)
        abort(response)
    devices.remove(device[0])
    return jsonify({'message': f"Device with ID {device_id} deleted successfully"})


@app.route('/promotions', methods=['GET'])
@requires_auth
def get_promotions(decoded_token):
    if not any(x in ['Test', ADMIN_GROUP, SALES_GROUP] for x in decoded_token['groups']):
        abort(403)  # Access denied
    # return jsonify(promotions)
    return json.dumps({"promotions": promotions}, cls=PromotionEncoder), 200, {'content-type': 'application/json'}


@app.route('/promotions/<int:promo_id>', methods=['GET'])
@requires_auth
def get_promotion_by_id(decoded_token, promo_id):
    if not any(x in ['Test', ADMIN_GROUP, SALES_GROUP] for x in decoded_token['groups']):
        abort(403)  # Access denied
    promotion = get_promotion(promo_id)
    if promotion:
        return json.dumps(promotion, cls=PromotionEncoder), 201, {'content-type': 'application/json'}
    else:
        return jsonify({'message': 'Promotion not found'}), 404


@app.route('/promotions', methods=['POST'])
@requires_auth
def add_promotion(decoded_token):
    if not any(x in ['Test', ADMIN_GROUP, SALES_GROUP] for x in decoded_token['groups']):
        abort(403)  # Access denied
    new_promotion = request.get_json()
    new_promotion['promo_id'] = str(uuid.uuid4())  # generate new UUID for promotion ID

    if 'promo_code' not in new_promotion or 'discount' not in new_promotion:
        return jsonify({'message': 'Missing required fields'}), 400
    tier_list = []
    if 'tier' in new_promotion:
        tier_list = new_promotion['tier']
        tier_list = Promotion.get_tier_enums(tier_list)
    new_promotion = Promotion(new_promotion['promo_id'], new_promotion['promo_code'], new_promotion['discount'],
                              tier_list)
    promotions.append(new_promotion)
    return json.dumps(new_promotion, cls=PromotionEncoder), 201, {'content-type': 'application/json'}


@app.route('/promotions/<string:promo_id>', methods=['PUT', 'PATCH'])
@requires_auth
def update_promotion(decoded_token, promo_id):
    if not any(x in ['Test', ADMIN_GROUP, SALES_GROUP] for x in decoded_token['groups']):
        abort(403)  # Access denied
    promotion = get_promotion(promo_id)
    if not promotion:
        return jsonify({'message': 'Promotion not found'}), 404

    promotion_data = request.get_json()
    if 'promo_code' in promotion_data:
        promotion.promo_code = promotion_data['promo_code']
    if 'discount' in promotion_data:
        promotion.discount = promotion_data['discount']
    if 'tier' in promotion_data:
        promotion.tier_list = Promotion.get_tier_enums(promotion_data['tier'])

    return json.dumps(promotion, cls=PromotionEncoder), 201, {'content-type': 'application/json'}


@app.route('/promotions/<string:promo_id>', methods=['DELETE'])
@requires_auth
def delete_promotion(decoded_token, promo_id):
    if not any(x in ['Test', ADMIN_GROUP, SALES_GROUP] for x in decoded_token['groups']):
        abort(403)  # Access denied
    promotion = [p for p in promotions if p.promo_id == promo_id]
    if len(promotion) == 0:
        abort(404, f"Promotion with ID {promo_id} not found")

    promotions.remove(promotion[0])
    return jsonify({'message': f"Promotion with ID {promo_id} deleted successfully"})


# Add promotion to device
@app.route('/promotions/devices', methods=['POST'])
@requires_auth
def add_promotion_to_device(decoded_token):
    if not any(x in ['Test', ADMIN_GROUP, SALES_GROUP] for x in decoded_token['groups']):
        abort(403)
    # "promo_id": "1",
    #   "device_ids": [
    #     1,2
    #   ]
    # Sample request body
    promotion_data = request.get_json()
    if 'promo_id' not in promotion_data or 'device_ids' not in promotion_data:
        abort(400, 'Missing promo_code or device_ids from the request body')
    promo_id = promotion_data['promo_id']
    device_ids = promotion_data['device_ids']
    promotion = get_promotion_by_id(promo_id)
    if not promotion:
        abort(404, f"Promotion with ID {promo_id} not found")
    for device_id in device_ids:
        device = get_device(device_id)
        if not device:
            abort(404, f"Device with ID {device_id} not found")
        device.promo_id_list.append(promo_id)

    return jsonify({'message': f"Promotion with ID {promo_id} added to devices successfully"})


# Define a Flask endpoint that requires JWT access token
@app.route('/sales_activity')
@requires_auth
def sales_activity(decoded_token):
    if not any(x in ['Test', ADMIN_GROUP, MARKETING_GROUP] for x in decoded_token['groups']):
        abort(403)  # Access denied
    return 'Access granted!'


# Helper function to get JWKS from the JWKS endpoint
def get_jwks(jwks_url):
    response = requests.get(jwks_url)
    return response.json()


def jwk_to_public_key(jwk):
    """
    Convert a JWK to a public key in PEM format.

    Args:
        jwk (dict): JSON Web Key containing the public key information.

    Returns:
        bytes: The public key in PEM format.

    Raises:
        ValueError: If the JWK is invalid or if the key type is not supported.
    """

    # Validate JWK
    if not isinstance(jwk, dict):
        raise ValueError('Invalid JWK: JWK must be a dictionary')
    if jwk.get('kty') not in ['RSA', 'EC']:
        raise ValueError(f"Invalid JWK: Unsupported key type '{jwk.get('kty')}'")

    # Get public key parameters
    if jwk['kty'] == 'RSA':
        n = int.from_bytes(base64.urlsafe_b64decode(jwk['n'] + '=='), 'big')
        e = int.from_bytes(base64.urlsafe_b64decode(jwk['e'] + '=='), 'big')
        public_key = rsa.RSAPublicNumbers(e, n).public_key(default_backend())
    else:
        if jwk['crv'] != 'P-256':
            raise ValueError(f"Invalid JWK: Unsupported curve '{jwk['crv']}'")
        x = int.from_bytes(base64.urlsafe_b64decode(jwk['x'] + '=='), 'big')
        y = int.from_bytes(base64.urlsafe_b64decode(jwk['y'] + '=='), 'big')
        public_key = ec.EllipticCurvePublicNumbers(
            x=x,
            y=y,
            curve=ec.SECP256R1()
        ).public_key(default_backend())

    # Serialize public key to PEM format
    pem = public_key.public_bytes(
        encoding=serialization.Encoding.PEM,
        format=serialization.PublicFormat.SubjectPublicKeyInfo
    )

    return pem


# if __name__ == '__main__':
#     app.run(port=8001)

