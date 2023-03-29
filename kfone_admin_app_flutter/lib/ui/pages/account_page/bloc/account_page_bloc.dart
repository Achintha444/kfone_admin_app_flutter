import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kfone_admin_app_flutter/controller/secure_storage_controller/secure_storage_controller.dart';
import 'package:kfone_admin_app_flutter/util/model/session_token.dart';

import '../../../../controller/login_controller/login_controller.dart';
import '../../../../controller/user_details_controller/user_details_controller.dart';
import '../../../../model/user.dart';

part 'account_page_event.dart';
part 'account_page_state.dart';

class AccountPageBloc extends Bloc<AccountPageEvent, AccountPageState> {
  AccountPageBloc() : super(AccountPageInitial()) {
    on<GetUserInfo>((event, emit) async {
      emit(AccountPageLoading());

      await UserDetailsController.getUserDetails(event.sessionToken)
          .then(
            (value) => emit(UserInfoSucess(user: value)),
          )
          .catchError((err) => emit(UserInfoFail()));
    });
    on<UpdateUserInfo>((event, emit) async {
      emit(AccountPageLoading());

      await UserDetailsController.updateUserDetails(event.id, event.fullName)
          .then(
            (value) => emit(UserUpdatedSucess()),
          )
          .catchError((err) => emit(UserUpdatedFail()));
    });
    on<Signout>((event, emit) async {
      emit(AccountPageLoading());

      await SecureStorageController.clearLocalStorage().then(
        (value) async {
          await LoginController.logoutAction(event.sessionToken)
              .then(
                (value) => emit(SignoutSuccess()),
              )
              .catchError((err) => emit(SignoutFail()));
        },
      ).catchError((err) {
        emit(SignoutFail());
      });
    });
  }
}
