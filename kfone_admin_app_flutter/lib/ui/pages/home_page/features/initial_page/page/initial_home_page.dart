import 'package:flutter/material.dart';
import 'package:kfone_admin_app_flutter/ui/widgets/common/resizable_image.dart';

class InitialHomePage extends StatelessWidget {
  const InitialHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          Spacer(),
          ResizableImage(
            fit: BoxFit.fitHeight,
            imageLocation: 'assets/images/logo.png',
            height: 50.0,
          ),
          SizedBox(height: 10.0),
          ResizableImage(
            fit: BoxFit.fitHeight,
            imageLocation: 'assets/images/teams.png',
            height: 250.0,
          ),
          Spacer(),
          Text(
            "Kfone Administrator Application",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10.0),
          Text(
            "Kfone admin app designed for administrators to manage and oversee various aspects the business. This provides a dashboard or control panel that allows administrators to view data and manage different functionalities such as user accounts, content, products, and services.",
            textAlign: TextAlign.center,
          ),
          Spacer(),
        ],
      ),
    );
  }
}
