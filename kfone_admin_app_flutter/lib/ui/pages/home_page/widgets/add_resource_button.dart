import 'package:flutter/material.dart';

class AddResourceButton extends StatelessWidget {
  final String tooltip;
  final Function onPressed;

  const AddResourceButton({
    super.key,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => onPressed(),
      tooltip: "",
      child: const Icon(Icons.add),
    );
  }
}
