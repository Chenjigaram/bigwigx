import 'package:flutter/foundation.dart';

class LoginData {
  final String email;
  final String password;

  LoginData({
    @required this.email,
    @required this.password,
  });

  @override
  String toString() {
    return '$runtimeType($email, $password)';
  }
}
