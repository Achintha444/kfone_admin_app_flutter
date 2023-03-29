import 'package:flutter/material.dart';
import 'package:kfone_admin_app_flutter/util/ui_util.dart';

import '../../../../../widgets/common/table_header_widget.dart';
import '../model/promotion.dart';
import 'table_row_data.dart';

class PromotionsTable extends StatelessWidget {
  final List<Promotion> promotions;

  const PromotionsTable({
    super.key,
    required this.promotions,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: UiUtil.getMediaQueryWidth(context),
        child: DataTable(
          dataRowHeight: 90,
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
          rows: promotions.map((promotion) => tableRowData(promotion.code, '${promotion.discount}%')).toList(),
        ),
      ),
    );
  }
}
