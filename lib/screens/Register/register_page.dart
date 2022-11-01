import 'package:flutter/material.dart';
//import 'package:form_field_validator/form_field_validator.dart';
import 'package:money_manager/db/login/login_db.dart';
import 'package:money_manager/models/login/login_model.dart';
import 'package:money_manager/screens/log_in/log_in.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _usernameEditingController = TextEditingController();
  final _passwordEditingController = TextEditingController();

  var _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'REGISTER',
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 30),
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _usernameEditingController,
              validator: (value) {
                if (value!.isEmpty ||
                    RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                        .hasMatch(value)) {
                  return 'Only alphabets allowed';
                } else {
                  return null;
                }
              },
              decoration: const InputDecoration(
                labelText: 'Username',
                contentPadding: EdgeInsets.only(left: 10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              obscureText: !_passwordVisible,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _passwordEditingController,
              validator: (value) {
                if (value!.isEmpty || value.length < 6) {
                  return 'Should contain atleast 6 characters.';
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(_passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                ),
                labelText: 'Password',
                contentPadding: const EdgeInsets.only(left: 10),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () async {
                  addLoginCredential();
                  final data = await LoginDb.instance.getUsers();
                  final datalist = data.toList();
                  _passwordEditingController.clear();
                  _usernameEditingController.clear();
                  const snackBar = SnackBar(
                    content: Text('Account created.'),
                    duration: Duration(milliseconds: 2000),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.of(context).pop();
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
    final loginModel = LoginModel(
      username: _usernameEditingController.text,
      password: _passwordEditingController.text,
    );
    await LoginDb().addLoginCredentials(loginModel);
  }
}
