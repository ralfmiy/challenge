import 'package:challenge/ui/view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../model/login_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: <Widget>[
          const Expanded(child: SizedBox()),
          const Text("Bienvenido", style: TextStyle(fontSize: 40)),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey,
                ),
                controller: usernameController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9]+'))
                ],
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.shade300, width: 2)),
                  hintText: 'Usuario',
                )),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: TextField(
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey,
                ),
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.shade300, width: 2)),
                    hintText: "Contraseña")),
          ),
          const SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    Provider.of<LoginViewModel>(context, listen: false)
                        .postLogin(LoginModel(username: usernameController.text,password: passwordController.text), context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.primary),
                  ),
                  child: const Text(
                    "Ingresar",
                    style: TextStyle(fontSize: 20),
                  )),
            ),
          ),
          const SizedBox(
            height: 60,
          )
        ]),
      ),
    );
  }
}
