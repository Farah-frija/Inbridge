import 'package:flutter/material.dart';
import 'package:inbridge/core/Utils/Enums/TaskState.dart';

class Tache {
  String? instructions;
  String? description;
  String? categorie;
  String? titre;
  String? createurDeContenu;
  TaskState? etat;
  DateTime? dateLimite;
  bool? optionnel;

  Tache({
    this.instructions,
    this.description,
    this.categorie,
    this.titre,
    this.createurDeContenu,
    this.etat,
    this.dateLimite,
    this.optionnel,
  });

  factory Tache.fromJson(Map<String, dynamic> json) {
    return Tache(
      instructions: json['instructions'],
      description: json['description'],
      categorie: json['categorie'],
      titre: json['titre'],
      createurDeContenu: json['createurDeContenu'],
      etat: json['etat'] == "fait"
          ? TaskState.done
          : json['etat'] == "manqué"
              ? TaskState.missed
              : json['etat'] == "en attente"
                  ? TaskState.pending
                  : null,
      dateLimite: json['dateLimite'] != null
          ? DateTime.parse(json['dateLimite'])
          : null,
      optionnel: json['optionnel'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['instructions'] = this.instructions;
    data['description'] = this.description;
    data['categorie'] = this.categorie;
    data['titre'] = this.titre;
    data['createurDeContenu'] = this.createurDeContenu;
    data['etat'] =
        _taskStateToJson(this.etat); // Convert TaskState enum to string
    data['dateLimite'] = this.dateLimite?.toIso8601String();
    data['optionnel'] = this.optionnel;
    return data;
  }

  String? _taskStateToJson(TaskState? state) {
    switch (state) {
      case TaskState.done:
        return "fait";
      case TaskState.missed:
        return "manqué";
      default:
        return "en attente";
    }
  }
}
