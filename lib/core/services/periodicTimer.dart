import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:inbridge/Sprints/taskManagement/controllers/listOfTasksController.dart';
import 'package:inbridge/core/services/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void startPeriodicTimer() {
  Timer(Duration(seconds: 1), () {
    const Duration updateInterval = Duration(seconds: 100);
    // Create a periodic timer with an interval of 10 seconds
    Timer.periodic(updateInterval, (Timer timer) async {
      print('First timer fired');
      MyServices myServices = Get.find();
      //String? userId = myServices.sharedPreferences.getString("userId");
      //String? role = myServices.sharedPreferences.getString("role");
      String? userId = '65fc0ad49635019959a580e6';
      String? role = 'utilisateur';
      if (userId != null && role == "utilisateur") {
        print("Entered");
        await calculateUnreadOptionalTasks(userId);
      }
    });
  });
}
