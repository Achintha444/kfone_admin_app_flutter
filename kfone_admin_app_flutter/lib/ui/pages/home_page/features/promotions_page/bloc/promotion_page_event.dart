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

class CreatePromtion extends PromotionPageEvent {
  final String promoCode;
  final double discount;

  const CreatePromtion({ required this.promoCode, required this.discount });

  @override
  List<Object> get props => [promoCode, discount];
}