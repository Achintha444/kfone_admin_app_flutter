import 'package:flutter/material.dart';
import 'package:kfone_admin_app_flutter/util/model/session_token.dart';

import '../../../../model/user.dart';
import 'profile_parameter.dart';
import 'profile_picture.dart';
import 'signout_button.dart';

class Profile extends StatelessWidget {
  final User user;
  final SessionToken sessionToken;

  const Profile({
    Key? key,
    required this.user,
    required this.sessionToken,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 20),
        ProfilePicture(
          fullName: user.fullName,
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
            itemCount: user.toList().length,
            itemBuilder: ((context, index) =>
                ProfileParameter(parameterObject: user.toList()[index])),
          ),
        ),
        const SizedBox(height: 50),
        SignoutButton(
          sessionToken: sessionToken,
        ),
        const Spacer(),
      ],
    );
  }
}
