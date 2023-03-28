import 'package:flutter/material.dart';

import '../../../../../../util/ui_util.dart';
import '../../../../../widgets/common/table_header_widget.dart';
import '../widgets/table_row_data.dart';

class PromotionsPage extends StatelessWidget {
  const PromotionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: UiUtil.getMediaQueryWidth(context),
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: TableHeaderWidget(label: 'Promo Code'),
          ),
          DataColumn(
            label: TableHeaderWidget(label: 'Discount'),
          ),
          DataColumn(
            label: Spacer(),
          ),
        ],
        rows: <DataRow>[
          tableRowData(
            'BUS10',
            '10%',
          ),
          tableRowData(
            'SAM20',
            '20%',
          ),
          tableRowData(
            'APP15',
            '15%',
          ),
          tableRowData(
            'XIA10',
            '10%',
          ),
        ],
      ),
    );
  }
}
