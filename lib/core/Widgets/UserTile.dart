import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inbridge/test/modules/notification/model/Notification.dart';
import 'package:inbridge/test/Models/User.dart';
import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
import 'package:inbridge/core/constant/Themes/TextStyles/TextStyles.dart';
import 'package:inbridge/core/Widgets/CircleAvatar.dart';

class UserTile extends StatefulWidget {
  UserTile({required this.user});
  User user;
  @override
  State<UserTile> createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  late File? _image;
  late String? _name;
  late String? _description;
  late bool _blocked;
  late bool _admin;
  late User _user;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _image = _user.photo;
    _name = _user.userName;
    _description = _user.description;
    _admin = _user.admin;
    _blocked = _user.blocked;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _ProfileImage(
          image: _image,
          admin: _admin,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, top: 3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Adjust the spacing between the icon and text
                Text(_name ?? "default name", style: ktitleName),
                Text(_description ?? "default text", style: ksubtitle),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                _blocked ? Icons.lock_outlined : Icons.lock_open,
                size: 20,
              ),
              SizedBox(width: 20),
              Icon(
                Icons.more_vert,
                color: kblue,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class _ProfileImage extends StatelessWidget {
  _ProfileImage({required this.image, this.admin = false});
  File? image;
  bool admin;
//todo prend comme parametres File image
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Avatar(
          image: true,
          photo: image,
          radius: 25,
          border: admin ? true : false,
        ),
        Positioned(
          right: 5,
          bottom: 0,
          child: admin
              ? Avatar(
                  image: false,
                  border: false,
                  color: KRoseFonce,
                  icon: Icons.star,
                  radius: 10,
                )
              : Container(),
        ),
      ],
    );
  }
}
