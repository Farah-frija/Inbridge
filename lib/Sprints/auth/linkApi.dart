class AppLink {
  static const String server = "http://192.168.1.2:8000";

// ================================= Auth ========================== //

  static const String signUp = "$server/api/auth/register/";
  static const String login = "$server/api/auth/login/";
  static const String getAllUsers = "$server/api/users/";
  static const String UpdateUserState = "$server/api/users/";

// ================================= TaskManagement ========================== //

  static const String getAllCategories = "$server/api/categorie/";
}
