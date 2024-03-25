import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:inbridge/Sprints/taskManagement/data/UserTaskbyId.dart';
import 'package:inbridge/Sprints/taskManagement/models/TaskModel.dart';
import 'package:inbridge/core/services/services.dart';

class UserTask {
  String id;

  List<Tache> taches;

  List<TaskView> tachesVues;

  UserTask({
    required this.id,
    required this.taches,
    required this.tachesVues,
  });

  factory UserTask.fromJson(Map<String, dynamic> json) {
    print(json['_id']);
    print(json['taches']);
    print(json['tachesVues']);
    json['tachesVues'] != null
        ? print((json['tachesVues'] as List<dynamic>)
            .map((taskViewJson) => TaskView.fromJson(taskViewJson))
            .toList())
        : print(null);
    return UserTask(
      id: json['_id'],
      taches: json['taches'] != null
          ? (json['taches'] as List<dynamic>)
              .map((taskJson) => Tache.fromJson(taskJson))
              .toList()
          : [], // If taches is null, return an empty list
      tachesVues: json['tachesVues'] != null
          ? (json['tachesVues'] as List<dynamic>)
              .map((taskViewJson) => TaskView.fromJson(taskViewJson))
              .toList()
          : [], // If tachesVues is null, return an empty list
    );
  }
}

class TaskView {
  String id;
  Tache tache;
  String createurDeContenu;
  bool vu;
  bool lu;

  TaskView({
    required this.id,
    required this.tache,
    required this.createurDeContenu,
    required this.vu,
    required this.lu,
  });

  factory TaskView.fromJson(Map<String, dynamic> json) {
    return TaskView(
      id: json['_id'],
      tache: Tache.fromJson(json['tache']),
      createurDeContenu: json['createurDeContenu'],
      vu: json['vu'],
      lu: json['lu'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'createurDeContenu': createurDeContenu,
      'vu': vu,
      'lu': lu,
    };
  }
}
