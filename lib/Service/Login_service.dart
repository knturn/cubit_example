import 'dart:io';

import 'ILogin_service.dart';
import '../login_cubit_example/Model/login_response_model.dart';
import '../login_cubit_example/Model/login_request_model.dart';

class LoginService extends ILoginService {
  LoginService(super.dio);

  @override
  Future<LoginResponseModel?> postUserLogin(LoginRequestModel model) async {
    final response = await dio.post(loginPath, data: model);

    if (response.statusCode == HttpStatus.ok) {
      return LoginResponseModel.fromJson(response.data);
    } else if (response.statusCode == HttpStatus.badRequest) {
      LoginResponseModel.fromJson(response.extra);
    } else {
      return null;
    }
  }
}
