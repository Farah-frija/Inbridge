import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbridge/core/Utils/Enums/inputType.dart';
import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
import 'package:inbridge/core/Widgets/ChangePhoto.dart';
import 'package:inbridge/features/auth/AddUser/Controller/AddUserController.dart';
import 'package:inbridge/core/Functions/AlertQuit.dart';
import 'package:inbridge/features/auth/Functions/validateInput.dart';
import 'package:inbridge/features/auth/login/widgets/CustomTextField.dart';
import 'package:inbridge/features/auth/widgets/LoginButton.dart';

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
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  children: <Widget>[
                    GetBuilder<AddUseController>(
                      builder: (controller) => ChangeCamera(),
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
                            val: val!, min: 5, max: 100, type: InputType.name);
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
                            max: 100,
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
                            val: val!,
                            min: 5,
                            max: 100,
                            type: InputType.userName);
                      },
                      hint: 'UserName',
                      isPassword: false,
                      textController: controller.userName,
                    ),
                    //date of birth
                    SizedBox(height: 20.0),
                    /*CustomTextField(
                      isNumber: false,
                      valid: (val) {
                        return validInput(
                            val: val!, min: 5, max: 100, type: InputType.dob);
                      },
                      hint: 'Date of birth',
                      isPassword: false,
                      textController: controller.dob,
                    ),*/
                    //sexe
                    SizedBox(height: 20.0),
                    CustomTextField(
                      isNumber: false,
                      valid: (val) {
                        return validInput(
                            val: val!, min: 5, max: 100, type: InputType.sexe);
                      },
                      hint: 'Sexe',
                      isPassword: false,
                      textController: controller.sexe,
                    ),
                    //phoneNumber
                    SizedBox(height: 20.0),
                    CustomTextField(
                      isNumber: false,
                      valid: (val) {
                        return validInput(
                            val: val!,
                            min: 5,
                            max: 100,
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
                            val: val!,
                            min: 5,
                            max: 100,
                            type: InputType.diplome);
                      },
                      hint: 'Diplome',
                      isPassword: false,
                      textController: controller.diplome,
                    ),
                    //institute
                    SizedBox(height: 20.0),
                    CustomTextField(
                      isNumber: false,
                      valid: (val) {
                        return validInput(
                            val: val!,
                            min: 5,
                            max: 100,
                            type: InputType.institute);
                      },
                      hint: 'institut',
                      isPassword: false,
                      textController: controller.institute,
                    ),
                    //CIN
                    SizedBox(height: 20.0),
                    CustomTextField(
                      isNumber: false,
                      valid: (val) {
                        return validInput(
                            val: val!, min: 5, max: 100, type: InputType.cin);
                      },
                      hint: 'N CIN',
                      isPassword: false,
                      textController: controller.cin,
                    ),
                    /////////////////////////////////////////////////////////////////////////
                    SizedBox(height: 30.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: LoginButton(
                        text: "Add User",
                        onpressed: () {
                          controller.AddUser();
                          if (!controller.valide) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Erreur"),
                                  content: Text(
                                      "Veuillez fournir une photo de profile"),
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
