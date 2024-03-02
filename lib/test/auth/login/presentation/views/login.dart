import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:inbridge/core/Functions/AlertQuit.dart';
import 'package:inbridge/core/Functions/validateInput.dart';
import 'package:inbridge/core/Utils/Enums/inputType.dart';
import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
import 'package:inbridge/core/constant/images/images.dart';
import 'package:inbridge/test/auth/login/presentation/getx/loginController.dart';
import 'package:inbridge/test/auth/login/presentation/views/ForgotPassword.dart';
import 'package:inbridge/test/auth/login/presentation/widgets/Backtopage.dart';
import 'package:inbridge/test/auth/login/presentation/widgets/CustomTextField.dart';

import 'package:inbridge/test/auth/login/presentation/widgets/LoginButton.dart';
import 'package:inbridge/test/auth/login/presentation/widgets/Logo.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    LoginControllerImp controller = Get.put(LoginControllerImp());

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
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Center(
                      child: Logo(),
                    ),
                    SizedBox(height: 30.0),
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
                    SizedBox(height: 30.0),
                    BackToPage(
                      text: 'Forgot Password?',
                      onpressed: () {
                        controller.goToForgetPassword();
                      },
                    ),
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
