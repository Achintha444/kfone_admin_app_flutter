import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kfone_admin_app_flutter/ui/pages/account_page/widgets/full_name_text_field.dart';
import 'package:kfone_admin_app_flutter/ui/widgets/common/action_button.dart';
import 'package:kfone_admin_app_flutter/util/model/session_token.dart';

import '../../../../model/user.dart';
import '../bloc/account_page_bloc.dart';
import 'profile_parameter.dart';
import 'profile_picture.dart';
import 'signout_button.dart';

class Profile extends StatelessWidget {
  final User user;
  final SessionToken sessionToken;

  final TextEditingController _fullNameController = TextEditingController();

  Profile({
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
            itemBuilder: ((context, index) {
              final String parameter = user.toList()[index].keys.first;
              final String value = user.toList()[index][parameter] as String;

              _fullNameController.value = TextEditingValue(text: value);

              if (parameter == "fullName") {
                return FullNameTextField(
                  controller: _fullNameController,
                  parameter: parameter,
                  value: value,
                );
              }

              return ProfileParameter(
                parameter: parameter,
                value: value,
              );
            }),
          ),
        ),
        const SizedBox(height: 50),
        ActionButton(
          buttonText: "Update",
          onPressed: () {
            context.read<AccountPageBloc>().add(
                  UpdateUserInfo(
                    id: user.id,
                    fullName: _fullNameController.text,
                  ),
                );
          },
        ),
        const SizedBox(height: 10),
        SignoutButton(
          sessionToken: sessionToken,
        ),
        const Spacer(),
      ],
    );
  }
}
