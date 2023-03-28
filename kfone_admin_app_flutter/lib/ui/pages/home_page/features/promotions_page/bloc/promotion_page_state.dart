part of 'promotion_page_bloc.dart';

abstract class PromotionPageState extends Equatable {
  const PromotionPageState();
  
  @override
  List<Object> get props => [];
}

class PromotionPageInitial extends PromotionPageState {}

class PromotionPageLoading extends PromotionPageState {}

class PromotionPageError extends PromotionPageState {}

class PromotionPageUnauthorized extends PromotionPageState {}

class GetPromotionsSucess extends PromotionPageState {
  final List<Promotion> promotions;

  const GetPromotionsSucess({required this.promotions});

  @override
  List<Object> get props => [promotions];
}

