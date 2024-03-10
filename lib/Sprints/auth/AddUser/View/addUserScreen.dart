import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
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

class AddUseScreen extends StatelessWidget {
  const AddUseScreen({super.key});

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
        child: Form(
          key: controller.formstate,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  GetBuilder<AddUseController>(
                    builder: (controller) => Center(child: ChangeCamera()),
                  ),
                  SizedBox(height: 30.0),
                  //email
                  CustomTextField(
                    isNumber: false,
                    valid: (val) {
                      return validInput(
                          val: val!, min: 5, max: 100, type: InputType.email);
                    },
                    hint: 'Email',
                    isPassword: false,
                    textController: controller.email,
                  ),
                  //Name
                  SizedBox(height: 20.0),
                  CustomTextField(
                    isNumber: false,
                    valid: (val) {
                      return validInput(
                          val: val!, min: 5, max: 20, type: InputType.name);
                    },
                    hint: 'Name',
                    isPassword: false,
                    textController: controller.name,
                  ),
                  //family Name
                  SizedBox(height: 20.0),
                  CustomTextField(
                    isNumber: false,
                    valid: (val) {
                      return validInput(
                          val: val!,
                          min: 5,
                          max: 20,
                          type: InputType.FamilyName);
                    },
                    hint: 'Family Name',
                    isPassword: false,
                    textController: controller.familyName,
                  ),
                  //username
                  SizedBox(height: 20.0),
                  CustomTextField(
                    isNumber: false,
                    valid: (val) {
                      return validInput(
                          val: val!, min: 5, max: 20, type: InputType.userName);
                    },
                    hint: 'UserName',
                    isPassword: false,
                    textController: controller.userName,
                  ),

                  //phoneNumber
                  SizedBox(height: 20.0),
                  CustomTextField(
                    isNumber: true,
                    valid: (val) {
                      return validInput(
                          val: val!,
                          min: 8,
                          max: 8,
                          type: InputType.PhoneNumber);
                    },
                    hint: 'Phone Number',
                    isPassword: false,
                    textController: controller.phoneNumber,
                  ),
                  //diplome
                  SizedBox(height: 20.0),
                  CustomTextField(
                    isNumber: false,
                    valid: (val) {
                      return validInput(
                          val: val!, min: 5, max: 100, type: InputType.adresse);
                    },
                    hint: 'Adresse',
                    isPassword: false,
                    textController: controller.adresse,
                  ),

                  SizedBox(height: 20.0),
                  //CIN

                  CustomTextField(
                    isNumber: true,
                    valid: (val) {
                      return validInput(
                          val: val!, min: 8, max: 8, type: InputType.cin);
                    },
                    hint: 'N CIN',
                    isPassword: false,
                    textController: controller.cin,
                  ),
                  //date of birth
                  SizedBox(height: 20.0),
                  Text("Date of Birth", style: kemail),

                  GetBuilder<AddUseController>(
                    builder: (controller) => DateTimeField(
                      decoration: const InputDecoration(
                        helperStyle: khint,
                      ),
                      value: controller.dateOfBirth,
                      mode: DateTimeFieldPickerMode.date,
                      onChanged: (value) {
                        controller.updateDateOfBith(value!);
                      },
                    ),
                  ),
                  SizedBox(height: 20.0),
                  GetBuilder<AddUseController>(
                    builder: (controller) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: <Widget>[
                            Radio(
                                value: "homme",
                                groupValue: controller.sexe,
                                onChanged: (value) {
                                  controller.updateSexe(value!);
                                }),
                            Text('Homme'),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Radio(
                                value: "femme",
                                groupValue: controller.sexe,
                                onChanged: (value) {
                                  controller.updateSexe(value!);
                                }),
                            Text('femme'),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /////////////////////////////////////////////////////////////////////////
                  SizedBox(height: 30.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: LoginButton(
                      text: "Add User",
                      onpressed: () {
                        controller.AddUser();
                        if (controller.validForm &&
                            (!controller.validePhoto ||
                                !controller.validDate)) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Erreur"),
                                content: Text(
                                    "veuillez fournir une photo de profile "),
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
                      },
                    ),
                  ),
                  SizedBox(height: 30.0),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}

///mot de passe /////////////////
/* GetBuilder<LoginControllerImp>(
                        builder: (controller) => CustomTextField(
                              valid: (val) {
                                return validInput(
                                    val: val!,
                                    min: 5,
                                    max: 10,
                                    type: InputType.password);
                              },
                              isNumber: false,
                              hint: 'Password',
                              isPassword: true,
                              textController: controller.password,
                            ))*/

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
