import 'package:flutter/material.dart';
import 'package:flutter_social_media/model/userdata.dart';

class InfoHeader extends StatelessWidget {
  const InfoHeader({super.key, required this.userData,});
  final UserData userData;

  final followTxtStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Followers'),
            Text('Posts'),
            Text('Following'),
          ],
        ),
        const SizedBox(
          height: 10
        ),
        const Divider(
          color: Colors.grey,
        )
      ],
    );
  }
}