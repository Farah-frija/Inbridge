import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:inbridge/Sprints/auth/AddUser/Controller/AddUserController.dart';
import 'package:inbridge/Sprints/auth/AddUser/data/models/AddUserModel.dart';
import 'package:inbridge/Sprints/auth/Users/model/UserModel.dart';
import 'package:inbridge/Sprints/auth/login/data/models/loginModel.dart';
import 'package:inbridge/core/network/checkInternet.dart';
import 'package:inbridge/core/network/networkHandler.dart';

class UpdateUserStateApi {
  Future<Either<StatusRequest, Map>> updateData(
      String linkurl, bool isblocked) async {
    try {
      if (await checkInternet()) {
        final Map<String, dynamic> requestBody = {
          "bloque": isblocked,
        };
        print(requestBody);
        var response = await http.put(
          Uri.parse(linkurl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<String, dynamic> responsebody = jsonDecode(response.body);
          return Right(responsebody);
        } else {
          if (response.statusCode == 404) {
            return Left(StatusRequest.notFound);
          }

          String errorMessage = jsonDecode(response.body);
          switch (errorMessage) {
            case "invalid entries":
              return Left(StatusRequest.invalidinfo);
            case "User not found in the database":
              return Left(StatusRequest.nonExistent);

            default:
              return Left(StatusRequest.serverFailure);
          }
        }
      } else {
        return Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      return Left(StatusRequest.unknownFailure);
    }
  }
}
