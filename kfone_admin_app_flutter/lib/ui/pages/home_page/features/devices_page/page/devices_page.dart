import 'package:flutter/material.dart';

import '../../../../../../util/ui_util.dart';
import '../../../../../widgets/common/table_header_widget.dart';
import '../widgets/table_row_data.dart';

class DevicesPage extends StatelessWidget {
  const DevicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: UiUtil.getMediaQueryWidth(context),
      child: DataTable(
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
        rows: <DataRow>[
          tableRowData(
            'iPhone 14 Plus',
            'https://www.dialog.lk/dialogdocroot/content/images/devices/iphone14-midnight.png',
          ),
          tableRowData(
            'iPhone13 Pro',
            'https://www.dialog.lk/dialogdocroot/content/images/devices/iphone13pro-gray.png',
          ),
          tableRowData(
            'Samsung Galaxy A53 5G 8GB',
            'https://www.dialog.lk/dialogdocroot/content/images/devices/samsung-a53-5g.png',
          ),
          tableRowData(
            'Xiaomi Redmi 10C 4GB',
            'https://www.dialog.lk/dialogdocroot/content/images/devices/redmi-10c.png',
          ),
        ],
      ),
    );
  }
}
