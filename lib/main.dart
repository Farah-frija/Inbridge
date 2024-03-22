import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:inbridge/HomePage.dart';
import 'package:inbridge/Sprints/auth/AddUser/View/addUserScreen.dart';
import 'package:inbridge/Sprints/auth/Users/views/UsersListScreen.dart';
import 'package:inbridge/Sprints/auth/login/Views/loginScreen.dart';
import 'package:inbridge/Sprints/taskManagement/views/TasksList.dart';
import 'package:inbridge/Sprints/taskManagement/views/addTaskScreen.dart';
import 'package:inbridge/core/Widgets/ListOfMandatoryTasks.dart';
import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
import 'package:inbridge/core/services/periodicTimer.dart';
import 'package:inbridge/core/services/services.dart';
import 'package:badges/badges.dart' as badges;

import 'package:inbridge/routes.dart';

import 'core/Widgets/FilterUser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  startPeriodicTimer();
  runApp(TabBarDemo());
}

class TabBarDemo extends StatelessWidget {
  TabBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(getPages: routes, home: MyHomePage());
  }
}
/*import 'package:flutter/material.dart';
import 'package:inbridge/Themes/Colors/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Navigation with Big Button',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}*/



// Example Pages
