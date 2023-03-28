import 'package:flutter/material.dart';

class AddResourceButton extends StatelessWidget {
  final String tooltip;

  const AddResourceButton({
    super.key,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        null;
      },
      tooltip: "",
      child: const Icon(Icons.add),
    );
  }
}
