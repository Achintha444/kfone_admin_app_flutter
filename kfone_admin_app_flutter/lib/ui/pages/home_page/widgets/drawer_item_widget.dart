import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_page_bloc.dart';
import '../models/drawer_item.dart';

class DrawerItemWidget extends StatelessWidget {
  final DrawerItem item;
  final List<String>? userScopes;

  const DrawerItemWidget(
      {super.key, required this.item, required this.userScopes});

  Future<bool> getshowItem() async {
    List<String> itemScopes = await item.scopes;
    if (userScopes == null) {
      return false;
    } else if (itemScopes.isEmpty) {
      return true;
    }

    return itemScopes.every((scope) => userScopes!.contains(scope));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getshowItem(),
      builder: (context, snapshot) {
        if (snapshot.data == true) {
          return ListTile(
            leading: Icon(item.icon),
            title: Text(item.itemName),
            onTap: () {
              context
                  .read<HomePageBloc>()
                  .add(NavigateDrawer(drawerItem: item));
              Navigator.pop(context);
            },
          );
        }
        return Container();
      },
    );
  }
}
