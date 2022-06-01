import 'package:bloc/bloc.dart';
import 'package:cubit_example/Service/ILogin_service.dart';
import 'package:cubit_example/login_cubit_example/Model/login_request_model.dart';
import 'package:cubit_example/login_cubit_example/Model/login_response_model.dart';
import 'package:flutter/cupertino.dart';

class LoginCubit extends Cubit<LoginState> {
  TextEditingController emailController;
  TextEditingController passwordController;
  bool isLoginFail = false;
  bool isLoading = false;
  final ILoginService service;
  final GlobalKey<FormState> formkey;

  LoginCubit(this.formkey, this.emailController, this.passwordController,
      {required this.service})
      : super(LoginInitial());

  Future<void> postUserModel() async {
    if (formkey.currentState != null && formkey.currentState!.validate()) {
      chanceLoading();
      final data = await service.postUserLogin(LoginRequestModel(
          email: emailController.text.trim(),
          password: passwordController.text.trim()));
      chanceLoading();

      if (data is LoginResponeModel) {
        emit(LoginComplatedeState(data));
      }
    } else {
      print("sıkıntı mı");
      isLoginFail = true;
      emit(LoginValidateState(isLoginFail));
    }
  }

  void chanceLoading() {
    isLoading = !isLoading;
    emit(LoginLoadingState(isLoading));
  }
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginValidateState extends LoginState {
  final bool isValidate;

  LoginValidateState(this.isValidate);
}

class LoginLoadingState extends LoginState {
  final bool isLoading;

  LoginLoadingState(this.isLoading);
}

class LoginComplatedeState extends LoginState {
  final LoginResponeModel model;

  LoginComplatedeState(this.model);
}
