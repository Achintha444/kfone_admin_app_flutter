import 'package:kfone_admin_app_flutter/ui/pages/home_page/models/drawer_item.dart';
import 'package:kfone_admin_app_flutter/util/model/session_token.dart';

class PromotionAddPageArguments {
  final DrawerItem drawerItem;
  final SessionToken sessionToken;

  PromotionAddPageArguments(this.drawerItem, this.sessionToken);
}