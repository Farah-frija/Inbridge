import 'package:get/get.dart';
import 'package:inbridge/Sprints/auth/Users/model/UserModel.dart';

class OnlyOneUserController extends GetxController {
  // Define an Rx<User> variable to hold the user data
  late Rx<User> Currentuser;

  // Constructor to initialize the user
  SetUser(User user) {
    Currentuser.value = user;
  }

  @override
  void onInit() {
    // Initialize the controller
    Currentuser = User.oninit().obs;
    super.onInit();
  }

  @override
  void onClose() {
    // Clean up resources when the controller is closed
    super.onClose();
  }
}
