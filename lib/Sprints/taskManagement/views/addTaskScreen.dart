import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:inbridge/Sprints/taskManagement/controllers/addTaskController.dart';
import 'package:inbridge/core/Functions/AlertQuit.dart';
import 'package:inbridge/core/Widgets/NextButton.dart';
import 'package:inbridge/core/Widgets/tasktextformfeild.dart';
import 'package:inbridge/core/constant/Approutes.dart';
import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
import 'package:inbridge/core/constant/Themes/TextStyles/TextStyles.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen();

  @override
  Widget build(BuildContext context) {
    AddTaskController controller = Get.put(AddTaskController());

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Add task", style: kuserName),
              centerTitle: true,
              shadowColor: kgrey,
              scrolledUnderElevation: 0.5,
              elevation: 0.5,
            ),
            body: WillPopScope(
                onWillPop: alertExitApp,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: SingleChildScrollView(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            /* Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    10.0), // Set your desired border radius here
                                border: Border.all(
                                    color: const Color.fromARGB(255, 227, 200,
                                        200)), // Set border color if needed
                              ),
                              width: double.infinity,
                              child: Obx(() => DropdownButton<String>(
                                    // Set the value to null initially
                                    value: controller.category.value,
                                    // Set the list of items
                                    items: controller.categories
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    // Define the onChanged callback
                                    onChanged: (String? newValue) {
                                      // Handle when an item is selected
                                      print(newValue);
                                      controller.selectedcategoryIndex.value =
                                          controller.categories
                                              .indexOf(newValue);
                                      controller.setCategory(newValue);
                                      print(controller.category.value);
                                    },
                                    // Add a hint to show when no item is selected
                                    hint: Text('Select a category'),
                                  )),
                            ),*/
                            SizedBox(height: 20),
                            TaskFormFeild(
                                hint: "title",
                                textController: controller.title),
                            SizedBox(height: 20),
                            TaskFormFeild(
                                hint: "description",
                                textController: controller.description),
                            SizedBox(height: 20),
                            TaskFormFeild(
                                hint: "Guidelines ",
                                textController: controller.guidelines),
                            SizedBox(height: 20),
                            Text("deadline", style: kuserName),
                            Obx(() => DateTimeField(
                                  decoration: const InputDecoration(
                                    helperStyle: khint,
                                  ),
                                  value: controller.deadline.value,
                                  mode: DateTimeFieldPickerMode.date,
                                  onChanged: (value) {
                                    controller.updateDateOfBirth(value!);
                                  },
                                )),
                            SizedBox(height: 30),
                            Obx(
                              () => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                          value: "optional",
                                          groupValue: controller.option.value,
                                          onChanged: (value) {
                                            controller.updateOption(value!);
                                          },
                                        ),
                                        Text('optional'),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Radio(
                                          value: "mandatory",
                                          groupValue: controller.option.value,
                                          onChanged: (value) {
                                            controller.updateOption(value!);
                                            print(controller.option.value);
                                          },
                                        ),
                                        Text('mandatory'),
                                      ],
                                    ),
                                  ]),
                            ),
                            SizedBox(height: 20),
                            Obx(() {
                              if (controller.option.value == "mandatory") {
                                return Row(
                                  children: [
                                    Text("affected to ", style: kuserName),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            8), // Set the border radius as desired
                                        border: Border.all(
                                            color: Colors
                                                .grey), // Add a border if needed
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          controller.GetUsers();
                                          Get.toNamed(AppRoute.listOfOptions);
                                        },
                                        child: Text(
                                          controller.selectedUser.value ??
                                              'Choose a content creator',
                                          style: TextStyle(
                                            color: KRoseFonce,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return SizedBox(
                                    height:
                                        20); // Return an empty SizedBox if the option is not "mandatory"
                              }
                            }),
                            SizedBox(height: 40),
                            Center(
                                child: NextButton(
                              text: "Add Task",
                              Onpressed: () {
                                controller.onPressed();
                              },
                            )),
                            SizedBox(height: 40),
                          ]),
                    )))));
  }
}
