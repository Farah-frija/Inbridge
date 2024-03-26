import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:inbridge/core/network/checkInternet.dart';
import 'package:inbridge/core/network/networkHandler.dart';

class AccountVerificationApi {
  static Future<Either<StatusRequest, Map>> postData(
      String linkurl, String email) async {
    try {
      if (await checkInternet()) {
        var response =
            await http.post(Uri.parse(linkurl), body: {'email': email});
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
          print(errorMessage);
          switch (errorMessage) {
            case "invalid email":
              print("Error: Invalid email ");
              return Left(StatusRequest.invalidEmailAndPassword);

            case "Access forbidden. Account blocked.":
              print("Error: Access forbidden. Account blocked.");
              return Left(StatusRequest.accountBlocked);
            case "non existant user":
              print("Error: Non-existent");
              return Left(StatusRequest.nonExistent);
            case "email n'a pas été envoyé à l'utilisateur":
              print("email n'a pas été envoyé à l'utilisateur");
              return Left(StatusRequest.senderror);
            case "Email verified please login":
              print("Error: please verify your account");
              return Left(StatusRequest.verifyEmail);
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
