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

class UpdateUserInfo extends AccountPageEvent {
  final String id;
  final String fullName;

  const UpdateUserInfo({
    required this.id,
    required this.fullName,
  });

  @override
  List<Object> get props => [id, fullName];
}

class Signout extends AccountPageEvent {
  final SessionToken sessionToken;

  const Signout({required this.sessionToken});

  @override
  List<Object> get props => [sessionToken];
}
