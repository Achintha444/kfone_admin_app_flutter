import 'package:flutter/material.dart';

import '../page/initial_page.dart';

class UnauthorizedWidget extends StatelessWidget {
  const UnauthorizedWidget({super.key});

  void _onTap(BuildContext context) {
    Navigator.pushNamed(context, InitialPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const Icon(
            Icons.warning_rounded,
            size: 100,
            color: Colors.red,
          ),
          const SizedBox(height: 16.0),
          const Text(
            "You are not authorized to login to this application.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => _onTap(context),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: Colors.redAccent),
              ),
              child: const Icon(
                Icons.arrow_back,
                size: 30.0,
                color: Colors.redAccent,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
