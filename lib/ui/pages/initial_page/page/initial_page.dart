import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/page/home_page.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/page/home_page_arguements.dart';

import '../../../../util/ui_util.dart';
import '../../../widgets/common/resizable_image.dart';
import '../bloc/inital_page_bloc.dart';
import '../widgets/signin_button.dart';

class InitialPage extends StatelessWidget {
  static const routeName = "/";

  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: UiUtil.getMediaQueryWidth(context),
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(1, 1),
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0),
            ],
            tileMode: TileMode.clamp,
            radius: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const ResizableImage(
              height: 100,
              fit: BoxFit.fitHeight,
              imageLocation: 'assets/images/logo.png',
            ),
            const SizedBox(height: 10),
            const Text("Admininstrator Application"),
            const Spacer(),
            _buildBody(context),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  BlocProvider<InitalPageBloc> _buildBody(BuildContext context) {
    return BlocProvider(
      create: (context) => InitalPageBloc()
        ..add(
          InitialSignin(),
        ),
      child: BlocListener<InitalPageBloc, InitalPageState>(
        listener: (context, state) {
          if (state is SigninFail) {
            ScaffoldMessenger.of(context).showSnackBar(
              UiUtil.getSnackBar("Signin Failed"),
            );
          } else if (state is SigninSuccess) {
            Navigator.pushNamed(
              context,
              HomePage.routeName,
              arguments: HomePageArguments(state.sessionToken),
            );
            // Navigator.pushNamed(context, AccountPage.routeName,
            //     arguments:
            //         AccountPageArguments(state.sessionToken));
          }
        },
        child: BlocBuilder<InitalPageBloc, InitalPageState>(
          builder: (context, state) {
            if (state is Initial) {
              return const SigninButton();
            } else if (state is Loading) {
              return const CircularProgressIndicator();
            } else if (state is SigninFail) {
              return const SigninButton();
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
