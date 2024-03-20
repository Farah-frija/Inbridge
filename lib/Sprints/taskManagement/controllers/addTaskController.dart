import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:inbridge/Sprints/auth/Users/data/UsersListApi.dart';
import 'package:inbridge/Sprints/auth/Users/model/UserModel.dart';
import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
import 'package:inbridge/core/network/networkHandler.dart';
import 'package:inbridge/core/services/services.dart';

class AddTaskController extends GetxController {
  late TextEditingController title;
  late TextEditingController description;
  late TextEditingController guidelines;
  RxList<String> categories = ['Quizz', 'Meme', 'feedback'].obs;
  Rx<DateTime> deadline = DateTime(2002, 8, 25).obs;
  late Rx<String?> category;
  late Rx<String?> option = "optional".obs;
  late Rx<String?> selectedUser;
  late Rx<bool?> isValid;
  late Rx<String?> validationResult;
  late RxString errorMessage;
  late RxList<User> users;
  late RxList<User> filteredUsers;
  late Rx<String?> selectedId;
  // Using Rx for reactivity
  late Rx<StatusRequest> statusRequest;
  late Rx<TextEditingController> searchWord;

  void updateDateOfBirth(DateTime value) {
    deadline.value = value;
  }

  void updateOption(String selected) {
    option.value = selected;
  }

  void onInit() {
    searchWord = TextEditingController().obs;
    users = <User>[].obs;
    statusRequest = StatusRequest.none.obs;
    title = TextEditingController();
    description = TextEditingController();
    guidelines = TextEditingController();
    category = Rx<String?>(null);
    selectedId = Rx<String?>(null);
    selectedUser = Rx<String?>(null);
    isValid = false.obs;
    validationResult = Rx<String?>(null);
    errorMessage = "".obs;
    filteredUsers = <User>[].obs;
    GetUsers();

    print(searchWord.value.text);

    super.onInit();
  }

  String validateBeforeNext() {
    print(selectedUser.value);

    // Check if any of the text fields are empty
    if (category.value == null ||
        title.text.isEmpty ||
        description.text.isEmpty ||
        guidelines.text.isEmpty) {
      isValid.value = false;
      // All text fields should be filled
      return "Empty entry(ies)";
    }

    // Check if the deadline is in the future
    if (deadline.value.isBefore(DateTime.now())) {
      // Deadline should be in the future
      isValid.value = false;
      return "choose a valid date";
    }
    // Check if the option is mandatory and selected user is not null
    if (option.value == "mandatory" && selectedUser.value == null) {
      // Selected user should not be null
      isValid.value = false;
      print("dkhal");
      return "choose a content creator for mandatory tasks";
    }
    isValid.value = true;
    // Validation passed
    return "valid info";
  }

  void setCategory(String? selected) {
    category.value = selected;
  }

  void onPressed() {
    validationResult.value = validateBeforeNext();
    if (isValid.value == false) {
      // Show warning box with the validation result
      Get.snackbar("Warning", validationResult.value!,
          colorText: Colors.white, backgroundColor: KRoseFonce);
    } else {}
  }

  MyServices myServices = Get.find();

  Future<void> GetUsers() async {
    // Set status to loading
    statusRequest.value = StatusRequest.loading;
    print(statusRequest.value);
    try {
      // Call getUsers method from UserListApi to fetch the list of users
      final result = await UserListApi.getUsers();
      print(result);
      // Check if the request was successful
      result.fold(
        (error) {
          // Handle error
          statusRequest.value = error;
          switch (statusRequest.value) {
            case StatusRequest.notFound:
              errorMessage.value = "wrong route";
              break;

            case StatusRequest.none:
              errorMessage.value = "No users found";
              break;
            case StatusRequest.offlineFailure:
              errorMessage.value = "No internet connexion";
              break;

            default:
              if (StatusRequest.unknownFailure == statusRequest) {
                errorMessage.value = "unKnown error has occured ";
              }
          }
        },
        (userList) {
          // Update users list and status
          users.clear();
          filteredUsers.clear();
          for (var user in userList) {
            // Check your condition here
            if (!user.bloque && user.verifie && user.role != "administrateur") {
              // Add the user to the users list
              print(user.role);
              users.add(user);
            }
          }
          filteredUsers.addAll(users);
          statusRequest.value = StatusRequest.success;
        },
      );
    } catch (e) {
      // Handle exception
      statusRequest.value = StatusRequest.unknownFailure;
    }
  }

  void filterUsers(String searchWord) {
    // Clear the existing users list
    filteredUsers.clear();
    // Iterate over the userList
    for (var user in users) {
      // Check if the user matches the search query
      if (user.matchesSearchQuery(searchWord)) {
        // Add the user to the users list
        filteredUsers.add(user);
        print(user.email);
      }
    }
  }
}
