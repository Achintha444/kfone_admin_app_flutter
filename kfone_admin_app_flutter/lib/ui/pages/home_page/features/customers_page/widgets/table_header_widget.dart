import 'package:flutter/material.dart';

class TableHeaderWidget extends StatelessWidget {
  final String label;

  const TableHeaderWidget({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        label,
        style: const TextStyle(fontStyle: FontStyle.italic),
      ),
    );
  }
}
