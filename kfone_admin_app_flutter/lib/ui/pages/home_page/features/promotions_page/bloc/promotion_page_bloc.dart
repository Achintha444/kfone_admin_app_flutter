import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../controller/promtions_controller/promtions_controller.dart';
import '../../../../../../controller/user_details_controller/user_details_controller.dart';
import '../../../../../../util/ui_util.dart';
import '../../../models/drawer_item.dart';
import '../model/promotion.dart';

part 'promotion_page_event.dart';
part 'promotion_page_state.dart';

class PromotionPageBloc extends Bloc<PromotionPageEvent, PromotionPageState> {
  PromotionPageBloc() : super(PromotionPageInitial()) {
    on<GetPromotions>((event, emit) async {
      emit(PromotionPageLoading());

      List<String> scopes = await event.drawerItem.scopes;
      List<String> userScopes = await UserDetailsController.getUserScopes();

      // check if the user has the required scopes to access this page
      if (UiUtil.compareLists(userScopes, scopes)) {
        await PromotionsController.getPromotions().then((value) {
          emit(GetPromotionsSucess(promotions: value));
          // ignore: invalid_return_type_for_catch_error
        }).catchError((err) => emit(PromotionPageError()));
      } else {
        emit(PromotionPageUnauthorized());
      }
    });
    on<CreatePromtion>((event, emit) async {
      emit(PromotionPageLoading());

      Promotion promotion = Promotion(
        code: event.promoCode,
        discount: event.discount,
        tiers: const []
      );

      await PromotionsController.createPromotion(promotion)
          .then((value) => emit(CreatePromotionSuccess()))
          .catchError((err) => emit(CreatePromotionError()));
    });
  }
}
