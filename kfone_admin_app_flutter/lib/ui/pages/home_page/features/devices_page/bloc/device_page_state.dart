part of 'device_page_bloc.dart';

abstract class DevicePageState extends Equatable {
  const DevicePageState();
  
  @override
  List<Object> get props => [];
}

class DevicePageInitial extends DevicePageState {}

class DevicePageLoading extends DevicePageState {}

class DevicePageError extends DevicePageState {}

class GetDevicesSucess extends DevicePageState {
  final List<Device> devices;

  const GetDevicesSucess({required this.devices});

  @override
  List<Object> get props => [devices];
}
