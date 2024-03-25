import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbridge/Sprints/auth/Users/controller/OnlyOneUserController.dart';
import 'package:inbridge/Sprints/auth/Users/controller/UsersController.dart';
import 'package:inbridge/core/Widgets/IconButton.dart';
import 'package:inbridge/core/Widgets/SearchBar.dart';
import 'package:inbridge/core/Widgets/UserTile.dart';
import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
import 'package:inbridge/core/constant/Themes/Icons/icons.dart';
import 'package:inbridge/core/constant/Themes/TextStyles/TextStyles.dart';
import 'package:inbridge/core/constant/Themes/paddings/Paddings.dart';
import 'package:inbridge/core/network/networkHandler.dart'; // Import Get package

class UsersListScreen extends StatelessWidget {
  final UsersControllerImp controller = Get.put(UsersControllerImp());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: Obx(
        () {
          if (controller.statusRequest.value == StatusRequest.loading) {
            return Center(child: CircularProgressIndicator());
          } else if (controller.statusRequest.value == StatusRequest.success) {
            return RefreshIndicator(
                onRefresh: () async {
                  // Fetch the latest data from the database
                  await controller.GetUsers();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: MySearchBar(
                                  controller: controller.searchWord.value)),
                          Padding(
                            padding: kSearchPadding,
                            child: SmallButton(
                                color: KroseClair,
                                icon: kaddIcon,
                                radius: KSearchRadius,
                                padding: 10),
                          )
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.users.value.length,
                          itemBuilder: (context, index) {
                            final user = controller.users.value[index];
                            print(user.nom);

                            //userController.SetUser(user);
                            return Column(
                              children: [
                                Divider(),
                                GestureDetector(
                                  onTap: () {},
                                  child: UserTile(user: index),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ));
          } else {
            return Center(child: Text(controller.errorMessage.value));
          }
        },
      ),
    );
  }
}
