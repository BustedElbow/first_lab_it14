import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_media/createpost.dart';
import 'package:flutter_social_media/infoheader.dart';
import 'package:flutter_social_media/mainheader.dart';
import 'package:flutter_social_media/model/userdata.dart';
import 'package:flutter_social_media/postfeed.dart';
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
      backgroundColor: Colors.grey[100],
      body: ListView(
        shrinkWrap: true,
        children: [
          ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            ),
            child: const Text('Logout'),
          ),
          MainHeader(),
          InfoHeader(userData: userData),
          FriendList(),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Row(
              children: [Text('Posts', style: followTxtStyle)],
            ),
          ),
          const SizedBox(height: 20),
          PostFeed(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF6448FE),
        onPressed: () => CreatePost.show(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}