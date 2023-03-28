part of 'inital_page_bloc.dart';

abstract class InitalPageState extends Equatable {
  const InitalPageState();

  @override
  List<Object> get props => [];
}

class Initial extends InitalPageState {}

class Loading extends InitalPageState {}

class SigninSuccess extends InitalPageState {
  final SessionToken sessionToken;

  const SigninSuccess({required this.sessionToken});

   @override
  List<Object> get props => [sessionToken];
}

class SigninFail extends InitalPageState {}
