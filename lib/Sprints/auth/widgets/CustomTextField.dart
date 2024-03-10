import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbridge/Sprints/auth/login/Controller/loginController.dart';

import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
import 'package:inbridge/core/constant/Themes/TextStyles/TextStyles.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(
      {required this.hint,
      required this.isPassword,
      required this.textController,
      required this.valid,
      required this.isNumber,
      this.visible,
      this.setVisible});
  final Function()? setVisible;
  final bool? visible;
  final String? Function(String?) valid;
  final String hint;
  final bool isPassword;
  final bool isNumber;
  final TextEditingController textController;
  final LoginControllerImp controller = Get.put(LoginControllerImp());
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: isNumber
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      validator: valid,
      obscureText: isPassword && visible != null ? !visible! : false,
      controller: textController,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Ktextfieldbg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        hintStyle: khint,
        suffixIcon: isPassword
            ? IconButton(
                onPressed: setVisible != null ? setVisible : null,
                icon: controller.visible
                    ? Icon(Icons.visibility)
                    : Icon(Icons.visibility_off),
              )
            : null,
      ),
    );
  }
}
