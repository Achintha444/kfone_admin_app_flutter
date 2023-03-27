import 'package:equatable/equatable.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kfone_admin_app_flutter/util/model/session_token.dart';

import '../../../../controller/login_controller/login_controller.dart';
import '../../../../controller/secure_storage_controller/secure_storage_controller.dart';

part 'inital_page_event.dart';
part 'inital_page_state.dart';

class InitalPageBloc extends Bloc<InitalPageEvent, InitalPageState> {
  InitalPageBloc() : super(Initial()) {
    on<Signin>(
      (event, emit) async {
        emit(Loading());

        await LoginController.loginAction().then(
          (response) async {
            try {
              await SecureStorageController.storeToken(
                response as AuthorizationTokenResponse,
              )
              .then(
                (value) => emit(
                  SigninSuccess(
                    sessionToken: SessionToken(
                      accessToken: response.accessToken,
                      idToken: response.idToken,
                    ),
                  ),
                ),
              )
              .catchError(
                (err) {
                  emit(SigninFail());
                },
              );
            } catch (e) {
              emit(SigninFail());
            }
          },
        ).catchError(
          (err) {
            emit(SigninFail());
          },
        );
      },
    );

    on<InitialSignin>((event, emit) async {
      emit(Loading());

      final String? accessToken =
          await SecureStorageController.getAccessToken();
      final String? idToken = await SecureStorageController.getIdToken();

      if (accessToken is String && idToken is String) {
        emit(SigninSuccess(
            sessionToken:
                SessionToken(accessToken: accessToken, idToken: idToken)));
        return;
      }

      emit(Initial());
    });
  }
}
