import 'dart:math';

import 'package:flutter/material.dart';
import 'model/userdata.dart';
import 'model/usercomment.dart';
import 'model/userpost.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key, required this.userPost});

  final UserPost userPost;


  @override
  State<ProfileView> createState() => _ProfileViewState();
 
}

class _ProfileViewState extends State<ProfileView> {
  final UserData userData = UserData();

  final TextEditingController commentController = TextEditingController();
  bool isCommenting = false;
  List<UserComment> _comments = [];

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
            const SizedBox(width: 15),
            GestureDetector(
              onTap: () {
                setState(() {
                  userComment.isLiked = !userComment.isLiked; // Toggle state
                });
              },
              child: userComment.isLiked
                  ? const Icon(
                      Icons.thumb_up,
                      color: Colors.blue,
                      size: 16,
                    )
                  : const Text(
                      'Like',
                    ),
            ),
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
            Text(
              userComment.commenterName,
              style: boldTxtStyle,
            ),
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
            )),
        child: commentDesc(userComment),
      );

  Widget commenterPic(UserComment userComment) => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: CircleAvatar(
            radius: 20, backgroundImage: AssetImage(userComment.commenterImg)),
      );

  Widget userCommenterLine(UserComment userComment) => Row(
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

  Widget userPostDetails(UserComment userComment) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          userCommenterLine(userComment)
        ],
      );

  Widget commenters() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Divider(color: Color.fromARGB(86, 158, 158, 158)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Text(
                  widget.userPost.numShare,
                  style: boldTxtStyle,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      );

  Widget buttons() => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Divider(color: Color.fromARGB(86, 158, 158, 158)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  style: TextButton.styleFrom(
                      foregroundColor:
                          (widget.userPost.isLiked) ? Colors.blue : Colors.grey),
                  onPressed: () {
                    setState(() {
                      widget.userPost.isLiked = (widget.userPost.isLiked) ? false : true;
                    });
                  },
                  icon: const Icon(
                    Icons.thumb_up,
                    size: 20,
                  ),
                  label: const Text('Like'),
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(foregroundColor: Colors.grey),
                  onPressed: () {
                    setState(() {
                        isCommenting = !isCommenting;
                    });
                  },
                  icon: const Icon(Icons.chat_bubble, size: 20),
                  label: const Text('Comment'),
                ),
                TextButton.icon(
                  style: TextButton.styleFrom(foregroundColor: Colors.grey),
                  onPressed: () {},
                  icon: const Icon(Icons.share),
                  label: const Text('Share'),
                ),
              ],
            ),
          ),
          const Divider(
            color: Color.fromARGB(86, 158, 158, 158),
          ),
        ],
      );

  Widget userline() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(widget.userPost.userImg),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.userPost.username, style: nameTxtStyle),
              Row(
                children: [
                  Text(widget.userPost.time),
                  const Text(' . '),
                  const Icon(Icons.group, size: 16, color: Colors.grey),
                ],
              ),
            ],
          ),
        ],
      );

  Widget postImage() => Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(widget.userPost.postContent),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 350,
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(widget.userPost.postImg),
                fit: BoxFit.fill,
              )),
            ),
          ],
        ),
      );

    Widget commentInputField() => isCommenting
      ? Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: commentController,
                  decoration: InputDecoration(
                    hintText: 'Write a comment...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  if (commentController.text.isNotEmpty) {
                    setState(() {
                      _comments.add(UserComment(
                        commenterName: userData.myUserAccount.name,
                        commentContent: commentController.text,
                        commentTime: 'Just now', // Static for demo
                        commenterImg: userData.myUserAccount.img,
                      ));
                      commentController.clear();
                      isCommenting = false;
                    });
                  }
                },
                child: const Text('Post'),
              ),
            ],
          ),
        )
      : const SizedBox.shrink();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.grey,
            )),
      ),
      body: ListView(
        children: [
          userline(),
          postImage(),
          buttons(),
          commenters(),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ...userData.commentList.map((userComment) {
                return userPostDetails(userComment);
              }).toList(),
              ..._comments.map((userComment) {
                return userPostDetails(userComment);
              }).toList(),
            ],
          ),
          commentInputField(),
        ],
      ),
    );
  }

}

