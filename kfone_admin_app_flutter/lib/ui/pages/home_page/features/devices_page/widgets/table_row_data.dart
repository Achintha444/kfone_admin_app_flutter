import 'package:flutter/material.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/features/devices_page/page/device_edit_page.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/models/drawer_item.dart';
import 'package:kfone_admin_app_flutter/ui/widgets/common/resizable_image.dart';

import '../../../../../../util/model/session_token.dart';
import '../model/device.dart';
import '../page/device_edit_page_arguments.dart';

DataRow tableRowData(
    {required BuildContext context,
    required Device device,
    required DrawerItem drawerItem,
    required SessionToken sessionToken}) {
  return DataRow(
    cells: <DataCell>[
      DataCell(Text(device.name)),
      DataCell(
        Image.network(
          device.imageUri,
          height: 50,
          errorBuilder: (context, error, stackTrace) => const ResizableImage(
            fit: BoxFit.fitHeight,
            imageLocation: 'assets/images/no_image.jpeg',
            height: 50,
          ),
        ),
      ),
      DataCell(
        Align(
          alignment: Alignment.center,
          child: IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                DeviceEditPage.routeName,
                arguments:
                    DeviceEditPageArguments(drawerItem, sessionToken, device),
              );
            },
            icon: const Icon(
              Icons.edit_outlined,
              color: Colors.black45,
            ),
          ),
        ),
      ),
    ],
  );
}
