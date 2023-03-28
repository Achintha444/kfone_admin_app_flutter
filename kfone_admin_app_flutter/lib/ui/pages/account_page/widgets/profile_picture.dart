import 'package:flutter/material.dart';

class ProfilePicture extends StatelessWidget {
  final String fullName;

  const ProfilePicture({Key? key, required this.fullName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      maxRadius: 30,
      child: CircleAvatar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        maxRadius: 29,
        child: Text(fullName.characters.first),
      ),
    );
  }
}
