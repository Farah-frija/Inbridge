class AppLink {
  static const String server = "http://192.168.1.7:8000";

// ================================= Auth ========================== //

  static const String signUp = "$server/api/auth/register/";
  static const String login = "$server/api/auth/login/";
  static const String getAllUsers = "$server/api/users/";
  static const String UpdateUserState = "$server/api/users/";

// ================================= TaskManagement ========================== //

  static const String getAllCategories = "$server/api/categories/";
  static const String addTask = "$server/api/tasks/addtask";
  static const String updateTaskState = "$server/api/taskState/";
}
