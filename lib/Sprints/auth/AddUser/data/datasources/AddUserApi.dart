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
        var request = http.MultipartRequest('POST', Uri.parse(linkurl));
        request.fields.addAll({
          "email": data.email,
          "pseudo": data.pseudo,
          "cin": data.cin.toString(),
          "sexe": data.sexe,
          "adresse": data.adresse,
          "NumeroDeTel": data.numeroDeTel.toString(),
          "DateDeNaissance":
              "${data.dateDeNaissance.year.toString().padLeft(4, '0')}-${data.dateDeNaissance.month.toString().padLeft(2, '0')}-${data.dateDeNaissance.day.toString().padLeft(2, '0')}",
          "nom": data.nom,
          "prenom": data.prenom,
        });
        print('File path: ${data.photoDeProfile.path}');
        // Add photoDeProfile field
        var fileStream = http.ByteStream(data.photoDeProfile!.openRead());
        print('File stream: ${fileStream == null}');
        var length = await data.photoDeProfile.length();
        var multipartFile = http.MultipartFile(
          'photoDeProfile',
          fileStream,
          length,
          filename: data.photoDeProfile!.path,
        );
        print('multi: ${multipartFile == null}');
        request.files.add(multipartFile);
        print(request.fields['photoDeProfile']);
        request.fields['photoDeProfile'] = data.photoDeProfile.path;
        print(request.fields['photoDeProfile']);
        // Send the request
        var response = await request.send();

// Get the response body
        String responseBody = await response.stream.bytesToString();
        print("aana response");
        print(response.statusCode);
        if (response.statusCode == 200 || response.statusCode == 201) {
          print(responseBody);
          Map responsebody = jsonDecode(responseBody);
          print("${responsebody} lahne rajaa body");
          return Right(responsebody);
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
