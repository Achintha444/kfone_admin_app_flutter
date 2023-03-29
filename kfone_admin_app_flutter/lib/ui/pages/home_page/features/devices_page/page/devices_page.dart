import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/features/devices_page/bloc/device_page_bloc.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/features/devices_page/widgets/devices_table.dart';
import 'package:kfone_admin_app_flutter/ui/widgets/common/unauthorized_widget.dart';

import '../../../../../widgets/common/error_page.dart';
import '../../../bloc/home_page_bloc.dart';
import '../../../models/drawer_item.dart';

class DevicesPage extends StatelessWidget {
  final DrawerItem drawerItem;

  const DevicesPage({
    super.key,
    required this.drawerItem,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomePageBloc>(
          create: (BuildContext context) => HomePageBloc()
            ..add(
              CheckAccess(drawerItem: drawerItem),
            ),
        ),
        BlocProvider<DevicePageBloc>(
          create: (BuildContext context) => DevicePageBloc()
            ..add(
              GetDevices(),
            ),
        ),
      ],
      child:
          BlocBuilder<HomePageBloc, HomePageState>(builder: (context, state) {
        if (state is HomePageInitial || state is Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is Authorized) {
          return _createBody();
        } else if (state is Unauthorized) {
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

  BlocListener<DevicePageBloc, DevicePageState> _createBody() {
    return BlocListener<DevicePageBloc, DevicePageState>(
      listener: (context, state) {
        if(state is CreateDeviceSuccess) {
          context.read<DevicePageBloc>().add(GetDevices());
        }
      },
      child: BlocBuilder<DevicePageBloc, DevicePageState>(
          builder: (context, state) {
        if (state is DevicePageInitial || state is DevicePageLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetDevicesSucess) {
          return DevicesTable(
            devices: state.devices.reversed.toList(),
          );
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
