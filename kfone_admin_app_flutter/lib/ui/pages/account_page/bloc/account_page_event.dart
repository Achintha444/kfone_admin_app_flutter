part of 'account_page_bloc.dart';

abstract class AccountPageEvent extends Equatable {
  const AccountPageEvent();

  @override
  List<Object> get props => [];
}

class GetUserInfo extends AccountPageEvent {
  final SessionToken sessionToken;

  const GetUserInfo({required this.sessionToken});

  @override
  List<Object> get props => [sessionToken];
}

class Signout extends AccountPageEvent {
  final SessionToken sessionToken;

  const Signout({required this.sessionToken});

  @override
  List<Object> get props => [sessionToken];
}
