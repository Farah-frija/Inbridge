import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
import 'package:inbridge/core/constant/Themes/TextStyles/TextStyles.dart';
import 'package:inbridge/features/auth/login/Controller/VerifyCodeController.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class VerifyCodeScreen extends StatelessWidget {
  const VerifyCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VerifyCodeControllerImp controller = Get.put(VerifyCodeControllerImp());
    return Scaffold(
      appBar: AppBar(
        shadowColor: kgrey,
        scrolledUnderElevation: 0.5,
        elevation: 0.5,
        title: Text("Verification code"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: ListView(children: [
          const SizedBox(height: 20),
          /*const CustomTextTitleAuth(text: "Check code"),
          const SizedBox(height: 10),
          const CustomTextBodyAuth(
              text: "Please Enter The Digit Code Sent To wael@gmail.com"),
          const SizedBox(height: 15),*/
          OtpTextField(
            fieldWidth: 50.0,
            borderRadius: BorderRadius.circular(15),
            numberOfFields: 5,
            cursorColor: KRoseFonce,
            borderColor: KRoseFonce,
            focusedBorderColor: KRoseFonce,
            textStyle: kuserName,
            showFieldAsBox: true,
            onCodeChanged: (String code) {},
            onSubmit: (String verificationCode) {
              controller.goToResetPassword();
            },
          ),
          const SizedBox(height: 40),
        ]),
      ),
    );
  }
}
