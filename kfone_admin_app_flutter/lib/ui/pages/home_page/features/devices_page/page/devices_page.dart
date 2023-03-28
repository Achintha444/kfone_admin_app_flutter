import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/features/devices_page/bloc/device_page_bloc.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/features/devices_page/widgets/devices_table.dart';
import 'package:kfone_admin_app_flutter/ui/widgets/common/unauthorized_widget.dart';

import '../../../../../widgets/common/error_page.dart';
import '../../../models/drawer_item.dart';

class DevicesPage extends StatelessWidget {
  final DrawerItem drawerItem;

  const DevicesPage({
    super.key,
    required this.drawerItem,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DevicePageBloc()
        ..add(
          GetDevices(drawerItem: drawerItem),
        ),
      child: BlocBuilder<DevicePageBloc, DevicePageState>(
          builder: (context, state) {
        if (state is DevicePageInitial || state is DevicePageLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetDevicesSucess) {
          return DevicesTable(
            devices: state.devices,
          );
        } else if (state is DevicePageUnauthorized) {
          return const UnauthorizedWidget();
        } else {
          return ErrorPage(
            buttonText: 'Try Again',
            onPressed: () {},
          );
        }
      }),
    );
  }
}
