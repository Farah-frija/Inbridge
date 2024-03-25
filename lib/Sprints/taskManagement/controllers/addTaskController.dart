import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:inbridge/Sprints/auth/Users/data/UsersListApi.dart';
import 'package:inbridge/Sprints/auth/Users/model/UserModel.dart';
import 'package:inbridge/Sprints/taskManagement/data/AddTaskApi.dart';
import 'package:inbridge/Sprints/taskManagement/data/GetCategoriesApi.dart';
import 'package:inbridge/Sprints/taskManagement/models/CategoriesModel.dart';
import 'package:inbridge/Sprints/taskManagement/models/TaskModel.dart';
import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
import 'package:inbridge/core/network/networkHandler.dart';
import 'package:inbridge/core/services/services.dart';

class AddTaskController extends GetxController {
  late TextEditingController title;
  late TextEditingController description;
  late TextEditingController guidelines;
  late RxList<String> categories;
  Rx<DateTime> deadline = DateTime.now().obs;
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
  late RxList<Categorie> categoriesList;
  late Rx<int?> selectedcategoryIndex;

  void updateDateOfBirth(DateTime value) {
    deadline.value = value;
  }

  void updateOption(String selected) {
    option.value = selected;
  }

  void onInit() {
    selectedcategoryIndex = Rx<int?>(null);
    searchWord = TextEditingController().obs;
    users = <User>[].obs;
    categories = <String>[].obs;
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
    categoriesList = <Categorie>[].obs;
    GetCategories();

    print(searchWord.value.text);

    super.onInit();
  }

  GetCategories() async {
    statusRequest.value = StatusRequest.loading;
    print(StatusRequest.loading);
    print(statusRequest.value);
    try {
      // Call getUsers method from UserListApi to fetch the list of users
      final result = await CategoriesApi.getAllCategories();
      print(result);
      // Check if the request was successful
      result.fold((error) {
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
      }, (categoryList) {
        // Update users list and status
        categories.clear();
        categoriesList.value = categoryList; //listOfCategories = categoryList;
        for (var category in categoryList) {
          categories.add(category.nom);
          print(' hetha nom $category.nom');
        }
        statusRequest.value = StatusRequest.success;
      });
    } catch (e) {
      // Handle exception
      statusRequest.value = StatusRequest.unknownFailure;
    }
  }

  String validateBeforeNext() {
    print(selectedUser.value);

    // Check if any of the text fields are empty
    if (
        //category.value == null ||

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
    } else {
      if (option == "optional") selectedId.value = "";

      bool estOptionnel = option == "optional";
      Tache task = Tache(
          instructions: guidelines.value.text,
          description: description.value.text,
          //categorie: categoriesList.value[selectedcategoryIndex.value!].id,
          titre: title.text,
          createurDeContenu: selectedId.value,
          dateLimite: deadline.value,
          optionnel: estOptionnel);
      addTask(task);
    }
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

  Future<void> addTask(taskData) async {
    statusRequest.value = StatusRequest.loading;
    String errorMessage = '';
    var result = await AddTaskApi.addTask(taskData);
    result.fold(
      (failure) {
        statusRequest.value = failure;
        // Handle failure cases
        switch (failure) {
          case StatusRequest.offlineFailure:
            String errorMessage = 'No internet connexion';
            print("You are offline");
            break;
          case StatusRequest.unknownFailure:
            print("An unknown error has occurred");
            break;
          case StatusRequest.nonExistent:
            print("Wrong entries");
            break;
          case StatusRequest.notFound:
            print("root doesn't exist");
            break;

          default:
            // Handle other failure cases
            break;
        }
      },
      (success) {
        // Handle succes
        statusRequest.value = StatusRequest.success;
        errorMessage = "Task added with success";
        print("Task added successfully");
        // Additional logic after successful task addition if needed
      },
    );
    String title;
    Color color = Colors.green;
    if (statusRequest.value == StatusRequest.success)
      title = "success";
    else {
      title = "Failure";
      color = KRoseFonce;
    }
    if (errorMessage != '')
      Get.snackbar(title, errorMessage,
          colorText: Colors.white, backgroundColor: color);
  }
}
