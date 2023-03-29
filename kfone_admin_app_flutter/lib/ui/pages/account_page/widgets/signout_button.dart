import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kfone_admin_app_flutter/util/model/session_token.dart';

import '../../../widgets/common/action_button.dart';
import '../bloc/account_page_bloc.dart';

class SignoutButton extends StatelessWidget {
  final SessionToken sessionToken;

  const SignoutButton({
    super.key,
    required this.sessionToken,
  });

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      isPrimary: false,
      buttonText: "Sign Out",
      onPressed: () {
        context.read<AccountPageBloc>().add(Signout(sessionToken: sessionToken));
      },
    );
  }
}
