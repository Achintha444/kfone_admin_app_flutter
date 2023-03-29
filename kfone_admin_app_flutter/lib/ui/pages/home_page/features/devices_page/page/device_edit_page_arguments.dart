import 'package:kfone_admin_app_flutter/ui/pages/home_page/models/drawer_item.dart';
import 'package:kfone_admin_app_flutter/util/model/session_token.dart';

import '../model/device.dart';

class DeviceEditPageArguments {
  final DrawerItem drawerItem;
  final SessionToken sessionToken;
  final Device device;

  DeviceEditPageArguments(this.drawerItem, this.sessionToken, this.device);
}