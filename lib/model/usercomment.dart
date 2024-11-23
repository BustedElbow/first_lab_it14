class UserComment {
  final String commenterImg;
  final String commenterName;
  final String commentTime;
  final String commentContent;
  bool isLiked;

  UserComment({
    required this.commenterImg,
    required this.commenterName,
    required this.commentTime,
    required this.commentContent,
    this.isLiked = false,
  });
}