import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/models/drawer_item.dart';

import '../../../../../widgets/common/error_page.dart';
import '../../../../../widgets/common/unauthorized_widget.dart';
import '../bloc/promotion_page_bloc.dart';
import '../widgets/promotions_table.dart';

class PromotionsPage extends StatelessWidget {

  final DrawerItem drawerItem;

  const PromotionsPage({super.key, required this.drawerItem});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PromotionPageBloc()
        ..add(
          GetPromotions(drawerItem: drawerItem),
        ),
      child: BlocBuilder<PromotionPageBloc, PromotionPageState>(
          builder: (context, state) {
        if (state is PromotionPageInitial || state is PromotionPageLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetPromotionsSucess) {
          return PromotionsTable(
            promotions: state.promotions.reversed.toList(),
          );
        } else if (state is PromotionPageUnauthorized) {
          return const UnauthorizedWidget();
        } else {
          return ErrorPage(
            buttonText: 'Try Again',
            onPressed: () {},
          );
        }
      }),
    );
  }
}
