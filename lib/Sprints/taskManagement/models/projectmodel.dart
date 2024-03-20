class Projet {
  final String id; // Assuming you have an ID field in your schema
  final String contenu;
  final String categorieId; // Assuming this is the ID of the categorie
  final String titre;
  final String description;
  final String
      createurDeContenuId; // Assuming this is the ID of the createurDeContenu user

  Projet({
    required this.id,
    required this.contenu,
    required this.categorieId,
    required this.titre,
    required this.description,
    required this.createurDeContenuId,
  });

  factory Projet.fromJson(Map<String, dynamic> json) {
    return Projet(
      id: json['_id'],
      contenu: json['contenu'],
      categorieId: json['categorie'],
      titre: json['titre'],
      description: json['description'],
      createurDeContenuId: json['createurDeContenu'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'contenu': contenu,
      'categorie': categorieId,
      'titre': titre,
      'description': description,
      'createurDeContenu': createurDeContenuId,
    };
  }
}
