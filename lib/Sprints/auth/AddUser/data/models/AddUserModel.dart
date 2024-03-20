import 'dart:convert';
import 'dart:io';

//AddUserModel addUserModelFromJson(String str) =>
//AddUserModel.fromJson(json.decode(str));

//String addUserModelToJson(AddUserModel data) => json.encode(data.toJson());

class AddUserModel {
  String email;
  String pseudo;
  int cin; // Change type to int
  String sexe;
  String adresse;
  int numeroDeTel; // Change type to int
  DateTime dateDeNaissance;
  String nom;
  String prenom;
  File photoDeProfile;

  AddUserModel({
    required this.photoDeProfile,
    required this.email,
    required this.pseudo,
    required this.cin,
    required this.sexe,
    required this.adresse,
    required this.numeroDeTel,
    required this.dateDeNaissance,
    required this.nom,
    required this.prenom,
  });

  // factory AddUserModel.fromJson(Map<String, dynamic> json) => AddUserModel(
  //       email: json["email"],
  //       pseudo: json["pseudo"],
  //       cin: json["cin"] as int,
  //       sexe: json["sexe"],
  //       adresse: json["adresse"],
  //       numeroDeTel: json["NumeroDeTel"] as int,
  //       dateDeNaissance: DateTime.parse(json["DateDeNaissance"]),
  //       nom: json["nom"],
  //       prenom: json["prenom"],
  //     );

  Map<String, dynamic> toJson() => {
        "email": email,
        "pseudo": pseudo,
        "cin": cin.toString(), // Keep as int
        "sexe": sexe,
        "adresse": adresse,
        "NumeroDeTel": numeroDeTel.toString(), // Keep as int
        "DateDeNaissance":
            "${dateDeNaissance.year.toString().padLeft(4, '0')}-${dateDeNaissance.month.toString().padLeft(2, '0')}-${dateDeNaissance.day.toString().padLeft(2, '0')}",
        "nom": nom,
        "prenom": prenom,
      };

  String addUserModelToJson(AddUserModel data) => jsonEncode(data.toJson());
}
