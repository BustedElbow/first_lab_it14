import 'package:cloud_firestore/cloud_firestore.dart';

class UserPost {
  final String id;
  final String uid;
  final String userImg;
  final String username;
  final String time;
  final String postContent;
  final String postImg;
  final String numComments;
  final String numShare;
  bool isLiked;

  UserPost({
    required this.id,
    required this.uid,
    required this.userImg,
    required this.username,
    required this.time,
    required this.postContent,
    required this.postImg,
    required this.numComments,
    required this.numShare,
    this.isLiked = false,
  });

  // Convert to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userImg': userImg,
      'username': username,
      'time': time,
      'postContent': postContent,
      'postImg': postImg,
      'numComments': numComments,
      'numShare': numShare,
      'isLiked': isLiked,
    };
  }

  // Create from Firestore document
  factory UserPost.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return UserPost(
      id: doc.id,
      uid: data['uid'] ?? '',
      userImg: data['userImg'] ?? '',
      username: data['username'] ?? '',
      time: data['time'] ?? '',
      postContent: data['postContent'] ?? '',
      postImg: data['postImg'] ?? '',
      numComments: data['numComments'] ?? '0',
      numShare: data['numShare'] ?? '0',
      isLiked: data['isLiked'] ?? false,
    );
  }

  // CRUD Operations
  static Future<void> createPost(UserPost post) async {
    await FirebaseFirestore.instance.collection('posts').add(post.toMap());
  }

  static Future<void> updatePost(
      String postId, Map<String, dynamic> updates) async {
    await FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .update(updates);
  }

  static Future<void> deletePost(String postId) async {
    await FirebaseFirestore.instance.collection('posts').doc(postId).delete();
  }

  // Get posts for current user
  static Stream<List<UserPost>> getCurrentUserPosts(String uid) {
    return FirebaseFirestore.instance
        .collection('posts')
        .where('uid', isEqualTo: uid)
        .orderBy('time', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => UserPost.fromFirestore(doc)).toList());
  }
}
