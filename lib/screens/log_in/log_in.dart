import 'package:flutter/material.dart';
//import 'package:form_field_validator/form_field_validator.dart';
import 'package:money_manager/db/login/login_db.dart';
//import 'package:money_manager/models/login/login_model.dart';
import 'package:money_manager/screens/Register/register_page.dart';
import 'package:money_manager/screens/home/screen_home.dart';

final _usernameTextEditingController = TextEditingController();
final _passwordTextEditingController = TextEditingController();
final loginList = LoginDb.instance.getUsers();

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  var showSnackbar = 0;
  var _passwordVisible = false;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'LOG IN',
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
                controller: _usernameTextEditingController,
                validator: (value) {
                  if (value!.isEmpty ||
                      RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]')
                          .hasMatch(value)) {
                    return 'Please enter alphabets only.';
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  labelText: 'Username',
                  contentPadding: EdgeInsets.only(left: 10),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  //hintText: 'Username',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: !_passwordVisible,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _passwordTextEditingController,
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
                  // hintText: 'Password',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    final user = _usernameTextEditingController.text.trim();
                    final pass = _passwordTextEditingController.text.trim();
                    final logindata = await LoginDb.instance.getUsers();
                    final loginUserPass = logindata.toList();

                    await Future.forEach(loginUserPass, (userdata) {
                      if (userdata.username == user &&
                          userdata.password == pass) {
                        showSnackbar = 1;
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: ((context) {
                          return const ScreenHome();
                        })));
                      } else {
                        showSnackbar = 2;
                      }
                    });
                    if (showSnackbar == 1) {
                      const snackBar = SnackBar(
                        content: Text('Logging in'),
                        duration: Duration(milliseconds: 2000),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                    if (showSnackbar == 2) {
                      const snackBar = SnackBar(
                        content: Text('Invalid username or password.'),
                        duration: Duration(milliseconds: 2000),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: const Text('Login')),
              TextButton(
                  onPressed: () {
                    _usernameTextEditingController.clear();
                    _passwordTextEditingController.clear();
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (ctx) {
                      return const RegistrationScreen();
                    }));
                  },
                  child: const Text('Don\'t have an account?'))
            ],
          ),
        ),
      ),
    );
  }
}
