import 'package:kfone_admin_app_flutter/ui/pages/home_page/models/drawer_item.dart';
import 'package:kfone_admin_app_flutter/util/model/session_token.dart';

class HomePageArguments {
  final SessionToken sessionToken;
  DrawerItem? drawerItem;

  HomePageArguments(this.sessionToken, {this.drawerItem});
}