import 'package:cubit_example/login_cubit_example/Model/login_response_model.dart';
import 'package:flutter/material.dart';

class LoginDetail extends StatelessWidget {
  final LoginResponeModel? model;
  const LoginDetail({Key? key, this.model}) : super(key: key);

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
