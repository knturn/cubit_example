import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

class LoginCubit extends Cubit<LoginState> {
  TextEditingController emailController;
  TextEditingController passwordController;
  bool isLoginFail = false;
  final GlobalKey<FormState> formkey;

  LoginCubit(this.formkey, this.emailController, this.passwordController)
      : super(LoginInitial());

  void postUserModel() {
    if (formkey.currentState?.validate() ?? false) {
      //TODO service;
    } else {
      isLoginFail = true;
      emit(LoginValidateState(isLoginFail));
    }
  }
}

class LoginValidateState extends LoginState {
  final bool isValidate;

  LoginValidateState(this.isValidate);
}

abstract class LoginState {}

class LoginInitial extends LoginState {}
