import 'package:flutter/material.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/models/drawer_item.dart';
import 'package:kfone_admin_app_flutter/util/model/session_token.dart';

import '../../../../../widgets/common/table_header_widget.dart';
import '../model/device.dart';
import 'table_row_data.dart';

class DevicesTable extends StatelessWidget {
  final List<Device> devices;
  final SessionToken sessionToken;
  final DrawerItem drawerItem;

  const DevicesTable({
    super.key,
    required this.devices,
    required this.sessionToken,
    required this.drawerItem,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
        dataRowHeight: 90,
        columns: const <DataColumn>[
          DataColumn(
            label: TableHeaderWidget(label: 'Name'),
          ),
          DataColumn(
            label: TableHeaderWidget(label: 'Image'),
          ),
          DataColumn(
            label: Spacer(),
          ),
        ],
        rows: devices
            .map(
              (device) => tableRowData(
                context: context,
                device: device,
                drawerItem: drawerItem,
                sessionToken: sessionToken,
              ),
            )
            .toList(),
      ),
    );
  }
}
