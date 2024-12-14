import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/userpost.dart';
import '../createpost.dart';
import '../profileview.dart';

class PostFeed extends StatelessWidget {
  const PostFeed({super.key});

  void _showEditDialog(BuildContext context, UserPost post) {
    final controller = TextEditingController(text: post.postContent);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Post'),
        content: TextField(
          controller: controller,
          maxLines: 5,
          decoration: const InputDecoration(
            hintText: "What's on your mind?",
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await UserPost.updatePost(
                post.id,
                {'postContent': controller.text.trim()},
              );
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, UserPost post) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Post'),
        content: const Text('Are you sure you want to delete this post?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              await UserPost.deletePost(post.id);
              if (context.mounted) Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(UserPost post, BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final isOwner = post.uid == currentUser?.uid;

    return GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileView(userPost: post),
            )),
        child: Card(
          color: Colors.grey[100],
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(post.userImg),
                ),
                title: Text(post.username),
                subtitle: Text(post.time),
                trailing: isOwner
                    ? PopupMenuButton(
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'edit',
                            child: Text('Edit Post'),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('Delete Post'),
                          ),
                        ],
                        onSelected: (value) {
                          if (value == 'edit') {
                            _showEditDialog(context, post);
                          } else if (value == 'delete') {
                            _showDeleteDialog(context, post);
                          }
                        },
                      )
                    : null,
              ),
              if (post.postContent.isNotEmpty)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(post.postContent),
                ),
              if (post.postImg.isNotEmpty)
                Image.network(
                  post.postImg,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      UserPost.updatePost(post.id, {'isLiked': !post.isLiked});
                    },
                    icon: Icon(
                      Icons.thumb_up,
                      color: post.isLiked ? Colors.blue : Colors.grey,
                    ),
                    label: const Text('Like'),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileView(userPost: post),
                        ),
                      );
                    },
                    icon: const Icon(Icons.comment),
                    label: const Text('Comment'),
                  ),
                  // TextButton.icon(
                  //   onPressed: () {},
                  //   icon: const Icon(Icons.share),
                  //   label: const Text('Share'),
                  // ),
                ],
              ),
            ],
          ),
        )
      );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:
          MediaQuery.of(context).size.height * 0.6, // Adjust height as needed
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final posts = snapshot.data!.docs
              .map((doc) => UserPost.fromFirestore(doc))
              .toList();

          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: posts.length,
            itemBuilder: (context, index) =>
                _buildPostCard(posts[index], context),
          );
        },
      ),
    );
  }
}
