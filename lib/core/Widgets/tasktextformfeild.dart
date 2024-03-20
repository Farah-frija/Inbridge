import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:inbridge/Sprints/auth/login/Controller/loginController.dart';

import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
import 'package:inbridge/core/constant/Themes/TextStyles/TextStyles.dart';

class TaskFormFeild extends StatelessWidget {
  TaskFormFeild({
    required this.hint,
    required this.textController,
  });

  final String hint;

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: null,
      controller: textController,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Ktextfieldbg,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        hintStyle: khint,
      ),
    );
  }
}
