import 'friend.dart';
import 'usercomment.dart';
import 'userpost.dart';
import 'account.dart';

class UserData {
  List<UserPost> userList = [
    // UserPost(
    //   userImg: 'lib/images/Rheniel_Profile.jpg',
    //   username: 'Rheniel Penional',
    //   time: '45 minutes ago',
    //   postContent: 'Time is Gold',
    //   postImg: 'lib/images/timeIsGold.jpg',
    //   numComments: '8.5k comments',
    //   numShare: '90 shares',
    //   isLiked: false,
    // ),
    // UserPost(
    //   userImg: 'lib/images/Miguel_Profile.jpg',
    //   username: 'Miguel Andrei Tan',
    //   time: '1 hr ago',
    //   postContent: 'A coffee today keeps your worry a day.',
    //   postImg: 'lib/images/coffeeDay.jpg',
    //   numComments: '900 comments',
    //   numShare: '1k shares',
    //   isLiked: false,
    // ),
    // UserPost(
    //   userImg: 'lib/images/Rheniel_Profile.jpg',
    //   username: 'Rheniel Penional',
    //   time: '20 Nov at 9:30pm',
    //   postContent: 'Hi there!',
    //   postImg: 'lib/images/timeIsGold.jpg',
    //   numComments: '32k comments',
    //   numShare: '11 shares',
    //   isLiked: false,
    // ),
  ];

  List<Friend> friendList = [
    Friend(
      img: 'lib/images/Mary_Shaw.jpg',
      name: 'Mary Shaw',
    ),
    Friend(
      img: 'lib/images/Raye_D._Ban.jpg',
      name: 'Raye D. Ban',
    ),
    Friend(
      img: 'lib/images/Eliot_Anderson.jpg',
      name: 'Eliot Anderson',
    ),
    Friend(
      img: 'lib/images/East_Dante.jpg',
      name: 'East T. Dante',
    ),
    Friend(
      img: 'lib/images/Corny_Toe.jpg',
      name: 'Corny Toe',
    ),
    Friend(
      img: 'lib/images/Sam_Smith.jpg',
      name: 'Sam Smith',
    ),
  ];

  // List<UserComment> commentList = [
  //   UserComment(
  //     commenterImg: 'lib/images/Miguel_Profile.jpg',
  //     commenterName: 'Miguel Andrei Tan',
  //     commentTime: '3w',
  //     commentContent: 'What a lovely photo we got there!',
  //   ),
  //   UserComment(
  //     commenterImg: 'lib/images/Rheniel_Profile.jpg',
  //     commenterName: 'Rheniel Penional',
  //     commentTime: '5w',
  //     commentContent: 'Try the latte one!',
  //   ),
  //   UserComment(
  //     commenterImg: 'lib/images/Miguel_Profile.jpg',
  //     commenterName: 'Miguel Andrei Tan',
  //     commentTime: '7w',
  //     commentContent: 'Hello There!',
  //   ),
  // ];

  Account myUserAccount = Account(
    uid: 'asdfasdf',
    name: 'Rheniel Penional',
    email: 'rhenielpenional@email.com',
    img: 'lib/images/Rheniel_Profile.jpg',
    numFollowers: '1.5k',
    numPosts: '100',
    numFollowing: '420',
    numFriends: '4,920',
  );
}
