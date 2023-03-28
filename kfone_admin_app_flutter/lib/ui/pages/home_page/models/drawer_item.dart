import 'package:flutter/material.dart';
import 'package:kfone_admin_app_flutter/controller/scopes_controller/scope_controller.dart';

enum DrawerItemTypes { initial, devices, promotions, customers, salesTrends }

class DrawerItem {
  final DrawerItemTypes type;
  final IconData icon;

  const DrawerItem(
      {required this.type, required this.icon});

  Future<List<String>> get scopes async{
    switch (type) {
      case DrawerItemTypes.devices:
        return await ScopeController.getAllScopesOfDeviceInterface();
      case DrawerItemTypes.promotions:
        return await ScopeController.getAllScopesOfPermissionsInterface();
      case DrawerItemTypes.salesTrends:
        return await ScopeController.getAllScopesOfSalesTrendsInterface();
      default:
        return [];
    }
  }
  
  String get itemName {
    switch (type) {
      case DrawerItemTypes.initial:
        return "Home";
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
