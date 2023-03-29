import 'package:flutter/material.dart';

import '../../../../../widgets/common/table_header_widget.dart';
import '../model/device.dart';
import 'table_row_data.dart';

class DevicesTable extends StatelessWidget {
  final List<Device> devices;

  const DevicesTable({
    super.key,
    required this.devices,
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
        rows: devices.map((device) => tableRowData(device.name, device.imageUri)).toList(),
      ),
    );
  }
}
