import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:inbridge/core/constant/Approutes.dart';
import 'package:inbridge/test/auth/login/presentation/views/ForgotPassword.dart';
import 'package:inbridge/test/auth/login/presentation/views/PasswordSuccess.dart';
import 'package:inbridge/test/auth/login/presentation/views/login.dart';

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
