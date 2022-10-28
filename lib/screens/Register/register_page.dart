import 'package:flutter/material.dart';
import 'package:money_manager/db/login/login_db.dart';
import 'package:money_manager/models/login/login_model.dart';
import 'package:money_manager/screens/log_in/log_in.dart';

final _usernameEditingController = TextEditingController();

final _passwordEditingController = TextEditingController();

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'REGISTER',
              style: TextStyle(
                color: Colors.green,
                fontSize: 25,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 30),
            ),
            TextFormField(
              controller: _usernameEditingController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  hintText: 'Username'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _passwordEditingController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100))),
                  hintText: 'Password'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  addLoginCredential();
                  Navigator.of(context).pop();
                  final _data = await LoginDb.instance.getUsers();
                  final _datalist = _data.toList();
                },
                child: const Text('Create Account')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return const LogInScreen();
                  }));
                },
                child: const Text('Already have an account?'))
          ],
        ),
      ),
    );
  }

  addLoginCredential() async {
    final _loginModel = LoginModel(
      username: _usernameEditingController.text,
      password: _passwordEditingController.text,
    );
    await LoginDb().addLoginCredentials(_loginModel);
  }
}
