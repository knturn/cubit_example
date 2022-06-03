import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("You haven't register yet.")),
        body: Center(
          child: Column(
            children: const [
              Center(child: Text("Welcome to club")),
            ],
          ),
        ));
  }
}
