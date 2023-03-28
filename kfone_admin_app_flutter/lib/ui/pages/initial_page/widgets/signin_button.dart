import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/common/action_button.dart';
import '../bloc/inital_page_bloc.dart';

class SigninButton extends StatelessWidget {
  const SigninButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ActionButton(
      buttonText: "Sign In",
      onPressed: () {
        context.read<InitalPageBloc>().add(Signin());
      },
    );
  }
}
