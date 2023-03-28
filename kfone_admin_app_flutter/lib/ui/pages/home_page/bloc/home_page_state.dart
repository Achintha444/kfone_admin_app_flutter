part of 'home_page_bloc.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();
  
  @override
  List<Object> get props => [];
}

abstract class DrawerState extends Equatable {

  final DrawerItem drawerItem;

  const DrawerState({required this.drawerItem});
  
  @override
  List<Object> get props => [drawerItem];
}

class Initial extends HomePageState {}

class Loading extends HomePageState {}

class DevicesInterface extends HomePageState implements DrawerState{
  
    @override
    final DrawerItem drawerItem;
  
    const DevicesInterface({required this.drawerItem});
}

class CustomersInterface extends HomePageState implements DrawerState{
  
    @override
    final DrawerItem drawerItem;
  
    const CustomersInterface({required this.drawerItem});
}

class PromotionsInterface extends HomePageState implements DrawerState{
  
    @override
    final DrawerItem drawerItem;
  
    const PromotionsInterface({required this.drawerItem});
}

class SalesTrendsInterface extends HomePageState implements DrawerState{
  
    @override
    final DrawerItem drawerItem;
  
    const SalesTrendsInterface({required this.drawerItem});
}