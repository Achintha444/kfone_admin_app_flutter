import 'dart:convert';

import 'package:equatable/equatable.dart';

class Promotion extends Equatable {
  final String id;
  final String code;
  final double discount;
  final List<String> tiers;
  final List<String> devices;

  const Promotion({
    required this.id,
    required this.code,
    required this.discount,
    required this.tiers,
    required this.devices,
  });

  @override
  List<Object?> get props =>
      [id, code, discount, tiers, devices];

  /// return `Promotion` object from a relevant json string
  static Promotion fromJsonString(String jsonString) {
    Map<String, dynamic> promotionMap = jsonDecode(jsonString);

    return Promotion(
      id: promotionMap["promo_id"].toString(),
      code: promotionMap["promo_code"],
      discount: double.parse(promotionMap["discount"].toString()),
      tiers: promotionMap["tiers"] != null ? List<String>.from(promotionMap["tiers"]) : [],
      devices: promotionMap["devices"] != null ? List<String>.from(promotionMap["devices"]) : [],
    );
  }

  /// return a list of Promotions objects from a list of json string
  static List<Promotion> fromJsonList(String jsonString) {
    List<dynamic> promotionList = jsonDecode(jsonString)['promotions'];
    List<Promotion> promotions = [];

    for (var promotion in promotionList) {
      promotions.add(Promotion.fromJsonString(jsonEncode(promotion)));
    }

    return promotions;
  }
}
