import "package:flutter/material.dart";
import 'package:kfone_admin_app_flutter/ui/pages/home_page/features/consumers_page/widgets/table_header_widget.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/features/consumers_page/widgets/tier_chip.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/models/drawer_item.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/page/home_page_arguements.dart';
import 'package:kfone_admin_app_flutter/util/model/session_token.dart';
import 'package:kfone_admin_app_flutter/util/ui_util.dart';

import '../../account_page/page/account_page.dart';
import '../../account_page/page/account_page_arguments.dart';
import '../features/consumers_page/widgets/table_row_data.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "/home";

  static const List<DrawerItem> _drawerItems = [
    DrawerItem(
      title: 'Devices',
      icon: Icons.devices_rounded,
      route: "",
    ),
    DrawerItem(
      title: 'Customers',
      icon: Icons.devices_rounded,
      route: "",
    ),
    DrawerItem(
      title: 'Promotions',
      icon: Icons.devices_rounded,
      route: "",
    ),
    DrawerItem(
      title: 'Sales Trends',
      icon: Icons.devices_rounded,
      route: "",
    ),
  ];

  const HomePage({super.key});

  void _onUserDetailsTap(BuildContext context, SessionToken sessionToken) {
    Navigator.pushNamed(context, AccountPage.routeName,
        arguments: AccountPageArguments(sessionToken));
  }

  @override
  Widget build(BuildContext context) {
    final HomePageArguments args =
        ModalRoute.of(context)!.settings.arguments as HomePageArguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sales Trend"),
      ),
      drawer: Drawer(
        child: ListView.builder(
          padding: const EdgeInsets.all(0),
          itemCount: _drawerItems.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return DrawerHeader(
                decoration: const BoxDecoration(
                    color: Colors.redAccent), //BoxDecoration
                child: UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(color: Colors.redAccent),
                  accountName: const Text("Abhishek Mishra"),
                  accountEmail: const Text("abhishekm977@gmail.com"),
                  currentAccountPictureSize: const Size.square(50),
                  currentAccountPicture: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white70,
                      child: Text("A"), //Text
                    ),
                  ),
                  onDetailsPressed: () =>
                      _onUserDetailsTap(context, args.sessionToken),
                  arrowColor: Colors.white70, //circleAvatar
                ), //UserAccountDrawerHeader
              );
            }

            DrawerItem item = _drawerItems[index - 1];
            return ListTile(
              leading: Icon(item.icon),
              title: Text(item.title),
              onTap: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        // child: ListView(
        //   padding: const EdgeInsets.all(0),
        //   children: [
        //     DrawerHeader(
        //       decoration:
        //           const BoxDecoration(color: Colors.redAccent), //BoxDecoration
        //       child: UserAccountsDrawerHeader(
        //         decoration: const BoxDecoration(color: Colors.redAccent),
        //         accountName: const Text("Abhishek Mishra"),
        //         accountEmail: const Text("abhishekm977@gmail.com"),
        //         currentAccountPictureSize: const Size.square(50),
        //         currentAccountPicture: const Padding(
        //           padding: EdgeInsets.all(8.0),
        //           child: CircleAvatar(
        //             backgroundColor: Colors.white70,
        //             child: Text("A"), //Text
        //           ),
        //         ),
        //         onDetailsPressed: () =>
        //             _onUserDetailsTap(context, args.sessionToken),
        //         arrowColor: Colors.white70, //circleAvatar
        //       ), //UserAccountDrawerHeader
        //     ), //DrawerHeader
        //     ListTile(
        //       leading: const Icon(Icons.devices_rounded),
        //       title: const Text('Devices'),
        //       onTap: () {
        //         Navigator.pop(context);
        //       },
        //     ),
        //     ListView.builder(
        //       itemCount: _drawerItems.length,
        //       itemBuilder: (BuildContext context, int index) {
        //         DrawerItem item = _drawerItems[index];
        //         return new ListTile(
        //           title: new Text(item.title),
        //         );
        //       },
        //     ),
        //     ListTile(
        //       leading: const Icon(Icons.discount_rounded),
        //       title: const Text('Promotions'),
        //       onTap: () {
        //         Navigator.pop(context);
        //       },
        //     ),
        //     ListTile(
        //       leading: const Icon(Icons.people_alt_rounded),
        //       title: const Text('Customers'),
        //       onTap: () {
        //         Navigator.pop(context);
        //       },
        //     ),
        //     ListTile(
        //       leading: const Icon(Icons.trending_up_rounded),
        //       title: const Text('Sales Trends'),
        //       onTap: () {
        //         Navigator.pop(context);
        //       },
        //     ),
        //     SizedBox(height: MediaQuery.of(context).size.height / 2.6),
        //     const ResizableImage(
        //       fit: BoxFit.fitHeight,
        //       imageLocation: 'assets/images/logo.png',
        //       height: 30.0,
        //     )
        //   ],
        // ),
      ),
      body: SizedBox(
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
      ),
    );
  }
}
