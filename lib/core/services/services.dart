import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:inbridge/core/middlewares/UrlMiddleWare.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class MyServices extends GetxService {
  late StreamingSharedPreferences sharedPreferences;
  Future<MyServices> init() async {
    sharedPreferences = await StreamingSharedPreferences.instance;
    return this;
  }
}

initialServices() async {
  await Get.putAsync(() => MyServices().init());
}
