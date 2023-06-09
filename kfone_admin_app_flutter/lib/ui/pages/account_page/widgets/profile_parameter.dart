import 'package:flutter/material.dart';

class ProfileParameter extends StatelessWidget {
  final String parameter;
  final String value;

  const ProfileParameter({
    Key? key,
    required this.parameter,
    required this.value,
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
      subtitle: Text(
        value,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
      ),
      style: ListTileStyle.list,
    );
  }
}
