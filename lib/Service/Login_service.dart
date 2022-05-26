import 'dart:html';

import 'ILogin_service.dart';
import '../login_cubit_example/Model/login_response_model.dart';
import '../login_cubit_example/Model/login_request_model.dart';

class LoginService extends ILoginService {
  LoginService(super.dio);

  @override
  Future<LoginResponeModel?> postUserLogin(LoginRequestModel model) async {
    final response = await dio.post(loginPath, data: model);

    if (response.statusCode == HttpStatus.ok) {
      return LoginResponeModel.fromJson(response.data);
    } else {
      return response.data.HttpStatus;
    }
  }
}
