import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inbridge/Sprints/auth/linkApi.dart';
import 'package:inbridge/Sprints/taskManagement/models/UserTaskModel.dart';

Future<UserTask> fetchUserById(String userId) async {
  final url = Uri.parse('${AppLink.getAllUsers}$userId');
  // Replace with your API endpoint
  print(url);
  final headers = <String, String>{
    'Content-Type': 'application/json',
  };

  final response = await http.get(url, headers: headers);

  print("lahne");

  if (response.statusCode == 200) {
    final jsonBody = json.decode(response.body);
    print(jsonBody);
    print(UserTask.fromJson(jsonBody));
    return UserTask.fromJson(jsonBody);
  } else {
    throw Exception('Failed to fetch user');
  }
}
