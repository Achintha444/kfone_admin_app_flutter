import 'package:equatable/equatable.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../controller/login_controller/login_controller.dart';
import '../../../../controller/user_details_controller/user_details_controller.dart';
import '../../../../model/user.dart';

part 'account_page_event.dart';
part 'account_page_state.dart';

class AccountPageBloc extends Bloc<AccountPageEvent, AccountPageState> {
  AccountPageBloc() : super(Initial()) {
    on<GetUserInfo>((event, emit) async {
      emit(Loading());

      await UserDetailsController.getUserDetails(event.authorizationTokenResponse).then(
        (value) => emit(UserInfoSucess(user: value)),
      ).catchError((err) => emit(UserInfoFail()));
    });
    on<Signout>((event, emit) async {
      emit(Loading());

      await LoginController.logoutAction(event.authorizationTokenResponse).then(
        (value) => emit(SignoutSuccess()),
      ).catchError((err) => emit(SignoutFail()));
    });
  }
}
