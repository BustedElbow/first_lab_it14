import 'package:flutter/material.dart';
import '../model/userdata.dart';
import '../model/userpost.dart';
import '../profileview.dart';

class PostList extends StatefulWidget {
  const PostList({super.key, required this.userData});

  final UserData userData;

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {

  var nameTxtStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  gotoPage(BuildContext context, dynamic page) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => page,
    ));
  }

  Widget buttons(UserPost userPost) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      TextButton.icon(
        style: TextButton.styleFrom(
          foregroundColor: (userPost.isLiked) ? Colors.blue : Colors.grey,
        ),
        onPressed: () {
          setState(() {
            userPost.isLiked = (userPost.isLiked) ? false : true;
          });
        },
        icon: const Icon(Icons.thumb_up),
        label: const Text('Like'),
      ),
      TextButton.icon(
        style: TextButton.styleFrom(
          foregroundColor: Colors.grey,
        ),
        onPressed: () {},
        icon: const Icon(Icons.message),
        label: const Text('Comment'),
      ),
      TextButton.icon(
        style: TextButton.styleFrom(
          foregroundColor: Colors.grey,
        ),
        onPressed: () {},
        label: const Text('Share'),
      )
    ]
  );

  Widget postCount(UserPost userPost) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Text(
        '${userPost.numComments}',
      ),
      const Text(' * '),
      Text(
        '${userPost.numShare}'
      )
    ],
  );

  Widget postImage(UserPost userPost) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Container(
      height: 350,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(userPost.postImg),
          fit: BoxFit.fill,
        ),
      ),
    ),
  );

  Widget postHeader(UserPost userPost) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: CircleAvatar(
          radius: 20,
          backgroundImage: AssetImage(
            userPost.userImg,
          ),
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userPost.username,
            style: nameTxtStyle,
          ),
          Row(
            children: [
              Text('${userPost.time}'),
              const Icon(
                Icons.people,
                size: 18,
              )
            ],
          )
        ],
      ),
    ],
  );

  Widget showPost(UserPost userPost) => Column(
    children: [
      postHeader(userPost),
      Container(
        margin: const EdgeInsets.all(8),
        child: Row(
          children: [
            Text(
              userPost.postContent,
              style: nameTxtStyle,
            ),
          ],
        ),
      ),
      postImage(userPost),
      postCount(userPost),
      const Divider(),
      buttons(userPost),
      SizedBox(
        height: 10,
        child: Container(
          color: Colors.grey,
        ),
      ),
      const SizedBox(
        height: 15,
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: ListView(
        shrinkWrap: true,
        children: widget.userData.userList.map((userPost) {
          return InkWell(
            onTap: () {
              gotoPage(context, ProfileView(userPost: userPost));
            },
            child: showPost(userPost),
          );
        }).toList(),
      ),
    );
  }
}