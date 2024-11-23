import 'package:flutter/material.dart';
import 'package:flutter_social_media/infoheader.dart';
import 'package:flutter_social_media/mainheader.dart';
import 'package:flutter_social_media/model/userdata.dart';
import 'package:flutter_social_media/views/friendlist.dart';
import 'package:flutter_social_media/views/postlist.dart';

class SocialMedia extends StatefulWidget {
  const SocialMedia({super.key});

  @override
  State<SocialMedia> createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {
  UserData userData = UserData();

  var followTxtStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          MainHeader(userData: userData),
          InfoHeader(userData: userData),
          FriendList(userData: userData),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              children: [
                Text('Posts', style: followTxtStyle)
              ],
            ),
          ),
          const SizedBox(height: 20),
          PostList(userData: userData),
        ],
      ),
    );
  }
}