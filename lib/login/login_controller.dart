import 'login_model.dart';

class LoginController {
  final LoginModel model;
  LoginController(this.model);

  Future<String?> getServer() => model.getServer();

  Future<bool> login(String email, String password) async {
    final server = await model.getServer();
    if (server == null) return false;

    final immichOk = await model.loginImmich(server, email, password);
    final nextcloudOk = await model.loginNextcloud(server, email, password);

    return immichOk && nextcloudOk;
  }
}