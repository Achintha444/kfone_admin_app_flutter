import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/common/action_button.dart';
import '../bloc/account_page_bloc.dart';

class SignoutButton extends StatelessWidget {
  final AuthorizationTokenResponse authorizationTokenResponse;

  const SignoutButton({
    super.key,
    required this.authorizationTokenResponse,
  });

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      buttonText: "Sign Out",
      onPressed: () {
        context.read<AccountPageBloc>().add(Signout(authorizationTokenResponse: authorizationTokenResponse));
      },
    );
  }
}
