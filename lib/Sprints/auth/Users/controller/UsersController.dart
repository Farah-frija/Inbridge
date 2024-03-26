import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:inbridge/Sprints/auth/Users/data/UpdateUserPhotoApi.dart';
import 'package:inbridge/Sprints/auth/Users/data/UsersListApi.dart';
import 'package:inbridge/Sprints/auth/Users/data/updateUserStateApi.dart';

import 'package:inbridge/Sprints/auth/Users/model/UserModel.dart';
import 'package:inbridge/Sprints/auth/linkApi.dart';
import 'package:inbridge/core/Utils/Camera.dart';
import 'package:inbridge/core/constant/Themes/Colors/colors.dart';
import 'package:inbridge/core/network/networkHandler.dart';
import 'package:inbridge/core/services/services.dart';
import 'package:inbridge/test/modules/users.dart';

abstract class UsersController extends GetxController {}

class UsersControllerImp extends UsersController {
  late RxString errorMessage;
  late RxList<User> users; // Using Rx for reactivity
  late Rx<StatusRequest> statusRequest;
  late Rx<StatusRequest> statusRequestPhoto;
  late Rx<TextEditingController> searchWord;
  Camera? cam;
  Rx<File?> imageFile = Rx<File?>(null);
  late Rx<int> user;

  // Using Rx for reactivity
  @override
  void onInit() {
    super.onInit();
    user = 0.obs;
    errorMessage = "".obs;
    users = <User>[].obs;
    statusRequest = StatusRequest.none.obs;
    statusRequestPhoto = StatusRequest.none.obs;
    searchWord = TextEditingController().obs;

    GetUsers();
  }

  final UpdateUserStateApi _api = UpdateUserStateApi();

  Future<void> updateUserBloque(int user) async {
    final linkurl = '${AppLink.UpdateUserState}/${users.value[user].id}';
    // Replace with your API endpoint

    bool blocked = !(users.value[user].bloque);
    print('$blocked  hethi blocked');
    final result = await _api.updateData(linkurl, blocked);

    result.fold(
      (failure) {
        // Handle error cases
        switch (failure) {
          case StatusRequest.notFound:
            print('User not found.');
            break;
          case StatusRequest.invalidinfo:
            print('Invalid entries.');
            break;
          case StatusRequest.nonExistent:
            print('User not found in the database.');
            break;
          case StatusRequest.serverFailure:
            print('Server failure.');
            break;
          case StatusRequest.offlineFailure:
            print('Offline failure.');
            break;
          case StatusRequest.unknownFailure:
            print('Unknown failure.');
            break;
          default:
            print('Default error.');
            break;
        }
      },
      (responseBody) {
        try {
          // Convert the response body to JSON
          Map<String, dynamic> data = Map<String, dynamic>.from(responseBody);
          print(data);
          // Parse the JSON data into a User object
          User newuser = User.fromJson(data);
          users.value[user] = newuser;
          users.refresh();
          print('l update ${users.value[user]}');
          // Print the parsed user

          // Do whatever you need with the user object here
        } catch (error) {
          // Handle the error appropriately
          print('Error parsing JSON data: $error');
          // Optionally, rethrow the error to propagate it further
          // throw error;
        }
      },
    );
  }

  @override
  void dispose() {
    imageFile.close();
    super.dispose();
  }

  void updateimage(File? image) {
    imageFile.value = image;
    print(image);
    print("===============update===============");
    updatePhoto(user.value!);
    imageFile.value = null;
  }

  void updateProfilePhoto(context, int ind) {
    user.value = ind;
    cam = Camera(updateimage);

    cam!.onpressed(context);
  }

  @override
  MyServices myServices = Get.find();

  Future<void> GetUsers() async {
    // Set status to loading
    statusRequest.value = StatusRequest.loading;

    try {
      // Call getUsers method from UserListApi to fetch the list of users
      final result = await UserListApi.getUsers();

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
          users.value = userList;
          statusRequest.value = StatusRequest.success;
        },
      );
    } catch (e) {
      // Handle exception
      statusRequest.value = StatusRequest.unknownFailure;
    }
  }

  void updatePhoto(int number) async {
    print("=======================upload========");

    // Rx<String?> message = null.obs;
    // Rx<String> title = "error".obs;
    statusRequestPhoto.value = StatusRequest.loading;
    //message.value = "loading";
    Color color = KRoseFonce;
    String link = '${AppLink.UpdatePhoto}${users.value[number].id}';
    var response = await UploadImageApi.postData(link, imageFile.value!);
    print("=============================== Controller  ");

    response.fold(
      (status) {
        statusRequestPhoto.value = status;
        print(status);
        // Handle left (error) case
        switch (statusRequest) {
          case StatusRequest.notFound:
            print("not found");
            break;
          case StatusRequest.nonExistent:
            print("non existant");
            break;
          case StatusRequest.serverFailure:
            //message.value = "an error has occured";
            break;
          case StatusRequest.offlineFailure:
            //message.value = "lost connection";
            break;
          case StatusRequest.unknownFailure:
            print("unexpected error");
            break;
          default:
            break;
        }
      },
      (success) {
        users.value[number].photoDeProfile = success;
        print(users.value[number].photoDeProfile);
        statusRequestPhoto.value = StatusRequest.success;
        color = Colors.green;
        //title.value = "success";
        // message.value = "photo updated with success";
        Get.snackbar("success ", "photo updated with success",
            colorText: Colors.white, backgroundColor: color);
        print("updated photo with success");

        users.refresh();
      },
    );

    /* Obx(() {
      if (message != null) {
        Get.snackbar(title.value, message.value!,
            colorText: Colors.white, backgroundColor: color);
      }
      return SizedBox.shrink();
    });*/
    imageFile.value = null;
  }
}
