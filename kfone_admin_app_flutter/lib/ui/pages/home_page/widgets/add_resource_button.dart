import 'package:flutter/material.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/features/devices_page/page/device_add_page.dart';

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
      onPressed: () {
        Navigator.pushNamed(
          context,
          DeviceAddPage.routeName,
        );
      },
      tooltip: "",
      child: const Icon(Icons.add),
    );
  }
}
