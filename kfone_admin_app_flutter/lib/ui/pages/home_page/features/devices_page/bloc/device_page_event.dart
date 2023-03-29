part of 'device_page_bloc.dart';

abstract class DevicePageEvent extends Equatable {
  const DevicePageEvent();

  @override
  List<Object> get props => [];
}

class DevicePageCheckAccess extends DevicePageEvent {
  final DrawerItem drawerItem;

  const DevicePageCheckAccess({required this.drawerItem});

  @override
  List<Object> get props => [drawerItem];
}

class GetDevices extends DevicePageEvent {}

class CreateDevice extends DevicePageEvent {
  final String name;
  final String imageUri;
  final int qty;
  final String description;
  final double price;

  const CreateDevice({
    required this.name,
    required this.imageUri,
    required this.qty,
    required this.description,
    required this.price,
  });

  @override
  List<Object> get props => [
        name,
        imageUri,
        qty,
        description,
        price,
      ];
}
