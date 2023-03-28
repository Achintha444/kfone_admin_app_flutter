import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kfone_admin_app_flutter/controller/devices_controller/devices_controller.dart';

import '../model/device.dart';

part 'device_page_event.dart';
part 'device_page_state.dart';

class DevicePageBloc extends Bloc<DevicePageEvent, DevicePageState> {
  DevicePageBloc() : super(DevicePageInitial()) {
    on<GetDevices>((event, emit) async {
      emit(DevicePageLoading());

      await DevicesController.getDevices().then((value) {
        emit(GetDevicesSucess(devices: value));
      // ignore: invalid_return_type_for_catch_error
      }).catchError((err) => emit(DevicePageError()));
    });
  }
}
