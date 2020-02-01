import 'dart:convert';
import 'dart:io';

import 'package:bigwigx/constants/constants.dart';
import 'package:bigwigx/locators/locators.dart';
import 'package:bigwigx/models/login_data.dart';
import 'package:bigwigx/models/user.dart';
import 'package:bigwigx/services/storage_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class UserService{

  User _user;
  StorageService _storageService = locator<StorageService>();

  User get user{
    return _user;
  }

  Future<http.Response> doLogin(LoginData data) async{

    print({'email': data.email, 'password': data.password});
    final response = await http.post(Constants.userServiceURL+"/users/login",headers:{"Content-type": "application/json"},
        body: json.encode({'email': data.email, 'password': data.password}));
    print(response.body);
    return response;
  }

  Future<http.Response> getuser(String token) async{
    final response = await http.get(Constants.userServiceURL+"/users/me",headers:{"Content-type": "application/json",HttpHeaders.authorizationHeader: "Bearer $token"});
    print(response.body);
    return response;
  }

  Future<User> getUser() async {
    _user = null;
    final String token = await _storageService.getToken();
    if (token != null) {
      Response response = await getuser(token);
        if (response.statusCode == 200) {
          _user = User.fromJson(json.decode(response.body));
          await _storageService.setEmail(_user.email);
        }
        return _user;
    }else{
    return _user;
    }
  }

  Future<void> removeToken() async {
    await _storageService.setEmail("");
    await _storageService.setToken("");
    await _storageService.setUsername("");
  }

}