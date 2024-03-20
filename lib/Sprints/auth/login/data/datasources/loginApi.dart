import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:inbridge/Sprints/auth/login/data/models/loginModel.dart';
import 'package:inbridge/core/network/checkInternet.dart';
import 'package:inbridge/core/network/networkHandler.dart';

class LoginApi {
  Future<Either<StatusRequest, Map>> postData(
      String linkurl, LoginModel data) async {
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
          print("haw lena");
          print(jsonDecode(response.body).runtimeType);
          String errorMessage = jsonDecode(response.body);

          switch (errorMessage) {
            case "invalid email and motdepasse":
              print("Error: Invalid email and motdepasse");
              return Left(StatusRequest.invalidEmailAndPassword);

            case "Access forbidden. Account blocked.":
              print("Error: Access forbidden. Account blocked.");
              return Left(StatusRequest.accountBlocked);
            case "non existant user":
              print("Error: Non-existent");
              return Left(StatusRequest.nonExistent);
            case "user wrong motdepasse":
              print("Error: User wrong motdepasse");
              return Left(StatusRequest.wrongMotdepasse);
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
