import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:inbridge/Sprints/auth/Users/controller/OnlyOneUserController.dart';
import 'package:inbridge/Sprints/auth/Users/controller/UsersController.dart';
import 'package:inbridge/Sprints/auth/Users/model/UserModel.dart';
import 'package:inbridge/Sprints/auth/linkApi.dart';
import 'package:inbridge/core/Widgets/CircleAvatar.dart';
import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
import 'package:inbridge/core/constant/Themes/TextStyles/TextStyles.dart';

class UserTile extends StatelessWidget {
  final UsersControllerImp controller = Get.find();
  UserTile({required this.user});
  int user;
  @override
  Widget build(BuildContext context) {
    print(controller.users.value[user].email);
    return Obx(
      () => Container(
        //color: controller.Currentuser.value.verifie ? kgrey : kwhite,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProfileImage(
              image:
                  "${AppLink.server}/${controller.users.value[user].photoDeProfile}",
              verifie: controller.users.value[user].verifie,
              role: controller.users.value[user].role,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(controller.users.value[user].pseudo,
                        style: ktitleName),
                    Text(
                        controller.users.value[user].verifie == false
                            ? " not verified"
                            : controller.users.value[user].bloque == true
                                ? "blocked"
                                : "actif",
                        style: ksubtitle),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Row(
                  children: [
                    controller.users.value[user].verifie
                        ? IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  bool isBlocked =
                                      controller.users.value[user].bloque;
                                  return AlertDialog(
                                    title: Text(isBlocked
                                        ? 'Unblock User?'
                                        : 'Block User?'),
                                    content: Text(isBlocked
                                        ? 'Are you sure you want to unblock this user?'
                                        : 'Are you sure you want to block this user?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                          controller.updateUserBloque(user);
                                        },
                                        child: Text(
                                            isBlocked ? 'Unblock' : 'Block'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: Text('Cancel'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: Obx(
                              () => Icon(
                                controller.users.value[user].bloque
                                    ? Icons.lock_open
                                    : Icons.lock_outline,
                                size: 20,
                              ),
                            ))
                        : differenceInDays(
                                    controller.users.value[user].createdAt!) >=
                                1
                            ? IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Delete unverified user?'),
                                        content: Text(
                                            "This user has been created  ${differenceInDays(controller.users.value[user].createdAt!)} day ago"),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            },
                                            child: Text("Delete user"),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              // Close the dialog
                                            },
                                            child: Text('Cancel'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: Icon(
                                  Icons.delete,
                                  size: 20,
                                ))
                            : SizedBox(),
                    SizedBox(width: 20),
                    IconButton(
                        icon: Icon(Icons.more_vert),
                        color: kblue,
                        onPressed: () {
                          _showBottomSheet(context);
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: null,
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit, color: KroseClair),
                      SizedBox(width: 20),
                      Text("Edit profile info", style: kemail)
                    ]),
              ),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(Icons.photo, color: KroseClair),
                SizedBox(width: 20),
                Text("Edit profile photo", style: kemail)
              ])
            ],
          ),
        );
      },
    );
  }
}

class _ProfileImage extends StatelessWidget {
  _ProfileImage(
      {required this.image, required this.verifie, required this.role});
  String? image;
  bool verifie;
  String role;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Avatar(
          image: true,
          stringImage: image,
          radius: 25,
          border: verifie ? true : true,
        ),
        Positioned(
            right: 5,
            bottom: 0,
            child: verifie
                ? Avatar(
                    image: false,
                    border: false,
                    color: KroseClair,
                    icon: Icons.check,
                    radius: 10,
                  )
                : Avatar(
                    image: false,
                    border: false,
                    color: KRoseFonce,
                    icon: Icons.sync_problem_outlined,
                    radius: 10,
                  )),
      ],
    );
  }
}

int differenceInDays(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);
  return difference.inDays;
}
