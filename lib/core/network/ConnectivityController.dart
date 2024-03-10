import 'package:get/get.dart';
import 'package:connectivity/connectivity.dart';
import 'package:inbridge/core/network/networkHandler.dart';

class ConnectivityController extends GetxController {
  // Assuming online by default
  StatusRequest statusrequest = StatusRequest.none;
  @override
  void onInit() {
    super.onInit();
  }

  setRequest(StatusRequest statusRequest) {
    statusrequest = statusRequest;
    update();
  }
}
