import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inbridge/test/modules/notification/model/Notification.dart';
import 'package:inbridge/test/Models/User.dart';
import 'package:inbridge/test/Widgets/Notifuser.dart';
import 'package:inbridge/test/Widgets/UserTile.dart';

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
