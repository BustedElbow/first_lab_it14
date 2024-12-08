class UserPost {
  final String userImg;
  final String username;
  final String time;
  final String postContent;
  final String postImg;
  final String numComments;
  final String numShare;
  bool isLiked;

  UserPost({
    required this.userImg,
    required this.username,
    required this.time,
    required this.postContent,
    required this.postImg,
    required this.numComments,
    required this.numShare,
    this.isLiked = false,
  });
}