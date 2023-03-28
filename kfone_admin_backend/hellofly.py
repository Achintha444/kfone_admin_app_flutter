import time
import base64
import json
import uuid
from collections import OrderedDict
from enum import Enum
from functools import wraps
from typing import List

import jwt
import requests
from flask import Flask, abort, jsonify, make_response, request
from jwt import PyJWKClient

app = Flask(__name__)

asgardeo_public_key = None
JWKS_URL = 'https://api.asgardeo.io/t/kfonebusiness/oauth2/jwks'
AUD = "obioKxDGAAxKeSlXrtnDBEWdkWYa"
ADMIN_CLIENT_ID = "dcVj3Rg8kgO8JBr7pj656qvHmpEa"
ADMIN_CLIENT_SECRET = "3SAUmmtCC4W_15yMewpSdjP883oa"
ACCESS_TOKEN = {}


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
    NoTier = 0
    Silver = 1
    Gold = 2
    Platinum = 3


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


# uuid sample value2 
# Sample data
# devices = [
#     Device("c9912c06-0a57-4812-89cb-8322c90fb3e5", 'iPhone 14 Pro Max', 'image1.png', 15, 'Description 1', 100, [1, 2]),
#     Device("d4e2c72a-1785-454b-ae90-4796859f85d4", 'Samsung Galaxy S22 Ultra', 'image2.png', 5, 'Description 2', 200, [2, 3]),
#     Device("8c4dd076-e817-4969-a4fa-e33a28023d83", 'Google Pixel 7 Pro', 'image3.png', 8, 'Description 3', 200)
# ]

devices = OrderedDict({
    "c9912c06-0a57-4812-89cb-8322c90fb3e5": Device("c9912c06-0a57-4812-89cb-8322c90fb3e5", 'iPhone 14 Pro Max',
                                                   'image1.png', 15, 'Description 1', 100, [1, 2]),
    "d4e2c72a-1785-454b-ae90-4796859f85d4": Device("d4e2c72a-1785-454b-ae90-4796859f85d4", 'Samsung Galaxy S22 Ultra',
                                                   'image2.png', 5, 'Description 2', 200, [2, 3]),
    "8c4dd076-e817-4969-a4fa-e33a28023d83": Device("8c4dd076-e817-4969-a4fa-e33a28023d83", 'Google Pixel 7 Pro',
                                                   'image3.png', 8, 'Description 3', 200)
})

promotions = [
    Promotion(1, 'PROMO1', 10, [Tier.Silver]),
    Promotion(2, 'PROMO2', 20, [Tier.Gold]),
    Promotion(3, 'PROMO3', 30, [Tier.Platinum])
]

customers = {}


# Get device by ID
def get_device(device_id):
    return devices.get(device_id)


# Get promotion by ID
def get_promotion(promo_id):
    for promotion in promotions:
        if promotion.promo_id == promo_id:
            return promotion
    return None


# Get customer by ID
def get_customer(customer_id):
    return customers.get(customer_id)


def get_unauthorized_response(message=None):
    if message:
        return make_response(jsonify(message=message), 401)

    return make_response(jsonify(message=f"Unauthorized"), 401)


