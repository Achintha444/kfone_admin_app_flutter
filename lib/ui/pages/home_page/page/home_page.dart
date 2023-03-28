import "package:flutter/material.dart";

import '../../../widgets/common/resizable_image.dart';
import '../features/sales_trend_page/widgets/bar_graph.dart';
import '../features/sales_trend_page/widgets/curve_graph.dart';
import '../features/sales_trend_page/widgets/line_graph.dart';
import '../features/sales_trend_page/widgets/pie_chart.dart';

class HomePage extends StatelessWidget {
  static const routeName = "/home";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            ResizableImage(
              height: 20,
              fit: BoxFit.fitHeight,
              imageLocation: 'assets/images/logo.png',
            ),
            Text("Sales Trend"),
          ],
        ),
        actions: const [
          Icon(Icons.person_rounded),
          SizedBox(width: 10),
        ],
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: const [
              BarChartSample3(),
              Divider(),
              LineChartSample2(),
              Divider(),
              LineChartSample1(),
              Divider(),
              RadarChartSample1()
            ],
          ),
        ),
      ),
    );
  }
}
