import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:inbridge/core/constant/Approutes.dart';

class AppLinksDeepLink extends GetxController {
  AppLinksDeepLink._privateConstructor();

  static final AppLinksDeepLink _instance =
      AppLinksDeepLink._privateConstructor();

  static AppLinksDeepLink get instance => _instance;

  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;
  void handleDeepLink(String link) {
    print(link);

    // Handle the deep link based on the app's current state
    List<String> parts = link.split("verify");

    // Extract the parts
    String beforeVerify = parts[0]; // Before "verify"
    String afterVerify = parts[1];
    print(afterVerify);

    parts = beforeVerify.split("auth/");
    String userId = parts[1];
    String wordToDelete = "/password/";
    if (afterVerify.contains("/password/")) {
      int index = afterVerify.indexOf(wordToDelete);
      String modifiedString;

      modifiedString = afterVerify.substring(0, index + 1);

      Get.offAllNamed(AppRoute.forgotPassword, parameters: {
        "userId": userId,
        "token": modifiedString,
        "type": "reset"
      });
    } else {
      print("==============no pass=================");
      print(userId);
      print(afterVerify);

      Get.offAllNamed(AppRoute.forgotPassword, parameters: {
        "userId": userId,
        "token": afterVerify,
        "type": "account"
      });
    }
  }

  @override
  void onInit() {
    super.onInit();
    _appLinks = AppLinks();
    initDeepLinks();
  }

  Future<void> initDeepLinks() async {
    // Check initial link if app was in cold state (terminated)
    final appLink = await _appLinks.getInitialAppLink();
    print("=======================initiallly==================");
    if (appLink != null) {
      print("here");
      var uri = Uri.parse(appLink.toString());
      print(uri.toString());
      handleDeepLink(uri.toString());
    }

    // Handle link when app is in warm state (front or background)
    _linkSubscription = _appLinks.uriLinkStream.listen(
      (uriValue) {
        print(' you will listen any url updates ');

        print(' here you can redirect from url as per your need ');
        print("=======================ici==================");
        print(uriValue);
        String originalString = uriValue.toString();
        handleDeepLink(originalString);
      },
      onError: (err) {
        debugPrint('====>>> error : $err');
      },
      onDone: () {
        _linkSubscription?.cancel();
      },
    );
  }
}
