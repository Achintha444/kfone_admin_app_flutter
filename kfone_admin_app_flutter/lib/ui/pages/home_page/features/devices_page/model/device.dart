import 'dart:convert';

import 'package:equatable/equatable.dart';

class Device extends Equatable {
  final String id;
  final String name;
  final String imageUri;
  final int qty;
  final String description;
  final double price;
  final List<int> promos;

  const Device({
    required this.id,
    required this.name,
    required this.imageUri,
    required this.qty,
    required this.description,
    required this.price,
    required this.promos,
  });

  @override
  List<Object?> get props => [id, name, imageUri, qty, description, price, promos];

  /// return `User` object from a relevant json string
  static Device fromJsonString(String jsonString) {
    Map<String, dynamic> deviceMap = jsonDecode(jsonString);

    return Device(
      id: deviceMap["device_id"] ?? "",
      name: deviceMap["name"] ?? "",
      imageUri: deviceMap["image_uri"] ?? "",
      qty: int.parse(deviceMap["qty"].toString()),
      description: deviceMap["descriptions"] ?? "",
      price: double.parse(deviceMap["price"].toString()),
      promos: deviceMap["promo_id_list"] != null ? List<int>.from(deviceMap["promo_id_list"]) : [],
    );
  }

  /// return a list of Device objects from a list of json string
  static List<Device> fromJsonList(String jsonString) {
    List<dynamic> deviceList = jsonDecode(jsonString);
    List<Device> devices = [];

    for (var device in deviceList) {
      devices.add(Device.fromJsonString(jsonEncode(device)));
    }

    return devices;
  }
  
}
