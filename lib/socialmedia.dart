import 'package:flutter/material.dart';
import 'package:flutter_social_media/infoheader.dart';
import 'package:flutter_social_media/mainheader.dart';
import 'package:flutter_social_media/model/userdata.dart';

class SocialMedia extends StatefulWidget {
  const SocialMedia({super.key});

  @override
  State<SocialMedia> createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {
  UserData userData = UserData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          MainHeader(userData: userData),
          InfoHeader(userData: userData),
        ],
      ),
    );
  }
}