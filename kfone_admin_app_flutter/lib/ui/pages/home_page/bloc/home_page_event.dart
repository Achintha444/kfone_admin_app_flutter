part of 'home_page_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

class NavigateDrawer extends HomePageEvent {
  final DrawerItem drawerItem;

  const NavigateDrawer({required this.drawerItem});

  @override
  List<Object> get props => [drawerItem];
}
