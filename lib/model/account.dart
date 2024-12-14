import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  final String uid;
  final String name;
  final String email;
  final String img;
  final String numFollowers;
  final String numPosts;
  final String numFollowing;
  final String numFriends;

  Account({
    required this.uid,
    required this.name,
    required this.email,
    required this.img,
    required this.numFollowers,
    required this.numPosts,
    required this.numFollowing,
    required this.numFriends,
  });

  Map<String, dynamic> toMap() {
    return{
      'uid': uid,
      'name': name,
      'email': email,
      'img': img,
      'numFollowers': numFollowers,
      'numPosts': numPosts,
      'numFollowing': numFollowing,
      'numFriends': numFriends,
    };
  }

  factory Account.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Account(
      uid: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      img: data['img'] ?? '',
      numFollowers: data['numFollowers'] ?? '0',
      numPosts: data['numPosts'] ?? '0',
      numFollowing: data['numFollowing'] ?? '0',
      numFriends: data['numFriends'] ?? '0',
    );
  }

  factory Account.createNew({
    required String uid,
    required String name,
    required String email,
    String img = '',
  }) {
    return Account(
      uid: uid,
      name: name,
      email: email,
      img: img,
      numFollowers: '0',
      numPosts: '0',
      numFollowing: '0',
      numFriends: '0',
    );
  }
}