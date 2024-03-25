import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbridge/Sprints/auth/Functions/validateInput.dart';
import 'package:inbridge/Sprints/auth/widgets/CustomTextField.dart';
import 'package:inbridge/Sprints/auth/widgets/LoginButton.dart';
import 'package:inbridge/core/Functions/AlertQuit.dart';
import 'package:inbridge/core/Utils/Enums/inputType.dart';
import 'package:inbridge/core/Widgets/ChangePhoto.dart';
import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
import 'package:inbridge/Sprints/auth/AddUser/Controller/AddUserController.dart';
import 'package:inbridge/core/constant/Themes/TextStyles/TextStyles.dart';
import 'package:inbridge/core/network/networkHandler.dart';

class AddUseScreen extends StatelessWidget {
  const AddUseScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    AddUseController controller = Get.put(AddUseController());

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            shadowColor: kgrey,
            scrolledUnderElevation: 0.5,
            elevation: 0.5,
          ),
          body: WillPopScope(
            onWillPop: alertExitApp,
            child: controller.statusRequest.value == StatusRequest.loading
                ? const Center(child: CircularProgressIndicator())
                : Form(
                    key: controller.formstate,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                                child: Obx(() => ChangeCamera(
                                    imageFile: controller.imageFile.value,
                                    onPressed: () {
                                      controller.cam!.onpressed(context);
                                    }))),
                            SizedBox(height: 30.0),
                            CustomTextField(
                              isNumber: false,
                              valid: (val) => validInput(
                                  val: val!,
                                  min: 5,
                                  max: 100,
                                  type: InputType.email),
                              hint: 'Email',
                              isPassword: false,
                              textController: controller.email,
                            ),
                            SizedBox(height: 20.0),
                            CustomTextField(
                              isNumber: false,
                              valid: (val) => validInput(
                                  val: val!,
                                  min: 2,
                                  max: 20,
                                  type: InputType.name),
                              hint: 'Name',
                              isPassword: false,
                              textController: controller.name,
                            ),
                            SizedBox(height: 20.0),
                            CustomTextField(
                              isNumber: false,
                              valid: (val) => validInput(
                                  val: val!,
                                  min: 2,
                                  max: 20,
                                  type: InputType.FamilyName),
                              hint: 'Family Name',
                              isPassword: false,
                              textController: controller.familyName,
                            ),
                            SizedBox(height: 20.0),
                            CustomTextField(
                              isNumber: false,
                              valid: (val) => validInput(
                                  val: val!,
                                  min: 2,
                                  max: 20,
                                  type: InputType.userName),
                              hint: 'UserName',
                              isPassword: false,
                              textController: controller.userName,
                            ),
                            SizedBox(height: 20.0),
                            CustomTextField(
                              isNumber: true,
                              valid: (val) => validInput(
                                  val: val!,
                                  min: 8,
                                  max: 8,
                                  type: InputType.PhoneNumber),
                              hint: 'Phone Number',
                              isPassword: false,
                              textController: controller.phoneNumber,
                            ),
                            SizedBox(height: 20.0),
                            CustomTextField(
                              isNumber: false,
                              valid: (val) => validInput(
                                  val: val!,
                                  min: 5,
                                  max: 100,
                                  type: InputType.adresse),
                              hint: 'Adresse',
                              isPassword: false,
                              textController: controller.adresse,
                            ),
                            SizedBox(height: 20.0),
                            CustomTextField(
                              isNumber: true,
                              valid: (val) => validInput(
                                  val: val!,
                                  min: 8,
                                  max: 8,
                                  type: InputType.cin),
                              hint: 'N CIN',
                              isPassword: false,
                              textController: controller.cin,
                            ),
                            SizedBox(height: 20.0),
                            Text("Date of Birth", style: kemail),
                            Obx(() => DateTimeField(
                                  decoration: const InputDecoration(
                                    helperStyle: khint,
                                  ),
                                  value: controller.dateOfBirth.value,
                                  mode: DateTimeFieldPickerMode.date,
                                  onChanged: (value) {
                                    controller.updateDateOfBirth(value!);
                                  },
                                )),
                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Obx(() => Row(
                                      children: <Widget>[
                                        Radio(
                                          value: "homme",
                                          groupValue: controller.sexe.value,
                                          onChanged: (value) {
                                            controller.updateSexe(value!);
                                          },
                                        ),
                                        Text('Homme'),
                                      ],
                                    )),
                                Obx(() => Row(
                                      children: <Widget>[
                                        Radio(
                                          value: "femme",
                                          groupValue: controller.sexe.value,
                                          onChanged: (value) {
                                            controller.updateSexe(value!);
                                          },
                                        ),
                                        Text('femme'),
                                      ],
                                    )),
                              ],
                            ),
                            SizedBox(height: 30.0),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: LoginButton(
                                text: "Add User",
                                onpressed: () {
                                  controller.addUser();
                                  if (controller.validForm.value &&
                                      (!controller.validePhoto.value)) {
                                    print("box");
                                    _showDialog(context,
                                        "veuillez fournir une photo de profile ");
                                  }
                                },
                              ),
                            ),
                            SizedBox(height: 50.0),
                          ],
                        ),
                      ),
                    ),
                  ),
          )),
    );
  }
}

void _showDialog(BuildContext context, String text) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Erreur"),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}
