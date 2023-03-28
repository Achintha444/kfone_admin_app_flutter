part of 'device_page_bloc.dart';

abstract class DevicePageEvent extends Equatable {
  const DevicePageEvent();

  @override
  List<Object> get props => [];
}

class GetDevices extends DevicePageEvent {}