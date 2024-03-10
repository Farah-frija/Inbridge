import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:inbridge/Sprints/auth/login/Views/ForgotPassword.dart';
import 'package:inbridge/Sprints/auth/login/Views/PasswordSuccess.dart';
import 'package:inbridge/Sprints/auth/login/Views/loginScreen.dart';
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
    name: AppRoute.SuccessPassword,
    page: () => const SuccessPassword(),
  ),
];
