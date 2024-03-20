import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:inbridge/Sprints/auth/VerifyEmail/views/verifyEmailScreen.dart';

import 'package:inbridge/Sprints/auth/login/Views/ForgotPassword.dart';
import 'package:inbridge/Sprints/auth/login/Views/VerifyEmailSuccess.dart';
import 'package:inbridge/Sprints/auth/login/Views/loginScreen.dart';
import 'package:inbridge/Sprints/taskManagement/views/ListOfOptionsScreen.dart';
import 'package:inbridge/Sprints/taskManagement/views/addTaskScreen.dart';
import 'package:inbridge/core/constant/Approutes.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(
    name: AppRoute.login,
    page: () => const Login(),
  ),
  GetPage(
    name: AppRoute.forgotPassword,
    page: () => const ForgotPasswordPage(),
  ),
  GetPage(
    name: AppRoute.verifyEmailSuccess,
    page: () => const VerifyEmailSuccess(),
  ),
  GetPage(
    name: AppRoute.VerifyEmail,
    page: () => const VarifyEmailScreen(),
  ),
  GetPage(
    name: AppRoute.listOfOptions,
    page: () => ListOfOptionsScreen(),
  ),
  GetPage(
    name: AppRoute.addTask,
    page: () => AddTaskScreen(),
  )
];
