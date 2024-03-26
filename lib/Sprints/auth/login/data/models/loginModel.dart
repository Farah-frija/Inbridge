import 'dart:convert';

LoginModel LoginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String LoginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  String? email;
  String? motdepasse;

  LoginModel({
    this.email,
    this.motdepasse,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        email: json["email"],
        motdepasse: json["motdepasse"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "motdepasse": motdepasse,
      };
}
