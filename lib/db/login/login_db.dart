import 'package:hive_flutter/adapters.dart';
//import 'package:money_manager/db/transaction/transaction_db.dart';
import 'package:money_manager/models/login/login_model.dart';

const LOGIN_DB_NAME = 'login_db';

abstract class LoginDbFunctions {
  Future<void> addLoginCredentials(LoginModel obj);
  Future<List<LoginModel>> getUsers();
}

class LoginDb implements LoginDbFunctions {
  LoginDb.internal();
  static LoginDb instance = LoginDb.internal();

  factory LoginDb() {
    return instance;
  }

  @override
  Future<void> addLoginCredentials(LoginModel obj) async {
    final _db = await Hive.openBox<LoginModel>('LOGIN_DB_NAME');
    await _db.put(obj.id, obj);
  }

  @override
  Future<List<LoginModel>> getUsers() async {
    final Login_db = await Hive.openBox<LoginModel>('LOGIN_DB_NAME');
    return Login_db.values.toList();
  }
}
