import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final bool isPrimary;
  final String buttonText;
  final ButtonStyle? buttonStyle;
  final void Function() onPressed;

  const ActionButton({
    Key? key,
    this.isPrimary = true,
    required this.buttonText,
    required this.onPressed,
    this.buttonStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: _buildButton(),
    );
  }

  Widget _buildButton() {
    if (isPrimary) {
      return ElevatedButton(
        onPressed: onPressed,
        style: buttonStyle,
        child: Text(buttonText),
      );
    }
    return OutlinedButton(
      onPressed: onPressed,
      style: buttonStyle,
      child: Text(buttonText),
    );
  }
}
