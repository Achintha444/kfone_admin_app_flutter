import 'package:flutter/material.dart';

import '../widgets/bar_graph.dart';
import '../widgets/curve_graph.dart';
import '../widgets/line_graph.dart';
import '../widgets/pie_chart.dart';

class SalesTrendPage extends StatelessWidget {
  const SalesTrendPage({super.key});

  @override
  Widget build(BuildContext context) {
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
  }
}
