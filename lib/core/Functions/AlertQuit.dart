import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inbridge/core/constant/Themes/Colors/colors.dart';

Future<bool> alertExitApp() {
  Get.defaultDialog(
      title: "تنبيه",
      titleStyle:
          const TextStyle(color: KRoseFonce, fontWeight: FontWeight.bold),
      middleText: "Do you want to quit the app ?",
      actions: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(KRoseFonce)),
            onPressed: () {
              exit(0);
            },
            child: const Text("تاكيد")),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(KRoseFonce)),
            onPressed: () {
              Get.back();
            },
            child: const Text("الغاء"))
      ]);
  return Future.value(true);
}
