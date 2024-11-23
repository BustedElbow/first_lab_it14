import 'friend.dart';
import 'usercomment.dart';
import 'userpost.dart';
import 'account.dart';

class UserData {

List<UserPost> userList = [
  UserPost(
    userImg: 'images/photo_male_1.jpg',
    username: 'Rheniel Penional',
    time: '45 minutes ago',
    postContent: 'Time is Gold',
    postImg: 'images/products/image_4.jpg',
    numComments: '8.5k comments',
    numShare: '90 shares',
    isLiked: false,
  ),
  UserPost(
    userImg: 'images/photo_male_2.jpg',
    username: 'Miguel Andrei Tan',
    time: '1 hr ago',
    postContent: 'A coffee today keeps your worry a day.',
    postImg: 'images/products/image_5.jpg',
    numComments: '900 comments',
    numShare: '1k shares',
    isLiked: false,
  ),
  UserPost(
    userImg: 'images/photo_male_3.jpg',
    username: 'John Doe',
    time: '20 Nov at 9:30pm',
    postContent: 'Hi there!',
    postImg: 'images/products/image_7.jpg',
    numComments: '32k comments',
    numShare: '11 shares',
    isLiked: false,
  ),
];

List<Friend> friendList = [
  
  Friend(
    img: 'images/products/photo_female_7.jpg',
    name: 'Mary Shaw',
  ),
  Friend(
    img: 'images/photo_male_6.jpg',
    name: 'Raye D. Ban',
  ),
  Friend(
    img: 'images/photo_male_5.jpg',
    name: 'Eliot Anderson',
  ),
  Friend(
    img: 'images/photo_male_4.jpg',
    name: 'East T. Dante',
  ),
  Friend(
    img: 'images/photo_male_3.jpg',
    name: 'Corny Toe',
  ),
  Friend(
    img: 'images/photo_male_2.jpg',
    name: 'Sam Smith',
  ),
];

List<UserComment> commentList = [
  UserComment(
    commenterImg: 'images/products/photo_female_1.jpg',
    commenterName: 'Mary Shaw',
    commentTime: '3w',
    commentContent: 'What a lovely photo we got there!',
  ),
  UserComment(
    commenterImg: 'images/products/photo_female_2.jpg',
    commenterName: 'Kim Kardashan',
    commentTime: '5w',
    commentContent: 'Try the latte one!',
  ),
  UserComment(
    commenterImg: 'images/products/photo_female_4.jpg',
    commenterName: 'Chris Tina',
    commentTime: '7w',
    commentContent: 'Hello There!',
  ),
];

Account myUserAccount = Account(
  name: 'Rheniel Penional',
  email: 'rhenielpenional@email.com',
  img: 'images/photo_male_1.jpg',
  numFollowers: '1.5k',
  numPosts: '100',
  numFollowing: '420',
  numFriends: '4,920',
);

}