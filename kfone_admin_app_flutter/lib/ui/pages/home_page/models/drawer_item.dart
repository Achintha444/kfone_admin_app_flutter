import 'package:flutter/material.dart';

enum DrawerItemTypes { devices, promotions, customers, salesTrends }

class DrawerItem {
  final DrawerItemTypes type;
  final IconData icon;

  const DrawerItem(
      {required this.type, required this.icon});
  
  String get itemName {
    switch (type) {
      case DrawerItemTypes.devices:
        return "Devices";
      case DrawerItemTypes.promotions:
        return "Promotions";
      case DrawerItemTypes.customers:
        return "Customers";
      case DrawerItemTypes.salesTrends:
        return "Sales Trends";
      default:
        return "";
    }
  }

  String get tooltip {
    switch (type) {
      case DrawerItemTypes.devices:
        return "Add Device";
      case DrawerItemTypes.promotions:
        return "Add Promotion";
      case DrawerItemTypes.customers:
        return "Add Customer";
      default:
        return "";
    }
  }
}
