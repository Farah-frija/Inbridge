import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dartz/dartz.dart';
import 'package:inbridge/Sprints/auth/linkApi.dart';
import 'package:inbridge/Sprints/taskManagement/models/TaskModel.dart';
import 'package:inbridge/core/network/checkInternet.dart';
import 'package:inbridge/core/network/networkHandler.dart';

class AddTaskApi {
  static Future<Either<StatusRequest, Map>> addTask(Tache data) async {
    // Remplacez cette URL par l'URL de votre API
    final String apiUrl = AppLink.addTask;

    try {
      if (await checkInternet()) {
        // Effectuez une requête HTTP pour récupérer les données des utilisateurs
        var headers = {'Content-Type': 'application/json'};
        print("dkhal-1");
        // Convert the data object directly to a JSON body
        var jsonBody = jsonEncode(data.toJson());

        // Send the request
        var response = await http.post(Uri.parse(apiUrl),
            headers: headers, body: jsonBody);
        Map responseBody = jsonDecode(response.body);
        print("dkhal");
        // Parse the response
        if (response.statusCode == 200 || response.statusCode == 201) {
          return Right(responseBody);
        } else {
          // Si la requête n'a pas réussi, lancez une exception avec le message d'erreur
          if (response.statusCode == 404)
            return Left(StatusRequest.serverFailure);
          print("dkhal0");
          String errorMessage = jsonDecode(response.body);
          print("dkhal1");
          print(errorMessage);
          switch (errorMessage) {
            case "Categorie not found" || 'Createur de contenu not found':
              print("Error: invalid entries");
              return Left(StatusRequest.nonExistent);
            default:
              print("Error: Server Failure");
              return Left(StatusRequest.serverFailure);
          }
        }
      }
      print("Error: Offline");
      return Left(StatusRequest.offlineFailure);
    } catch (e) {
      print(e);
      // Si une erreur s'est produite lors de la récupération des utilisateurs, lancez une exception avec le message d'erreur
      return Left(StatusRequest.unknownFailure);
    }
  }
}
