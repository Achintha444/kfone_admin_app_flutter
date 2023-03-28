import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../util/ui_util.dart';
import '../../initial_page/page/initial_page.dart';
import '../bloc/account_page_bloc.dart';
import '../widgets/profile.dart';
import '../widgets/profile_error.dart';
import 'account_page_arguments.dart';

class AccountPage extends StatelessWidget {
  static const routeName = "/account";

  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AccountPageArguments args =
        ModalRoute.of(context)!.settings.arguments as AccountPageArguments;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text("Account"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: UiUtil.getMediaQueryWidth(context),
          height: UiUtil.getMediaQueryHeight(context),
          child: Center(
            child: _buildBody(context, args),
          ),
        ),
      ),
    );
  }

  BlocProvider<AccountPageBloc> _buildBody(
      BuildContext context, AccountPageArguments args) {
    return BlocProvider(
      create: (context) => AccountPageBloc()
        ..add(
          GetUserInfo(
            sessionToken: args.sessionToken,
          ),
        ),
      child: BlocListener<AccountPageBloc, AccountPageState>(
        listener: (context, state) {
          if (state is UserInfoFail) {
            ScaffoldMessenger.of(context).showSnackBar(
              UiUtil.getSnackBar("Fetch Userinfo Failed"),
            );
          } else if (state is SignoutFail) {
            ScaffoldMessenger.of(context).showSnackBar(
              UiUtil.getSnackBar("Signout Failed"),
            );
          } else if (state is SignoutSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              UiUtil.getSnackBar("Signout Success"),
            );

            Navigator.pushNamed(
              context,
              InitialPage.routeName,
            );
          }
        },
        child: BlocBuilder<AccountPageBloc, AccountPageState>(
          builder: (context, state) {
            if (state is Initial || state is Loading) {
              return const CircularProgressIndicator();
            } else if (state is UserInfoSucess) {
              return Profile(
                user: state.user,
                sessionToken: args.sessionToken,
              );
            } else {
              return ProfileError(
                sessionToken: args.sessionToken,
              );
            }
          },
        ),
      ),
    );
  }
}
