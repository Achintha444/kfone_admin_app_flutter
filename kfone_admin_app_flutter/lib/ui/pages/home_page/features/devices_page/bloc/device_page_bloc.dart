import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kfone_admin_app_flutter/controller/devices_controller/devices_controller.dart';
import 'package:kfone_admin_app_flutter/controller/user_details_controller/user_details_controller.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/models/drawer_item.dart';
import 'package:kfone_admin_app_flutter/util/ui_util.dart';

import '../model/device.dart';

part 'device_page_event.dart';
part 'device_page_state.dart';

class DevicePageBloc extends Bloc<DevicePageEvent, DevicePageState> {
  DevicePageBloc() : super(DevicePageInitial()) {
    on<DevicePageCheckAccess>((event, emit) async {
      emit(DevicePageLoading());

      List<String> scopes = await event.drawerItem.scopes;
      List<String> userScopes = await UserDetailsController.getUserScopes();

      // check if the user has the required scopes to access this page
      if (UiUtil.compareLists(userScopes, scopes)) {
        emit(DevicePageUnauthorized());
        throw Exception('Failed to get devices details');
      } else {
        emit(DevicePageUnauthorized());
        throw Exception('Failed to get devices details');
      }
    });
    on<GetDevices>((event, emit) async {
      emit(DevicePageLoading());

      await DevicesController.getDevices().then((value) {
        emit(GetDevicesSucess(devices: value));
        // ignore: invalid_return_type_for_catch_error
      }).catchError((err) => emit(DevicePageError()));
    });
    on<CreateDevice>((event, emit) async {
      emit(DevicePageLoading());

      Device device = Device(
        name: event.name,
        imageUri: event.imageUri,
        price: event.price,
        description: event.description,
        qty: event.qty,
      );

      await DevicesController.createDevice(device)
          .then((value) => emit(CreateDeviceSuccess()))
          .catchError((err) => emit(DevicePageError()));
    });
  }
}
