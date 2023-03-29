import 'package:flutter/material.dart';

class UnauthorizedWidget extends StatelessWidget {
  const UnauthorizedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.lock,
            size: 50.0,
            color: Colors.grey,
          ),
          SizedBox(height: 16.0),
          Text(
            "Unauthorized",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}