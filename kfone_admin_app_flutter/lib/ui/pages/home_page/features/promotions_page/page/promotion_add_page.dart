import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/features/devices_page/page/device_add_page_arguments.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/features/promotions_page/bloc/promotion_page_bloc.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/features/promotions_page/page/promotion_add_page_arguments.dart';

import '../../../../../../util/ui_util.dart';
import '../../../../../widgets/common/error_page.dart';
import '../../../../../widgets/common/unauthorized_widget.dart';
import '../../../bloc/home_page_bloc.dart';
import '../../../page/home_page.dart';
import '../../../page/home_page_arguements.dart';

class PromotionAddPage extends StatelessWidget {
  static const String routeName = "/promotion/add";

  PromotionAddPage({super.key});

  final _formKey = GlobalKey<FormState>();

  final _promoCodeController = TextEditingController();
  final _discountController = TextEditingController();

  void _submitForm(BuildContext context) async {
    String promoCode = _promoCodeController.text;
    double discount = double.parse(_discountController.text.toString());

    context.read<PromotionPageBloc>().add(
          CreatePromtion(
            promoCode: promoCode,
            discount: discount,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final PromotionAddPageArguments args =
        ModalRoute.of(context)!.settings.arguments as PromotionAddPageArguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Promotion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: MultiBlocProvider(
            providers: [
              BlocProvider<HomePageBloc>(
                create: (BuildContext context) => HomePageBloc()
                  ..add(
                    CheckAccess(drawerItem: args.drawerItem),
                  ),
              ),
              BlocProvider<PromotionPageBloc>(
                  create: (BuildContext context) => PromotionPageBloc()),
            ],
            child: BlocBuilder<HomePageBloc, HomePageState>(
                builder: (context, state) {
              if (state is HomePageInitial || state is Loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is Authorized) {
                return _createBody(args);
              } else if (state is Unauthorized) {
                return const UnauthorizedWidget();
              } else {
                return ErrorPage(
                  buttonText: 'Try Again',
                  onPressed: () {},
                );
              }
            }),
          ),
        ),
      ),
    );
  }

  BlocListener<PromotionPageBloc, PromotionPageState> _createBody(
      PromotionAddPageArguments arguments) {
    return BlocListener<PromotionPageBloc, PromotionPageState>(
      listener: (context, state) {
        if (state is CreatePromotionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            UiUtil.getSnackBar("Promotion Created Successfully"),
          );

          Navigator.pushNamed(
            context,
            HomePage.routeName,
            arguments: HomePageArguments(arguments.sessionToken,
                drawerItem: arguments.drawerItem),
          );
        } else if (state is CreatePromotionError) {
          ScaffoldMessenger.of(context).showSnackBar(
            UiUtil.getSnackBar("Promotion creation failed"),
          );
        }
      },
      child: BlocBuilder<PromotionPageBloc, PromotionPageState>(
          builder: (context, state) {
        if (state is PromotionPageLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _promoCodeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Promo Code',
                  ),
                ),
                TextFormField(
                  controller: _discountController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Discount',
                  ),
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () => _submitForm(context),
                  child: const Text('Submit'),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
