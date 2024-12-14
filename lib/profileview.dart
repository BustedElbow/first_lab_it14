import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  @override
  void initState() {
    super.initState();
    // Listen to comments for this specific post
    FirebaseFirestore.instance
        .collection('comments')
        .where('postId', isEqualTo: widget.userPost.id)
        .orderBy('commentTime', descending: true)
        .snapshots()
        .listen((snapshot) {
      setState(() {
        _comments =
            snapshot.docs.map((doc) => UserComment.fromFirestore(doc)).toList();
      });
    });
  }

 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          'Post Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          // Post Section
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .doc(widget.userPost.id)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const SizedBox();

              final postData = snapshot.data!.data() as Map<String, dynamic>;
              final isLiked = postData['isLiked'] ?? false;

              return Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User Info
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage:
                                NetworkImage(widget.userPost.userImg),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.userPost.username,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                widget.userPost.time,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Post Content
                    if (widget.userPost.postContent.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Text(
                          widget.userPost.postContent,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    // Post Image
                    if (widget.userPost.postImg.isNotEmpty)
                      Image.network(
                        widget.userPost.postImg,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    // Interaction Buttons
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton.icon(
                            onPressed: () async {
                              // Update Firestore
                              await UserPost.updatePost(
                                  widget.userPost.id, {'isLiked': !isLiked});
                            },
                            icon: Icon(
                              Icons.thumb_up,
                              color: isLiked ? Colors.blue : Colors.grey,
                            ),
                            label: const Text('Like'),
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.comment),
                            label: const Text('Comment'),
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.share),
                            label: const Text('Share'),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                  ],
                ),
              );
            },
          ),

          // Comments Section
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('comments')
                  .where('postId', isEqualTo: widget.userPost.id)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No comments yet'));
                }

                final comments = snapshot.data!.docs
                    .map((doc) => UserComment.fromFirestore(doc))
                    .toList();

                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: comments.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, index) =>
                      _buildCommentItem(comments[index]),
                );
              },
            ),
          ),

          // Comment Input
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: commentController,
                    decoration: InputDecoration(
                      hintText: 'Write a comment...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: const Color(0xFF6448FE),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _addComment,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addComment() async {
    if (commentController.text.trim().isEmpty) return;

    final currentUser = FirebaseAuth.instance.currentUser;
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser?.uid)
        .get();

    final userData = userDoc.data()!;

    final comment = UserComment(
      id: '',
      postId: widget.userPost.id,
      commenterUid: currentUser!.uid,
      commenterImg: userData['img'],
      commenterName: userData['name'],
      commentTime: DateTime.now().toString(),
      commentContent: commentController.text.trim(),
    );

    await UserComment.createComment(comment);
    commentController.clear();
  }

  Widget _buildCommentItem(UserComment comment) {
    final currentUser = FirebaseAuth.instance.currentUser;
    final isOwner = comment.commenterUid == currentUser?.uid;

    void _showEditDialog() {
      final editController =
          TextEditingController(text: comment.commentContent);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Edit Comment'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(
              hintText: 'Edit your comment...',
            ),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                UserComment.updateComment(
                  comment.id,
                  {'commentContent': editController.text.trim()},
                );
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      );
    }

    void _showDeleteDialog() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Comment'),
          content: const Text('Are you sure you want to delete this comment?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                UserComment.deleteComment(comment.id);
                Navigator.pop(context);
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: const Text('Delete'),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(comment.commenterImg),
                radius: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.commenterName,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      comment.commentTime,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ),
              if (isOwner)
                PopupMenuButton(
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Text('Edit'),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                  ],
                  onSelected: (value) {
                    if (value == 'edit') {
                      _showEditDialog();
                    } else if (value == 'delete') {
                      _showDeleteDialog();
                    }
                  },
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(comment.commentContent),
        ],
      ),
    );
  }
}
