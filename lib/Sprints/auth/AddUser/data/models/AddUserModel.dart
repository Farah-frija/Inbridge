import 'dart:convert';

AddUserModel AddUserModelFromJson(String str) =>
    AddUserModel.fromJson(json.decode(str));

String AddUserModelToJson(AddUserModel data) => json.encode(data.toJson());

class AddUserModel {
  String email;
  String pseudo;
  int cin;
  String sexe;
  String adresse;
  int numeroDeTel;
  DateTime dateDeNaissance;
  String nom;
  String prenom;

  AddUserModel({
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

  factory AddUserModel.fromJson(Map<String, dynamic> json) => AddUserModel(
        email: json["email"],
        pseudo: json["pseudo"],
        cin: json["cin"],
        sexe: json["sexe"],
        adresse: json["adresse"],
        numeroDeTel: json["NumeroDeTel"],
        dateDeNaissance: DateTime.parse(json["DateDeNaissance"]),
        nom: json["nom"],
        prenom: json["prenom"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "pseudo": pseudo,
        "cin": cin,
        "sexe": sexe,
        "adresse": adresse,
        "NumeroDeTel": numeroDeTel,
        "DateDeNaissance":
            "${dateDeNaissance.year.toString().padLeft(4, '0')}-${dateDeNaissance.month.toString().padLeft(2, '0')}-${dateDeNaissance.day.toString().padLeft(2, '0')}",
        "nom": nom,
        "prenom": prenom,
      };
}
