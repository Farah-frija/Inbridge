import 'dart:convert'; // Si vous récupérez des données JSON
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:inbridge/Sprints/auth/linkApi.dart';
import 'package:inbridge/Sprints/taskManagement/models/CategoriesModel.dart';
import 'package:inbridge/core/network/checkInternet.dart';
import 'package:inbridge/core/network/networkHandler.dart';
// Si vous récupérez des données via HTTP
// Assurez-vous d'importer votre modèle User

class CategoriesApi {
  static Future<Either<StatusRequest, List<Categorie>>>
      getAllCategories() async {
    // Remplacez cette URL par l'URL de votre API
    final String apiUrl = AppLink.getAllCategories;

    try {
      if (await checkInternet()) {
        // Effectuez une requête HTTP pour récupérer les données des utilisateurs
        final response = await http.get(Uri.parse(apiUrl));

        // Vérifiez si la requête a réussi (code de statut 200)
        if (response.statusCode == 200 || response.statusCode == 201) {
          // Analysez les données JSON de la réponse
          final List<dynamic> jsonData = jsonDecode(response.body);

          // Convertissez les données JSON en une liste d'objets User
          List<Categorie> categories = jsonData.map((data) {
            try {
              print('categorie ${Categorie.fromJson(data)}');
            } catch (error) {
              // Handle the error appropriately
              print('Error parsing JSON data: $error');
              // Optionally, rethrow the error to propagate it further
              // throw error;
            }

            return Categorie.fromJson(data);
          }).toList();
          print(categories);

          // Retournez la liste des utilisateurs
          return Right(categories);
        }
        // Si la requête n'a pas réussi, lancez une exception avec le message d'erreur
        if (response.statusCode == 404) {
          print("Error: Not Found");
          return Left(StatusRequest.notFound);
        } else
          return Left(StatusRequest.none);
      } else {
        print("Error: Offline");
        return Left(StatusRequest.offlineFailure);
      }
    } catch (e) {
      print(e);
      // Si une erreur s'est produite lors de la récupération des utilisateurs, lancez une exception avec le message d'erreur
      return Left(StatusRequest.unknownFailure);
    }
  }
}
