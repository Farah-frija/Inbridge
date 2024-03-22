import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:inbridge/Sprints/taskManagement/controllers/listOfTasksController.dart';
import 'package:inbridge/core/Widgets/TaskTile.dart';

class Optional extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ListOfTasksController controller = Get.find();
    return RefreshIndicator(
        onRefresh: () async {
          // Fetch the latest data from the database
          await controller.fetchTask();
          print("helooo");
        },
        child: Obx(() => ListView.builder(
              itemCount: controller.optionalList.length,
              itemBuilder: (context, index) {
                return TaskTile(index: index);
              },
            )));
  }
}
