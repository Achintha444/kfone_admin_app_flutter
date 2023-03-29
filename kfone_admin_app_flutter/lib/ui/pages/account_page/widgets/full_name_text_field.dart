import 'package:flutter/material.dart';

class FullNameTextField extends StatelessWidget {
  final TextEditingController controller;
  final String parameter;
  final String value;

  const FullNameTextField({
    Key? key,
    required this.parameter,
    required this.value,
    required this.controller,
  }) : super(key: key);

  IconData _getIconDataForParameter(String parameter) {
    switch (parameter) {
      case "id":
        return Icons.person;

      case "email/username":
        return Icons.email;

      case "fullName":
        return Icons.person_pin_rounded;

      case "username":
        return Icons.person_pin_circle;

      default:
        return Icons.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: double.infinity,
        child: Icon(
          _getIconDataForParameter(parameter),
        ),
      ),
      dense: true,
      title: Text(
        parameter,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black38,
        ),
      ),
      subtitle: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a value';
          }
          return null;
        },
      ),
      style: ListTileStyle.list,
    );
  }
}
