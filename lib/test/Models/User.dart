import 'dart:io';

import 'package:flutter/material.dart';

final List<String> privateposts = [
  "assets/private/private1.png",
  "assets/private/private2.png",
  "assets/private/private3.png"
];
final List<String> publicposts = [
  "assets/private/private1.png",
  "assets/private/private2.png",
  "assets/private/private3.png"
];

class User {
  int? _id;
  List<String>? _privateGallery;
  List<String>? _publicGallery;
  File? _photo;
  String? _userName;
  String? _email;
  bool _blocked = false;
  bool _admin = false;
  String? _description;
  User.initial();
  User({
    required List<String>? privateGallery,
    required List<String>? publicGallery,
    required File? photo,
    required String? userName,
    required String? email,
    required int? id,
    required String? description,
    bool blocked = false,
    bool admin = false,
  })  : _privateGallery = privateGallery,
        _publicGallery = publicGallery,
        _photo = photo,
        _userName = userName,
        _email = email,
        _id = id,
        _blocked = blocked,
        _admin = admin,
        _description = description;

  List<String>? get privateGallery => _privateGallery;
  List<String>? get publicGallery => _publicGallery;
  File? get photo => _photo;
  String? get userName => _userName;
  String? get email => _email;
  String? get description => _description;
  bool get blocked => _blocked;
  bool get admin => _admin;

  set privateGallery(List<String>? value) {
    _privateGallery = value;
  }

  set publicGallery(List<String>? value) {
    _publicGallery = value;
  }

  set photo(File? value) {
    _photo = value;
  }

  set userName(String? value) {
    _userName = value;
  }

  set email(String? value) {
    _email = value;
  }

  set blocked(bool value) {
    _blocked = value;
  }

  set admin(bool value) {
    _admin = value;
  }

  set description(String? value) {
    _description = value;
  }
}

final User currentUser = User(
  email: 'user@gmail.com',
  privateGallery: privateposts,
  publicGallery: publicposts,
  id: 0,
  userName: 'Current User',
  photo: null,
  description: "User description",
);

// USERS
final User greg = User(
  email: 'user@gmail.com',
  privateGallery: privateposts,
  publicGallery: publicposts,
  id: 1,
  userName: 'Greg',
  photo: null,
  description: "User description",
);
final User james = User(
  email: 'user@gmail.com',
  privateGallery: privateposts,
  publicGallery: publicposts,
  id: 2,
  userName: 'James',
  photo: null,
  description: "User description",
);
final User john = User(
  email: 'user@gmail.com',
  privateGallery: privateposts,
  publicGallery: publicposts,
  id: 3,
  userName: 'John',
  photo: null,
  description: "User description",
);
final User olivia = User(
  email: 'user@gmail.com',
  privateGallery: privateposts,
  publicGallery: publicposts,
  id: 4,
  userName: 'Olivia',
  photo: null,
  description: "User description",
);
final User sam = User(
  email: 'user@gmail.com',
  privateGallery: privateposts,
  publicGallery: publicposts,
  id: 5,
  userName: 'Sam',
  photo: null,
  description: "User description",
);
final User sophia = User(
  email: 'user@gmail.com',
  privateGallery: privateposts,
  publicGallery: publicposts,
  id: 6,
  userName: 'Sophia',
  photo: null,
  description: "User description",
  blocked: true,
);
final User steven = User(
  email: 'user@gmail.com',
  privateGallery: privateposts,
  publicGallery: publicposts,
  id: 7,
  userName: 'Steven',
  photo: null,
  description: "User description",
  admin: true,
);
final List<User> usersList = [
  currentUser,
  greg,
  james,
  john,
  olivia,
  sam,
  sophia,
  steven,
];
