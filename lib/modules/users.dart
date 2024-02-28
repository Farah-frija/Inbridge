import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inbridge/modules/notification/model/Notification.dart';
import 'package:inbridge/Models/User.dart';
import 'package:inbridge/Widgets/Notifuser.dart';
import 'package:inbridge/Widgets/UserTile.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount:
            usersList.length, // Change this to the number of items you have
        itemBuilder: (context, index) {
          return Column(mainAxisSize: MainAxisSize.min, children: [
            Divider(),
            UserTile(user: usersList[index]),
          ]);
        });
  }
}
