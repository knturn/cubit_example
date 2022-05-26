import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../View Model/login_cubit.dart';

class CubitView extends StatelessWidget {
  CubitView({Key? key}) : super(key: key);
  final GlobalKey<FormState> formkey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        formkey,
        emailController,
        passwordController,
      ),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          return buildScaffold(context, state);
        },
      ),
    );
  }

  Scaffold buildScaffold(BuildContext context, LoginState state) {
    var form = Form(
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
            ElevatedButton(
                onPressed: () {
                  context.read<LoginCubit>().postUserModel();
                },
                child: const Text("SAVE"))
          ],
        ),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hellllo"),
        backgroundColor: const Color.fromARGB(255, 7, 31, 37),
      ),
      body: form,
    );
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
        validator: (value) => (value ?? " ").length > 12
            ? null
            : ("Geçersiz değer. En az 12 parametre giriniz"),
        decoration: const InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            labelText: "Password"));
  }
}
