part of 'promotion_page_bloc.dart';

abstract class PromotionPageEvent extends Equatable {
  const PromotionPageEvent();

  @override
  List<Object> get props => [];
}

class GetPromotions extends PromotionPageEvent {
  final DrawerItem drawerItem;

  const GetPromotions({required this.drawerItem});

  @override
  List<Object> get props => [drawerItem];
}
