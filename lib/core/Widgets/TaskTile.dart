import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:inbridge/Sprints/taskManagement/controllers/listOfTasksController.dart';
import 'package:inbridge/Sprints/taskManagement/models/UserTaskModel.dart';
import 'package:inbridge/core/Utils/Enums/TaskState.dart';
import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
import 'package:inbridge/core/constant/Themes/TextStyles/TextStyles.dart';

class TaskTile extends StatelessWidget {
  TaskTile({super.key, required this.index});
  int index;
  @override
  Widget build(BuildContext context) {
    ListOfTasksController controller = Get.find();
    return GestureDetector(
      onTap: () {
        print("mlwl haka lu ${controller.mandatoryList.value[index].lu}");
        if (!controller.mandatoryList.value[index].lu) {
          controller.mandatoryList.value[index].lu = true;
          print("baaed lu haka ${controller.mandatoryList.value[index].lu}");
          controller.updateTile(index, 1);
          controller.mandatoryList.refresh();
        }
      },
      child: Obx(() => Container(
            color: !controller.mandatoryList.value[index].lu
                ? Color.fromARGB(17, 250, 148, 132)
                : kwhite,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 30),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Obx(() => Icon(
                    controller.mandatoryList.value[index].tache.etat ==
                            TaskState.done
                        ? Icons.done
                        : controller.mandatoryList.value[index].tache.etat ==
                                TaskState.pending
                            ? Icons.pending_actions_rounded
                            : controller.mandatoryList.value[index].tache
                                        .etat ==
                                    TaskState.missed
                                ? Icons.cancel
                                : null,
                    color: controller.mandatoryList.value[index].tache.etat ==
                            TaskState.done
                        ? Color.fromARGB(255, 0, 69, 2)
                        : controller.mandatoryList.value[index].tache.etat ==
                                TaskState.pending
                            ? KroseClair
                            : controller.mandatoryList.value[index].tache
                                        .etat ==
                                    TaskState.missed
                                ? Color.fromARGB(255, 171, 22, 22)
                                : null,
                  )),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, top: 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Adjust the spacing between the icon and text
                          Text(controller.mandatoryList[index].tache.titre!,
                              style: ktitleName),

                          !controller.mandatoryList.value[index].lu
                              ? Icon(
                                  Icons.circle,
                                  size: 10,
                                  color: KRoseFonce,
                                )
                              : SizedBox(),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("2 days are left", style: ksubtitle),
                          Text("2h ago", style: ksubtitle),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          )),
    );
  }
}
