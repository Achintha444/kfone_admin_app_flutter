import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../controller/sale_trends_controller/sales_trends_controller.dart';
import '../../../../../../controller/user_details_controller/user_details_controller.dart';
import '../../../../../../util/ui_util.dart';
import '../../../models/drawer_item.dart';

part 'sales_trend_page_event.dart';
part 'sales_trend_page_state.dart';

class SalesTrendPageBloc extends Bloc<SalesTrendPageEvent, SalesTrendPageState> {
  SalesTrendPageBloc() : super(SalesTrendPageInitial()) {
    on<GetSalesTrend>((event, emit) async {
      emit(SalesTrendPageLoading());

      List<String> scopes = await event.drawerItem.scopes;
      List<String> userScopes = await UserDetailsController.getUserScopes();

      // check if the user has the required scopes to access this page
      if (UiUtil.compareLists(userScopes, scopes)) {
        await SalesTrendsController.getSalesTrends().then((value) {
          emit(GetSalesTrendSucess());
          // ignore: invalid_return_type_for_catch_error
        }).catchError((err) => emit(SalesTrendPageError()));
      } else {
        emit(SalesTrendPageUnauthorized());
      }
    });
  }
}
