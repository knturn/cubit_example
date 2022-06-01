import 'package:cubit_example/Service/Login_service.dart';
import 'package:cubit_example/login_cubit_example/Model/login_response_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../View Model/login_cubit.dart';
import 'login_detail.dart';

class CubitView extends StatelessWidget {
  CubitView({Key? key}) : super(key: key);
  final GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final baseurl = 'https://reqres.in/api';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        formkey,
        emailController,
        passwordController,
        service: LoginService(
          Dio(
            BaseOptions(baseUrl: baseurl),
          ),
        ),
      ),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginComplatedeState) {
            state.navigate(context);
          }
        },
        builder: (context, state) {
          return buildScaffold(context, state);
        },
      ),
    );
  }

  Scaffold buildScaffold(BuildContext context, LoginState state) {
    return Scaffold(
      appBar: AppBar(
        leading: Visibility(
            visible: context.watch<LoginCubit>().isLoading,
            child: const Padding(
              padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
              child: CircularProgressIndicator(),
            )),
        title: const Center(child: Text("LOGIN PAGE")),
        backgroundColor: const Color.fromARGB(255, 7, 31, 37),
      ),
      body: buildForm(state, context),
    );
  }

  Form buildForm(LoginState state, BuildContext context) {
    return Form(
      key: formkey,
      autovalidateMode: autovalidateMethod(state),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildloggin(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            buildpassword(),
            buildButton(context)
          ],
        ),
      ),
    );
  }

  ElevatedButton buildButton(BuildContext context) {
    return ElevatedButton(
        onPressed: context.watch<LoginCubit>().isLoading
            ? null
            : () {
                context.read<LoginCubit>().postUserModel();
              },
        child: const Text("LOGIN"));
  }

  AutovalidateMode autovalidateMethod(LoginState state) {
    return state is LoginValidateState
        ? (state.isValidate
            ? AutovalidateMode.always
            : AutovalidateMode.disabled)
        : AutovalidateMode.disabled;
  }

  TextFormField buildloggin() {
    return TextFormField(
      controller: emailController,
      validator: (value) => (value ?? " ").length > 8
          ? null
          : ("Geçersiz değer. En az 8 parametre giriniz"),
      decoration: const InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          labelText: "Email"),
    );
  }

  TextFormField buildpassword() {
    return TextFormField(
        controller: passwordController,
        validator: (value) => (value ?? " ").length > 4
            ? null
            : ("Geçersiz değer. En az 4 parametre giriniz"),
        decoration: const InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            labelText: "Password"));
  }
}

extension LoginComplateExtension on LoginComplatedeState {
  void navigate(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => LoginDetail(
              model: model,
            )));
  }
}
