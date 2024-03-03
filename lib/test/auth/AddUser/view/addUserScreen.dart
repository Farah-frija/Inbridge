import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbridge/core/Functions/AlertQuit.dart';
import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
import 'package:inbridge/test/Widgets/ChangePhoto.dart';
import 'package:inbridge/test/auth/AddUser/AddUserController.dart';

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
                      builder: (controller) => ChangeCamera(
                          imageFile: controller.imageFile,
                          onpressed: controller.cam!.update),
                    ),
                    /*SizedBox(height: 30.0),
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
                    SizedBox(height: 20.0),
                    GetBuilder<LoginControllerImp>(
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
                            )),
                    SizedBox(height: 30.0),
                    LoginButton(
                      text: "login",
                      onpressed: () {
                        controller.login();
                      },
                    ),
                    SizedBox(height: 30.0),*/
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
