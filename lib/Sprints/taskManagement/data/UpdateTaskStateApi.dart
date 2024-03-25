import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:inbridge/Sprints/taskManagement/models/UserTaskModel.dart';
import 'package:inbridge/core/network/checkInternet.dart';
import 'package:inbridge/core/network/networkHandler.dart';
import 'package:http/http.dart' as http;

class UpadateTaslStateApi {
  static Future<StatusRequest> updateData(
      String linkurl, TaskView taskview) async {
    try {
      if (await checkInternet()) {
        final Map<String, dynamic> requestBody = taskview.toJson();
        print(requestBody);
        print(jsonEncode(requestBody));
        var response = await http.put(
          Uri.parse(linkurl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(requestBody),
        );

        print(
            '=================================\n taskstate body ${response.statusCode}');

        if (response.statusCode == 200 || response.statusCode == 201) {
          Map<String, dynamic> responsebody = jsonDecode(response.body);
          return StatusRequest.success;
        } else {
          if (response.statusCode == 404) {
            return StatusRequest.notFound;
          } else {
            return StatusRequest.nonExistent;
          }
        }
      } else {
        return StatusRequest.offlineFailure;
      }
    } catch (e) {
      return StatusRequest.unknownFailure;
    }
  }
}
