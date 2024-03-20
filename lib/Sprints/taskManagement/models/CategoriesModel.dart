class Categorie {
  String? id;
  String nom;

  Categorie({this.id, required this.nom});

  factory Categorie.fromJson(Map<String, dynamic> json) {
    return Categorie(
      id: json['_id'],
      nom: json['nom'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'nom': nom,
    };
  }
}
