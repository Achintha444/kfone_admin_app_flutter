import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kfone_admin_app_flutter/util/model/session_token.dart';
import 'package:kfone_admin_app_flutter/util/ui_util.dart';

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
            await SecureStorageController.storeToken(
              response as AuthorizationTokenResponse,
            )
                .then((value) => emit(
                      SigninSuccess(
                        sessionToken: SessionToken(
                          accessToken: response.accessToken,
                          idToken: response.idToken,
                          accessTokenExpirationDateTime:
                              response.accessTokenExpirationDateTime,
                        ),
                      ),
                    ))
                .catchError((err) {
                  print(err);
              emit(SigninFail());
            });
          },
        ).catchError(
          (err) {
            if (err is PlatformException) {
              if (err.message == UiUtil.getInitialUnauthorizedMessage()) {
                emit(InitialUnauthorized());
                return;
              }
            }
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
      final String? accessTokenExpirationDateTimeString =
          await SecureStorageController.getAccessTokenExpirationDateTime();

      if (accessToken != null &&
          idToken != null &&
          accessTokenExpirationDateTimeString != null) {
        bool isAccessTokenExpired =
            await SecureStorageController.isAccessTokenExpired();
        if (isAccessTokenExpired) {
          await SecureStorageController.clearLocalStorage()
              .then((value) => emit(Initial()))
              .catchError((err) => emit(Initial()));

          return;
        }

        // emit the success state if the locally stored access token is valid
        emit(
          SigninSuccess(
            sessionToken: SessionToken(
                accessToken: accessToken,
                idToken: idToken,
                accessTokenExpirationDateTime:
                    DateTime.parse(accessTokenExpirationDateTimeString)),
          ),
        );
        return;
      }

      emit(Initial());
    });
  }
}
