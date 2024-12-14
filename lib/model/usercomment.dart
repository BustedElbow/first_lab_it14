import 'package:cloud_firestore/cloud_firestore.dart';

class UserComment {
  final String id;
  final String postId;
  final String commenterUid;
  final String commenterImg;
  final String commenterName;
  final String commentTime;
  final String commentContent;
  bool isLiked;

  UserComment({
    required this.id,
    required this.postId,
    required this.commenterUid,
    required this.commenterImg,
    required this.commenterName,
    required this.commentTime,
    required this.commentContent,
    this.isLiked = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'commenterUid': commenterUid,
      'commenterName': commenterName,
      'commentContent': commentContent,
      'commentTime': commentTime,
      'commenterImg': commenterImg,
      'isLiked': isLiked,
    };
  }

  factory UserComment.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return UserComment(
      id: doc.id,
      postId: data['postId'] ?? '',
      commenterUid: data['commenterUid'] ?? '',
      commenterImg: data['commenterImg'] ?? '',
      commenterName: data['commenterName'] ?? '',
      commentTime: data['commentTime'] ?? '',
      commentContent: data['commentContent'] ?? '',
      isLiked: data['isLiked'] ?? false,
    );
  }

  // CRUD Operations
  static Future<void> createComment(UserComment comment) async {
    await FirebaseFirestore.instance
        .collection('comments')
        .add(comment.toMap());
  }

  static Future<void> updateComment(
      String commentId, Map<String, dynamic> updates) async {
    await FirebaseFirestore.instance
        .collection('comments')
        .doc(commentId)
        .update(updates);
  }

  static Future<void> deleteComment(String commentId) async {
    await FirebaseFirestore.instance
        .collection('comments')
        .doc(commentId)
        .delete();
  }

  // Get comments for specific post
  static Stream<List<UserComment>> getPostComments(String postId) {
    return FirebaseFirestore.instance
        .collection('comments')
        .where('postId', isEqualTo: postId)
        .orderBy('commentTime', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => UserComment.fromFirestore(doc))
            .toList());
  }
}
