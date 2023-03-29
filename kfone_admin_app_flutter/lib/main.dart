import 'package:flutter/material.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/features/devices_page/page/device_add_page.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/features/promotions_page/page/promotion_add_page.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/page/home_page.dart';

import 'theme/theme.dart';
import 'ui/pages/account_page/page/account_page.dart';
import 'ui/pages/initial_page/page/initial_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kfone Admin App',
      theme: themeData,
      initialRoute: InitialPage.routeName,
      routes: {
        InitialPage.routeName: (context) => const InitialPage(),
        AccountPage.routeName: (context) => const AccountPage(),
        HomePage.routeName: (context) => const HomePage(),
        DeviceAddPage.routeName: (context) => DeviceAddPage(),
        PromotionAddPage.routeName: (context) => PromotionAddPage(),
      },
    );
  }
}
