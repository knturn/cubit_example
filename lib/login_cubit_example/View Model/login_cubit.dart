import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../Service/ILogin_service.dart';
import '../Model/login_request_model.dart';
import '../Model/login_response_model.dart';

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
      emit(LoginLoadingState(true));
      final data = await service.postUserLogin(LoginRequestModel(
          email: emailController.text.toString(),
          password: passwordController.text.toString()));
      Future.delayed(const Duration(milliseconds: 5));

      if (data is LoginResponseModel && data.token.toString().isNotEmpty) {
        emit(LoginCompletedState(data));
      }
      emit(LoginLoadingState(false));
    } else {
      isLoginFail = true;
      emit(LoginFailState(isLoginFail));
      emit(LoginValidateState(isLoginFail));
      // emit(LoginValidateState(isLoginFail));
    }
  }

  void chanceLoading() {
    isLoading = true;
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

class LoginCompletedState extends LoginState {
  final LoginResponseModel? model;

  LoginCompletedState(
    this.model,
  );
}

class LoginFailState extends LoginState {
  final bool isLoginFail;

  LoginFailState(this.isLoginFail);
}
