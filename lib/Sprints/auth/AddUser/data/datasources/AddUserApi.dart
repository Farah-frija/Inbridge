import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:inbridge/Sprints/auth/AddUser/Controller/AddUserController.dart';
import 'package:inbridge/Sprints/auth/AddUser/data/models/AddUserModel.dart';
import 'package:inbridge/Sprints/auth/login/data/models/loginModel.dart';
import 'package:inbridge/core/network/checkInternet.dart';
import 'package:inbridge/core/network/networkHandler.dart';

class AddUserApi {
  Future<Either<StatusRequest, Map>> postData(
      String linkurl, AddUserModel data) async {
    try {
      if (await checkInternet()) {
        print("dkhal");
        var response = await http.post(Uri.parse(linkurl), body: data.toJson());
        print("aana response");
        print(response.statusCode);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Map responsebody = jsonDecode(response.body);
          print(responsebody);
          return Right(responsebody);
        } else {
          print(jsonDecode(response.body));

          if (response.statusCode == 404) {
            print("Error: Not Found");
            return Left(StatusRequest.notFound);
          }

          String errorMessage = jsonDecode(response.body);

          switch (errorMessage) {
            case "invalid entries":
              print("Error: invalid entries");
              return Left(StatusRequest.invalidinfo);

            case "This user is already registered":
              print("This user is already registered");
              return Left(StatusRequest.existent);
            case "error in email sending":
              print("error in email sending");
              return Left(StatusRequest.notFound);
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
