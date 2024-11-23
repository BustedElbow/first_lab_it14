import 'package:flutter/material.dart';
import 'model/userdata.dart';
import 'model/usercomment.dart';
import 'model/userpost.dart';

class Profileview extends StatelessWidget {
  Profileview({super.key, required this.userPost});

  final UserPost userPost;
  final UserData userData = UserData();

  var nameTxtStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  var boldTxtStyle = const TextStyle(
    fontWeight: FontWeight.bold,
  );

  var boldTxtStyle1 = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  Widget commentBtn(UserComment userComment) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(userComment.commentTime),
        const SizedBox(width: 15,),
        const Text('Like'),
        const SizedBox(width: 15),
        const Text('Reply'),
      ],
    ),
  );
  
  Widget commentDesc(UserComment userComment) => Padding(
    padding: const EdgeInsets.all(10),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(userComment.commenterName, style: boldTxtStyle,),
        const SizedBox(height: 5),
        Row(
          children: [
            Text(userComment.commentContent),
          ],
        ),
      ],
    ),
  );

  Widget commentSpace(UserComment userComment) => Container(
    decoration: const BoxDecoration(
      color: Color.fromARGB(35, 158, 158, 158),
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      )
    ),
    child: commentDesc(userComment),
  );

  Widget commenterPic(UserComment userComment) => Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
    ),
    child: CircleAvatar(
      radius: 20,
      backgroundImage: AssetImage(userComment.commenterImg)
    ),
  );

  Widget userCommenterLine(UserPost userPost, UserComment userComment) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      commenterPic(userComment),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          commentSpace(userComment),
          commentBtn(userComment),
        ],
      )
    ],
  );

  Widget userPostDetails (UserComment userComment) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const SizedBox(height: 15,),
      userCommenterLine(userPost, userComment)
    ],
  );

  Widget commenters(UserPost userPost) => Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const Divider(color: Color.fromARGB(86, 158, 158, 158)),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            Text(userPost.numShare, style: boldTxtStyle,),
          ],
        ),
      ),
      Padding(
        
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}