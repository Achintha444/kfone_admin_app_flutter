part of 'sales_trend_page_bloc.dart';

abstract class SalesTrendPageState extends Equatable {
  const SalesTrendPageState();
  
  @override
  List<Object> get props => [];
}

class SalesTrendPageInitial extends SalesTrendPageState {}

class SalesTrendPageLoading extends SalesTrendPageState {}

class SalesTrendPageError extends SalesTrendPageState {}

class SalesTrendPageUnauthorized extends SalesTrendPageState {}

class GetSalesTrendSucess extends SalesTrendPageState {}
