class UserListApi {
  static Future<Either<StatusRequest, List<User>>> getUsers() async {
    // Remplacez cette URL par l'URL de votre API
    final String apiUrl = AppLink.getAllUsers;

    try {
      if (await checkInternet()) {
        // Effectuez une requête HTTP pour récupérer les données des utilisateurs
        final response = await http.get(Uri.parse(apiUrl));

        // Vérifiez si la requête a réussi (code de statut 200)
        if (response.statusCode == 200 || response.statusCode == 201) {
          // Analysez les données JSON de la réponse
          final List<dynamic> jsonData = jsonDecode(response.body);

          // Convertissez les données JSON en une liste d'objets User
          List<User> users = jsonData.map((data) {
            print('User Data: $data');
            try {
              print('user ${User.fromJson(data)}');
            } catch (error) {
              // Handle the error appropriately
              print('Error parsing JSON data: $error');
              // Optionally, rethrow the error to propagate it further
              // throw error;
            }

            return User.fromJson(data);
          }).toList();
          print(users);

          // Retournez la liste des utilisateurs
          return Right(users);
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
