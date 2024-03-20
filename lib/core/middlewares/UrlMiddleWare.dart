// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/routes/route_middleware.dart';
// import 'package:inbridge/core/constant/Approutes.dart';

// class DeepLinkMiddleware extends GetMiddleware {
//   @override
//   RouteSettings? redirect(String? route) {
//     final String? deepLink = Get.parameters['url'];
//     if (deepLink != null && deepLink.isNotEmpty) {
//       // Extract the URL from the deep link
//       final Uri uri = Uri.parse(deepLink);
//       final String? url = uri.toString(); // You can parse the URL as needed
//       print(url);
//       // Navigate to the password page with the URL parameter
//       Get.toNamed(AppRoute.forgotPassword, parameters: {'url': url ?? ""});
//       return null;
//     }
//     return null; // Return null to proceed with the regular routing
//   }
// }
