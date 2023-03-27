import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/common/action_button.dart';
import '../bloc/account_page_bloc.dart';

class ProfileError extends StatelessWidget {
  final AuthorizationTokenResponse authorizationTokenResponse;

  const ProfileError({
    Key? key,
    required this.authorizationTokenResponse,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Error occured, Try Again!"),
          const SizedBox(height: 10),
          ActionButton(
            buttonText: "Try Again",
            onPressed: () {
              context.read<AccountPageBloc>().add(
                    GetUserInfo(
                      authorizationTokenResponse: authorizationTokenResponse,
                    ),
                  );
            },
          ),
        ],
      ),
    );
  }
}
