import 'package:flutter/material.dart';

import '../../../../../../util/ui_util.dart';
import '../../../../../widgets/common/table_header_widget.dart';
import '../widgets/table_row_data.dart';
import '../widgets/tier_chip.dart';

class CustomersPage extends StatelessWidget {
  const CustomersPage({super.key});

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
              label: TableHeaderWidget(label: 'Tier'),
            ),
            DataColumn(
              label: Spacer(),
            ),
          ],
          rows: <DataRow>[
            tableRowData("Abhishek", TierChipType.gold),
            tableRowData("Abhishek", TierChipType.silver),
            tableRowData("Abhishek", TierChipType.platinum),
            tableRowData("Abhishek", TierChipType.no),
          ],
        ),
      );
  }
}