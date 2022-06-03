import 'package:flutter/material.dart';

import '../Model/login_response_model.dart';

class LoginDetail extends StatelessWidget {
  final LoginResponseModel? model;

  const LoginDetail({
    super.key,
    this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Welcome')),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text("TOKEN"),
              Text(model?.token.toString() ?? "Data is empty, user not found"),
              const SizedBox(height: 15),
              model?.token.toString == null
                  ? const Text("Sende Sıkıntı Yok")
                  : const Text("BAŞARDIM ULA")
            ],
          ),
        ),
      ),
    );
  }
}
