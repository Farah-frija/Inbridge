import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:inbridge/Sprints/auth/linkApi.dart';
import 'package:inbridge/Sprints/taskManagement/controllers/addTaskController.dart';
import 'package:inbridge/core/Widgets/CircleAvatar.dart';

import 'package:inbridge/core/Widgets/SearchBar.dart';

import 'package:inbridge/core/constant/Themes/TextStyles/TextStyles.dart';
import 'package:inbridge/core/constant/Themes/paddings/Paddings.dart';
import 'package:inbridge/core/network/networkHandler.dart'; // Import Get package

class ListOfOptionsScreen extends StatelessWidget {
  final AddTaskController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a content creator'),
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
                            controller: controller.searchWord.value,
                            onchanged: (value) {
                              controller.filterUsers(
                                  value); // Call filterfilteredUsers function with the new search value
                            },
                          )),
                          Padding(
                            padding: kSearchPadding,
                          )
                        ],
                      ),
                      Obx(() => Expanded(
                            child: ListView.builder(
                              itemCount: controller.filteredUsers.value.length,
                              itemBuilder: (context, index) {
                                //userController.SetUser(user);
                                return Column(
                                  children: [
                                    Divider(),
                                    GestureDetector(
                                        onTap: () {
                                          // Handle tap on user item, navigate to user details page, etc.
                                        },
                                        child: ListTile(
                                          leading: Avatar(
                                            image: true,
                                            stringImage:
                                                "${AppLink.server}/${controller.filteredUsers.value[index].photoDeProfile}",
                                            radius: 25,
                                            border: true,
                                          ), // Icon at the beginning
                                          title: Text(
                                              controller.filteredUsers
                                                  .value[index].pseudo,
                                              style: ktitleName), // Title text
                                          subtitle: Text(
                                              controller.filteredUsers
                                                  .value[index].email,
                                              style: kemail), // Subtitle text
                                          // Icon at the end
                                          onTap: () {
                                            controller.selectedUser.value =
                                                controller.filteredUsers
                                                    .value[index].pseudo;
                                            controller.selectedId.value =
                                                controller.filteredUsers
                                                    .value[index].id;
                                            print(controller.filteredUsers
                                                .value[index].role);
                                            Get.back();
                                          },
                                        )),
                                  ],
                                );
                              },
                            ),
                          )),
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
