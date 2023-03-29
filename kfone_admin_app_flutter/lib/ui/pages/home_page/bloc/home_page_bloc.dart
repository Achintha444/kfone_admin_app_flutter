import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/models/drawer_item.dart';

import '../../../../controller/user_details_controller/user_details_controller.dart';
import '../../../../util/ui_util.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<NavigateDrawer>((event, emit) {
      emit(Loading());

      switch (event.drawerItem.type) {
        case DrawerItemTypes.devices:
          emit(DevicesInterface(drawerItem: event.drawerItem));
          break;
        case DrawerItemTypes.customers:
          emit(CustomersInterface(drawerItem: event.drawerItem));
          break;
        case DrawerItemTypes.promotions:
          emit(PromotionsInterface(drawerItem: event.drawerItem));
          break;
        case DrawerItemTypes.salesTrends:
          emit(SalesTrendsInterface(drawerItem: event.drawerItem));
          break;
        case DrawerItemTypes.initial:
          emit(InitialInterface(drawerItem: event.drawerItem));
          break;
      }
    });
    on<CheckAccess>((event, emit) async {
      emit(Loading());

      List<String> scopes = await event.drawerItem.scopes;
      List<String> userScopes = await UserDetailsController.getUserScopes();

      // check if the user has the required scopes to access this page
      if (UiUtil.compareLists(userScopes, scopes)) {
        emit(Authorized());
      } else {
        emit(Unauthorized());
      }
    });
  }
}
