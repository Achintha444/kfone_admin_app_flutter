import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/features/devices_page/bloc/device_page_bloc.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/features/devices_page/widgets/devices_table.dart';

import '../../../../../widgets/common/error_page.dart';

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DevicePageBloc()
        ..add(
          GetDevices(),
        ),
      child: BlocBuilder<DevicePageBloc, DevicePageState>(
          builder: (context, state) {
        if (state is DevicePageInitial || state is DevicePageLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetDevicesSucess) {
          return DevicesTable(
            devices: state.devices,
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
