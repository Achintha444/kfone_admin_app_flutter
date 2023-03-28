import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kfone_admin_app_flutter/controller/user_details_controller/user_details_controller.dart';
import 'package:kfone_admin_app_flutter/ui/pages/account_page/bloc/account_page_bloc.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/bloc/home_page_bloc.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/features/customers_page/page/customers_page.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/features/devices_page/page/devices_page.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/features/initial_page/page/initial_home_page.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/features/promotions_page/page/promotions_page.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/features/sales_trend_page/page/sales_trend_page.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/models/drawer_item.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/page/home_page_arguements.dart';
import 'package:kfone_admin_app_flutter/util/model/session_token.dart';

import '../../../../util/ui_util.dart';
import '../../account_page/page/account_page.dart';
import '../../account_page/page/account_page_arguments.dart';
import '../widgets/add_resource_button.dart';

class HomePage extends StatelessWidget {
  static const String routeName = "/home";

  static const List<DrawerItem> _drawerItems = [
    DrawerItem(
      type: DrawerItemTypes.initial,
      icon: Icons.home_rounded,
    ),
    DrawerItem(
      type: DrawerItemTypes.devices,
      icon: Icons.devices_rounded,
    ),
    DrawerItem(
      type: DrawerItemTypes.promotions,
      icon: Icons.discount_rounded,
    ),
    DrawerItem(
      type: DrawerItemTypes.customers,
      icon: Icons.people_alt_rounded,
    ),
    DrawerItem(
      type: DrawerItemTypes.salesTrends,
      icon: Icons.trending_up_rounded,
    ),
  ];

  const HomePage({super.key});

  void _onUserDetailsTap(BuildContext context, SessionToken sessionToken) {
    Navigator.pop(context);
    Navigator.pushNamed(context, AccountPage.routeName,
        arguments: AccountPageArguments(sessionToken));
  }

  @override
  Widget build(BuildContext context) {
    final HomePageArguments args =
        ModalRoute.of(context)!.settings.arguments as HomePageArguments;

    return MultiBlocProvider(
      providers: [
        BlocProvider<HomePageBloc>(
          create: (BuildContext context) => HomePageBloc(),
        ),
        BlocProvider<AccountPageBloc>(
          create: (BuildContext context) => AccountPageBloc()
            ..add(
              GetUserInfo(
                sessionToken: args.sessionToken,
              ),
            ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: _buildTitle(context),
        ),
        drawer: Drawer(
          child: ListView.builder(
            padding: const EdgeInsets.all(0),
            itemCount: _drawerItems.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.redAccent,
                  ), //BoxDecoration
                  child: _buildUserHeader(
                      context, args.sessionToken), //UserAccountDrawerHeader
                );
              }

              DrawerItem item = _drawerItems[index - 1];

              return _checkScopesForDrawerItemWidget(item);
            },
          ),
        ),
        body: _buildBody(context),
        floatingActionButton: _buildAddResourceFloatingButton(context),
      ),
    );
  }

  FutureBuilder<List<List<String>>> _checkScopesForDrawerItemWidget(
      DrawerItem item) {
    return FutureBuilder(
      future: Future.wait([UserDetailsController.getUserScopes(), item.scopes]),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
           if(UiUtil.compareLists(snapshot.data![0], snapshot.data![1])) {
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
        }
        return Container();
      },
    );
  }

  BlocListener<AccountPageBloc, AccountPageState> _buildUserHeader(
      BuildContext context, SessionToken sessionToken) {
    return BlocListener<AccountPageBloc, AccountPageState>(
      listener: (context, state) {
        if (state is UserInfoFail) {
          ScaffoldMessenger.of(context).showSnackBar(
            UiUtil.getSnackBar("Fetch Userinfo Failed"),
          );
        }
      },
      child: BlocBuilder<AccountPageBloc, AccountPageState>(
        builder: (context, state) {
          if (state is AccountPageInitial || state is AccountPageLoading) {
            return const CircularProgressIndicator();
          } else if (state is UserInfoSucess) {
            return UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.redAccent),
              accountName: Text(state.user.fullName),
              accountEmail: Text(state.user.email),
              currentAccountPictureSize: const Size.square(50),
              currentAccountPicture: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white70,
                  child: Text(state.user.fullName.characters.first), //Text
                ),
              ),
              onDetailsPressed: () => _onUserDetailsTap(
                context,
                sessionToken,
              ), //circleAvatar
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  BlocBuilder<HomePageBloc, HomePageState> _buildTitle(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        if (state is DevicesInterface) {
          return Text(state.drawerItem.itemName);
        } else if (state is PromotionsInterface) {
          return Text(state.drawerItem.itemName);
        } else if (state is CustomersInterface) {
          return Text(state.drawerItem.itemName);
        } else if (state is SalesTrendsInterface) {
          return Text(state.drawerItem.itemName);
        } else if (state is HomePageInitial || state is InitialInterface) {
          return const Text("Home");
        } else {
          return Container();
        }
      },
    );
  }

  BlocBuilder<HomePageBloc, HomePageState> _buildBody(BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        if (state is Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is DevicesInterface) {
          return DevicesPage(drawerItem: state.drawerItem);
        } else if (state is PromotionsInterface) {
          return const PromotionsPage();
        } else if (state is CustomersInterface) {
          return const CustomersPage();
        } else if (state is SalesTrendsInterface) {
          return const SalesTrendPage();
        } else if (state is HomePageInitial || state is InitialInterface) {
          return const InitialHomePage();
        } else {
          return Container();
        }
      },
    );
  }

  BlocBuilder<HomePageBloc, HomePageState> _buildAddResourceFloatingButton(
      BuildContext context) {
    return BlocBuilder<HomePageBloc, HomePageState>(
      builder: (context, state) {
        if (state is DevicesInterface) {
          return AddResourceButton(tooltip: state.drawerItem.tooltip);
        } else if (state is PromotionsInterface) {
          return AddResourceButton(tooltip: state.drawerItem.tooltip);
        } else if (state is CustomersInterface) {
          return AddResourceButton(tooltip: state.drawerItem.tooltip);
        } else {
          return Container();
        }
      },
    );
  }
}
