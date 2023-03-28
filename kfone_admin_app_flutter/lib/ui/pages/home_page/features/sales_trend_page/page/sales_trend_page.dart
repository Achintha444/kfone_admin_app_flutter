import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/features/sales_trend_page/bloc/sales_trend_page_bloc.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/models/drawer_item.dart';

import '../../../../../widgets/common/error_page.dart';
import '../../../../../widgets/common/unauthorized_widget.dart';
import '../widgets/bar_graph.dart';
import '../widgets/curve_graph.dart';
import '../widgets/line_graph.dart';
import '../widgets/pie_chart.dart';

class SalesTrendPage extends StatelessWidget {
  final DrawerItem drawerItem;

  const SalesTrendPage({super.key, required this.drawerItem});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SalesTrendPageBloc()
        ..add(
          GetSalesTrend(drawerItem: drawerItem),
        ),
      child: BlocBuilder<SalesTrendPageBloc, SalesTrendPageState>(
        builder: (context, state) {
          if (state is SalesTrendPageInitial ||
              state is SalesTrendPageLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetSalesTrendSucess) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    BarGraph(),
                    Divider(),
                    LineGraph(),
                    Divider(),
                    CurveGraph(),
                    Divider(),
                    RadarGraph()
                  ],
                ),
              ),
            );
          } else if (state is SalesTrendPageUnauthorized) {
            return const UnauthorizedWidget();
          } else {
            return ErrorPage(
              buttonText: 'Try Again',
              onPressed: () {},
            );
          }
        },
      ),
    );
  }
}
