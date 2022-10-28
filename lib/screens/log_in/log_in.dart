import 'package:flutter/material.dart';
import 'package:money_manager/db/login/login_db.dart';
import 'package:money_manager/models/login/login_model.dart';
import 'package:money_manager/screens/Register/register_page.dart';
import 'package:money_manager/screens/home/screen_home.dart';

final _usernameTextEditingController = TextEditingController();
final _passwordTextEditingController = TextEditingController();
final loginList = LoginDb.instance.getUsers();

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'LOG IN',
              style: TextStyle(
                  color: Color.fromARGB(255, 2, 141, 95), fontSize: 25),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
            ),
            TextFormField(
              controller: _usernameTextEditingController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                hintText: 'Username',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: _passwordTextEditingController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100))),
                hintText: 'Password',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  final _user = _usernameTextEditingController.text.trim();
                  final _pass = _passwordTextEditingController.text.trim();
                  bool isUserFound = false;
                  final _logindata = await LoginDb.instance.getUsers();
                  final _loginUserPass = _logindata.toList();

                  await Future.forEach(_loginUserPass, (user) {
                    if (user.username == _user && user.password == _pass) {
                      isUserFound = true;
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: ((context) {
                        return const ScreenHome();
                      })));
                    } else {
                      isUserFound == false;
                      return;
                    }
                  });
                },
                child: const Text('Login')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                    return const RegistrationScreen();
                  }));
                },
                child: const Text('Don\'t have an account?'))
          ],
        ),
      ),
    );
  }

  Future<void> checkUser(
      List<LoginModel> loginList, BuildContext context) async {
    final _user = _usernameTextEditingController.toString().trim();
    final _pass = _passwordTextEditingController.toString().trim();
    bool isUserFound = false;
    await Future.forEach(loginList, (user) {
      if (user.username == _user && user.password == _pass) {
        isUserFound = true;
        print('Username found');
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: ((context) {
          return const ScreenHome();
        })));
      } else {
        isUserFound == false;
        return;
      }
    });
  }
}
