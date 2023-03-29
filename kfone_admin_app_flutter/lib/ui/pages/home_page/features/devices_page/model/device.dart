import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Device extends Equatable {
  String? id;
  final String name;
  final String imageUri;
  final int qty;
  final String description;
  final double price;

  Device({
    this.id,
    required this.name,
    required this.imageUri,
    required this.qty,
    required this.description,
    required this.price,
    List<int>? promos,
  });

  @override
  List<Object?> get props => [name, imageUri, qty, description, price];

  /// return `Device` object from a relevant json string
  static Device fromJsonString(String jsonString) {
    Map<String, dynamic> deviceMap = jsonDecode(jsonString);

    return Device(
      id: deviceMap["device_id"] ?? "",
      name: deviceMap["name"] ?? "",
      imageUri: deviceMap["image_uri"] ?? "",
      qty: int.parse(deviceMap["qty"].toString()),
      description: deviceMap["description"] ?? "",
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

  /// return a json string from a Device object
  String toJsonString() {
    return jsonEncode({
      "name": name,
      "image_uri": imageUri,
      "qty": qty,
      "description": description,
      "price": price
    });
  }
  
}
