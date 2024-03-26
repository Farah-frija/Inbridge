import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inbridge/Sprints/auth/linkApi.dart';
import 'package:inbridge/Sprints/auth/login/data/models/loginModel.dart';

// Define a function to verify the user using the API
Future<bool> LinkVerificationAPi(
    String userId, String token, LoginModel User) async {
  try {
    print("user id $userId   token $token");
    // Make a GET request to the API endpoint
    String link = '${AppLink.server}/api/auth/${userId}verify${token}';
    final response = await http.get(
      Uri.parse(link),
    );
    print('${json.decode(response.body)}aaaaaaaaaaaaa');
    // Check if the request was successful (status code 200)
    if (response.statusCode == 200) {
      // Parse the response body
      final responseData = json.decode(response.body);
      print(responseData);

      // Extract relevant data from the response
      final email = responseData['email'];
      User.email = email;
      return true;
    } else {
      print("nooo");
      return false;
    }
  } catch (error) {
    // Handle any errors that occur during the HTTP request
    print('Error: $error');
    return false;
  }
}
