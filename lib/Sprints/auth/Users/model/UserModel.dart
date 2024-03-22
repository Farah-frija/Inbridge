import 'package:inbridge/Sprints/taskManagement/models/projectmodel.dart';

class User {
  final String id;
  final String photoDeProfile;
  final String email;
  final String pseudo;
  final String role;
  final int? cin;
  final String? sexe;
  final String? adresse;
  final int? numeroDeTel;
  final bool bloque;
  final DateTime? dateDeNaissance;
  final String nom;
  final String prenom;
  final int nombreAvertissement;
  final bool verifie;
  final List<Projet>? projets; // Assuming projet IDs are stored as strings
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User.oninit({
    this.id = '',
    this.email = '',
    this.pseudo = '',
    this.photoDeProfile = '',
    this.role = '',
    this.bloque = false,
    this.nom = '',
    this.prenom = '',
    this.nombreAvertissement = 0,
    this.verifie = false,
    this.cin,
    this.sexe,
    this.adresse,
    this.numeroDeTel,
    this.dateDeNaissance,
    this.projets,
    this.createdAt,
    this.updatedAt,
  });

  User({
    required this.id,
    required this.email,
    required this.pseudo,
    required this.photoDeProfile,
    required this.role,
    this.cin,
    this.sexe,
    this.adresse,
    this.numeroDeTel,
    required this.bloque,
    this.dateDeNaissance,
    required this.nom,
    required this.prenom,
    required this.nombreAvertissement,
    required this.verifie,
    this.projets,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      email: json['email'],
      pseudo: json['pseudo'],
      photoDeProfile: json['photoDeProfile'],
      role: json['role'],
      cin: json['cin'],
      sexe: json['sexe'],
      adresse: json['adresse'],
      numeroDeTel: json['NumeroDeTel'],
      bloque: json['bloque'],
      dateDeNaissance: json['dateDeNaissance'] != null
          ? DateTime.parse(json['dateDeNaissance'])
          : null,
      nom: json['nom'],
      prenom: json['prenom'],
      nombreAvertissement: json['nombreAvertissement'],
      verifie: json['verifie'],
      projets: json['projets'] != null && json['projets'] is List
          ? (json['projets'] as List).map((x) => Projet.fromJson(x)).toList()
          : [],
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }
  bool matchesSearchQuery(String query) {
    // Check if the user matches the search query
    return nom.toLowerCase().contains(query.toLowerCase()) ||
        prenom.toLowerCase().contains(query.toLowerCase()) ||
        numeroDeTel.toString().contains(query.toLowerCase()) ||
        cin.toString().contains(query.toLowerCase()) ||
        email.toLowerCase().contains(query.toLowerCase()) ||
        pseudo.toLowerCase().contains(query.toLowerCase());
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'photoDeProfile': photoDeProfile,
      'email': email,
      'pseudo': pseudo,
      'role': role,
      'cin': cin,
      'sexe': sexe,
      'adresse': adresse,
      'NumeroDeTel': numeroDeTel,
      'bloque': bloque,
      'dateDeNaissance': dateDeNaissance?.toIso8601String(),
      'nom': nom,
      'prenom': prenom,
      'nombreAvertissement': nombreAvertissement,
      'verifie': verifie,
      'projets': projets,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
