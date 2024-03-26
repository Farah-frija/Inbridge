import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:inbridge/Sprints/auth/Functions/validateInput.dart';
import 'package:inbridge/Sprints/auth/VerifyEmail/controllers/VerifyEmailController.dart';
import 'package:inbridge/Sprints/auth/widgets/CustomTextField.dart';
import 'package:inbridge/core/Utils/Enums/inputType.dart';
import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
import 'package:inbridge/core/constant/Themes/TextStyles/TextStyles.dart';
import 'package:inbridge/Sprints/auth/widgets/Backtopage.dart';
import 'package:inbridge/Sprints/auth/widgets/LoginButton.dart';
import 'package:inbridge/Sprints/auth/widgets/Logo.dart';

class VarifyEmailScreen extends StatelessWidget {
  const VarifyEmailScreen();

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => VerifyEmailControllerImp());
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            shadowColor: kgrey,
            scrolledUnderElevation: 0.5,
            elevation: 0.5,
            title: Text("Email Verification"),
            centerTitle: true,
          ),
          body: GetBuilder<VerifyEmailControllerImp>(
            builder: (controller) => Form(
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
                          valid: (val) {
                            return validInput(
                                val: val!,
                                min: 10,
                                max: 30,
                                type: InputType.email);
                          },
                          isNumber: false,
                          hint: 'Email',
                          isPassword: false,
                          textController: controller.email,
                        ),
                        SizedBox(height: 20.0),
                        SizedBox(height: 30.0),
                        LoginButton(
                          text: "Verify",
                          onpressed: () {
                            controller.verify();
                          },
                        ),
                        SizedBox(height: 30.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            "verification link will be sent to this Email address.",
                            style: kremark,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(height: 20.0),
                        BackToPage(
                          text: 'have an account? ',
                          text2: "LogIn",
                          onpressed: () {
                            controller.GoToLogin();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
