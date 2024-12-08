class UserComment {
  String id;
  String commenterImg;
  String commenterName;
  String commentTime;
  String commentContent;
  bool isLiked;

  UserComment({
    required this.id,
    required this.commenterImg,
    required this.commenterName,
    required this.commentTime,
    required this.commentContent,
    this.isLiked = false,
  });

   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'commenterName': commenterName,
      'commentContent': commentContent,
      'commenterTime': commentTime,
      'commenterImg': commenterImg,
      'isLiked': isLiked,
    };
  }
}