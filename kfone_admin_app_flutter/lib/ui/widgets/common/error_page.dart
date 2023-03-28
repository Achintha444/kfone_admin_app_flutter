import 'package:flutter/material.dart';

import 'action_button.dart';

class ErrorPage extends StatelessWidget {
  final String buttonText;
  final Function onPressed;

  const ErrorPage({
    Key? key,
    required this.buttonText,
    required this.onPressed,
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
            buttonText: buttonText,
            onPressed: () => onPressed(),
          ),
        ],
      ),
    );
  }
}
