import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/models/drawer_item.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(Initial()) {
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
      }
    });
  }
}
