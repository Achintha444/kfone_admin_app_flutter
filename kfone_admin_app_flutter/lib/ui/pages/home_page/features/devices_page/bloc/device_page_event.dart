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

class UpdateDevice extends DevicePageEvent {
  final String id;
  final String name;
  final String imageUri;
  final int qty;
  final String description;
  final double price;

  const UpdateDevice({
    required this.id,
    required this.name,
    required this.imageUri,
    required this.qty,
    required this.description,
    required this.price,
  });

  @override
  List<Object> get props => [
        id,
        name,
        imageUri,
        qty,
        description,
        price,
      ];
}

class DeleteDevice extends DevicePageEvent {
  final String id;

  const DeleteDevice({required this.id});

  @override
  List<Object> get props => [id];
}
