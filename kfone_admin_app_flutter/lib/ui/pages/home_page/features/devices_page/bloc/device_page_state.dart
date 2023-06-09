part of 'device_page_bloc.dart';

abstract class DevicePageState extends Equatable {
  const DevicePageState();
  
  @override
  List<Object> get props => [];
}

class DevicePageInitial extends DevicePageState {}

class DevicePageLoading extends DevicePageState {}

class DevicePageError extends DevicePageState {}

class DevicePageAuthorized extends DevicePageState {}

class DevicePageUnauthorized extends DevicePageState {}

class GetDevicesSucess extends DevicePageState {
  final List<Device> devices;

  const GetDevicesSucess({required this.devices});

  @override
  List<Object> get props => [devices];
}

class CreateDeviceSuccess extends DevicePageState {}

class UpdateDeviceSuccess extends DevicePageState {}

class DeleteDeviceSuccess extends DevicePageState {}
