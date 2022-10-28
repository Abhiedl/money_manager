import 'package:hive/hive.dart';
part 'login_model.g.dart';

@HiveType(typeId: 4)
class LoginModel {
  @HiveField(0)
  final String username;

  @HiveField(1)
  final String password;

  @HiveField(2)
  String? id;

  LoginModel({
    required this.username,
    required this.password,
  }) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}
