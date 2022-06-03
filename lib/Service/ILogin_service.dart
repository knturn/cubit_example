import 'package:dio/dio.dart';

import '../login_cubit_example/Model/login_request_model.dart';
import '../login_cubit_example/Model/login_response_model.dart';

abstract class ILoginService {
  final Dio dio;
  final String loginPath = ILoginServicePath.LOGIN.rawValue;
  ILoginService(this.dio);
  Future<LoginResponseModel?> postUserLogin(LoginRequestModel model);
}

enum ILoginServicePath { LOGIN }

extension ILoginServicePathExtansion on ILoginServicePath {
  String get rawValue {
    switch (this) {
      case ILoginServicePath.LOGIN:
        return "/login";
    }
  }
}
