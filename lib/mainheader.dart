import 'package:flutter/material.dart';
import 'package:flutter_social_media/model/userdata.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({super.key, required this.userData});

  final UserData userData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage(
            userData.myUserAccount.img,
          ),
          radius: 40,
        ),
        Text(
          userData.myUserAccount.name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        Text(
          userData.myUserAccount.email,
        ),
        const SizedBox(
          height: 20,
        ),
      ]
    );
  }
}
