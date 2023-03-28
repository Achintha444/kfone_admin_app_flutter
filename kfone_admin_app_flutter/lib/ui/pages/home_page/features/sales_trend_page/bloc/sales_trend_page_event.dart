part of 'sales_trend_page_bloc.dart';

abstract class SalesTrendPageEvent extends Equatable {
  const SalesTrendPageEvent();

  @override
  List<Object> get props => [];
}

class GetSalesTrend extends SalesTrendPageEvent {
  final DrawerItem drawerItem;

  const GetSalesTrend({required this.drawerItem});

  @override
  List<Object> get props => [drawerItem];
}