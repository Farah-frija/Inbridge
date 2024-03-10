import 'package:inbridge/Sprints/auth/login/data/datasources/loginApi.dart';
import 'package:inbridge/Sprints/auth/login/data/models/loginModel.dart';
import 'package:inbridge/Sprints/auth/linkApi.dart';

class LoginData {
  LoginApi api;
  LoginData(this.api);
  postdata(LoginModel model) async {
    var response = await api.postData(AppLink.login, model);
    return response.fold((l) => l, (r) => r);
  }
}
