import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:inbridge/Sprints/auth/AddUser/Controller/AddUserController.dart';
import 'package:inbridge/Sprints/auth/AddUser/data/models/AddUserModel.dart';
import 'package:inbridge/Sprints/auth/Users/model/UserModel.dart';
import 'package:inbridge/Sprints/auth/login/data/models/loginModel.dart';
import 'package:inbridge/core/network/checkInternet.dart';
import 'package:inbridge/core/network/networkHandler.dart';

class UploadImageApi {
  static Future<Either<StatusRequest, String>> postData(
      String linkurl, File photoDeProfile) async {
    try {
      if (await checkInternet()) {
        print("dkhal");
        var request = http.MultipartRequest('PUT', Uri.parse(linkurl));

        // Add photoDeProfile field
        var fileStream = http.ByteStream(photoDeProfile!.openRead());
        print('File stream: ${fileStream == null}');
        var length = await photoDeProfile.length();
        var multipartFile = http.MultipartFile(
          'photoDeProfile',
          fileStream,
          length,
          filename: photoDeProfile!.path,
        );
        print('multi: ${multipartFile == null}');
        request.files.add(multipartFile);
        print(request.fields['photoDeProfile']);
        request.fields['photoDeProfile'] = photoDeProfile.path;
        print(request.fields['photoDeProfile']);
        // Send the request
        var response = await request.send();

// Get the response body
        String responseBody = await response.stream.bytesToString();
        print("aana response");
        print(response.statusCode);
        if (response.statusCode == 200 || response.statusCode == 201) {
          return Right(jsonDecode(responseBody)['photoDeProfile']);
        } else {
          print("haw lena");
          print(jsonDecode(responseBody).runtimeType);

          if (response.statusCode == 404) {
            print("Error: Not Found");
            return Left(StatusRequest.notFound);
          }

          String errorMessage = jsonDecode(responseBody);
          print(errorMessage);
          switch (errorMessage) {
            case "User not found or no modification performed":
              print("User not found or no modification performed");
              return Left(StatusRequest.nonExistent);

            default:
              print("Error: Server Failure");
              return Left(StatusRequest.serverFailure);
          }
        }
      } else {
        print("Error: Offline");
        return Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      // Handle unexpected errors
      print("Unexpected error: $e");
      return Left(StatusRequest.unknownFailure);
    }
  }
}