# Define a custom Flask decorator for JWT authentication
def requires_auth(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        # Get JWT access token from the Authorization header
        authz_header = request.headers.get('Authorization')
        if not authz_header:
            abort(get_unauthorized_response())

        if len(authz_header.split()) != 2:
            abort(get_unauthorized_response())

        token = authz_header.split()[1]
        if not token:
            abort(get_unauthorized_response())  # Unauthorized

        try:
            public_key = get_public_key(token)
            # Decode JWT access token and verify signature using the public key
            jwt.decode(token, public_key, algorithms=['RS256'], audience=AUD, verify=True)
        except:
            abort(401)  # Unauthorized

        return f(*args, **kwargs)

    return decorated

def get_public_key(token):

    global asgardeo_public_key
    if asgardeo_public_key is not None:
        return asgardeo_public_key

    jwks_client = PyJWKClient(JWKS_URL)
    signing_key = jwks_client.get_signing_key_from_jwt(token)
    asgardeo_public_key = signing_key.key
    return asgardeo_public_key

def authorize(required_scopes):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            token = request.headers.get('Authorization').split()[1]
            if not token:
                abort(401)  # Unauthorized

            decoded_token = jwt.decode(token, options={"verify_signature": False})

            if 'scope' not in decoded_token:
                decoded_token['scope'] = []
            for required_scope in required_scopes:
                if required_scope not in decoded_token['scope']:
                    return jsonify({'message': 'Insufficient Scopes'}), 401
            return func(*args, **kwargs)

        return wrapper

    return decorator


# API endpoints
@app.route('/devices', methods=['GET'])
@requires_auth
@authorize(required_scopes=['devices_list'])
def get_devices():
    return json.dumps([device.__dict__ for device in devices.values()], cls=DeviceEncoder), 200, {
        'content-type': 'application/json'}


@app.route('/devices/<string:device_id>', methods=['GET'])
@requires_auth
@authorize(required_scopes=['devices_list'])
def get_device_by_id(device_id):
    device = get_device(device_id)
    if device:
        return json.dumps(device, cls=DeviceEncoder), 200, {'content-type': 'application/json'}
    else:
        return jsonify({'message': 'Device not found'}), 404


# Search device by name
@app.route('/devices/search/<string:device_name>', methods=['GET'])
@requires_auth
@authorize(required_scopes=['devices_list'])
def search_device_by_name(device_name):
    device_list = []
    for device_id, device in devices.items():
        if device_name.lower() in device.name.lower():
            device_list.append(device)
    return json.dumps(device_list, cls=DeviceEncoder), 200, {'content-type': 'application/json'}


@app.route('/devices', methods=['POST'])
@requires_auth
@authorize(required_scopes=['devices_add'])
def add_device():
    device_data = request.get_json()
    # generate a uuid for the device as a string
    device_id = f'{uuid.uuid1()}'
    if 'name' not in device_data or 'image_uri' not in device_data or 'qty' not in device_data or \
            'description' not in device_data or 'price' not in device_data:
        return jsonify({'message': 'Missing required fields'}), 400
    promo_id_list = []
    if 'promo_id' in device_data:
        promo_id_list = device_data['promo_id']
    new_device = Device(device_id, device_data['name'], device_data['image_uri'], device_data['qty'],
                        device_data['description'], device_data['price'], promo_id_list)
    devices[device_id] = new_device
    return jsonify(new_device.__dict__), 201


@app.route('/devices/<string:device_id>', methods=['PUT', 'PATCH'])
@requires_auth
@authorize(required_scopes=['devices_modify'])
def update_device(device_id):
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

    devices[device_id] = device
    return jsonify(device.__dict__), 200


@app.route('/devices/<string:device_id>', methods=['DELETE'])
@requires_auth
@authorize(required_scopes=['devices_delete'])
def delete_device(device_id):
    # check if device exists
    if device_id in devices:
        devices.pop(device_id)
        return jsonify({'message': f"Device with ID {device_id} deleted successfully"})
    else:
        response = make_response(jsonify(message=f"Device with ID {device_id} not found"), 404)
        abort(response)


@app.route('/promotions', methods=['GET'])
@requires_auth
@authorize(required_scopes=['promotions_list'])
def get_promotions():
    return json.dumps({"promotions": promotions}, cls=PromotionEncoder), 200, {'content-type': 'application/json'}


@app.route('/promotions/<int:promo_id>', methods=['GET'])
@requires_auth
@authorize(required_scopes=['promotions_list'])
def get_promotion_by_id(promo_id):
    promotion = get_promotion(promo_id)
    if promotion:
        return json.dumps(promotion, cls=PromotionEncoder), 201, {'content-type': 'application/json'}
    else:
        return jsonify({'message': 'Promotion not found'}), 404


@app.route('/promotions', methods=['POST'])
@requires_auth
@authorize(required_scopes=['promotions_add'])
def add_promotion():
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
@authorize(required_scopes=['promotions_modify'])
def update_promotion(promo_id):
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
@authorize(required_scopes=['promotions_delete'])
def delete_promotion(promo_id):
    promotion = [p for p in promotions if p.promo_id == promo_id]
    if len(promotion) == 0:
        abort(404, f"Promotion with ID {promo_id} not found")

    promotions.remove(promotion[0])
    return jsonify({'message': f"Promotion with ID {promo_id} deleted successfully"})


# Add promotion to device
@app.route('/promotions/devices', methods=['POST'])
@requires_auth
@authorize(required_scopes=['promotions_modify'])
def add_promotion_to_device():
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
@app.route('/sales_trends')
@requires_auth
@authorize(required_scopes=['sales_trends_view'])
def sales_activity():
    return 'Access granted!'


@app.route('/customers', methods=['GET'])
@requires_auth
@authorize(required_scopes=['customers_list'])
def get_customers():
    return json.dumps([customer.__dict__ for customer in customers.values()]), 200, {'content-type': 'application/json'}


@app.route('/customers', methods=['POST'])
@requires_auth
@authorize(required_scopes=['customers_add'])
def add_customer():
    # customer_data = request.get_json()
    # # generate a uuid for the device as a string
    # device_id = f'{uuid.uuid1()}'
    # if 'name' not in device_data or 'image_uri' not in device_data or 'qty' not in device_data or \
    #         'description' not in device_data or 'price' not in device_data:
    #     return jsonify({'message': 'Missing required fields'}), 400
    # promo_id_list = []
    # if 'promo_id' in device_data:
    #     promo_id_list = device_data['promo_id']
    # new_device = Device(device_id, device_data['name'], device_data['image_uri'], device_data['qty'],
    #                     device_data['description'], device_data['price'], promo_id_list)
    # devices.append(new_device)
    return jsonify({'customer': "oops"}), 201


@app.route('/customers/<string:customer_id>', methods=['PATCH'])
@requires_auth
@authorize(required_scopes=['customers_modify'])
def update_customer(customer_id):
    customer = get_customer(customer_id)
    if not customer:
        return jsonify({'message': 'Customer not found'}), 404

    # device_data = request.get_json()
    # if 'name' in device_data:
    #     device.name = device_data['name']
    # if 'image_uri' in device_data:
    #     device.image_uri = device_data['image_uri']
    # if 'qty' in device_data:
    #     device.qty = device_data['qty']
    # if 'description' in device_data:
    #     device.description = device_data['description']
    # if 'price' in device_data:
    #     device.price = device_data['price']
    # if 'promo_id' in device_data:
    #     device.promo_id = device_data['promo_id']

    return jsonify({'device': customer.__dict__}), 200



@app.route('/update/<string:user_id>', methods=['PATCH'])
@requires_auth
@authorize(required_scopes=[])
def update_user(user_id):
    get_token("internal_login")
    print(ACCESS_TOKEN)

    # return jsonify({'device': customer.__dict__}), 200
    return jsonify({'message': 'Updated'}), 200


def get__new_access_token(scopes):
    # Define the request URL
    url = "https://api.asgardeo.io/t/kfonebusiness/oauth2/token"

    # Define the request headers
    headers = {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": f"Basic {base64.b64encode(f'{ADMIN_CLIENT_ID}:{ADMIN_CLIENT_SECRET}'.encode()).decode()}"
    }

    # Define the request body
    data = {
        "grant_type": "client_credentials",
        "scope": f"{scopes}"
    }

    # Send the request and retrieve the response
    response = requests.post(url, headers=headers, data=data)

    # Check if the response was successful
    if response.status_code == 200:
        # Retrieve the access token from the response body
        access_token = response.json()["access_token"]

        # Return the access token
        ACCESS_TOKEN[scopes] = access_token
    else:
        # Raise an exception if the response was not successful
        response.raise_for_status()

def get_token(scopes):
    if scopes in ACCESS_TOKEN:
        decoded_token = jwt.decode(ACCESS_TOKEN[scopes], options={"verify_signature": False})
        if decoded_token['exp'] < time.time():
            get__new_access_token(scopes)
        return ACCESS_TOKEN[scopes]
    else:
        get__new_access_token(scopes)
        return ACCESS_TOKEN[scopes]

if __name__ == '__main__':
    app.run(port=3000)
