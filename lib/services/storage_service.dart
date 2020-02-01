
import 'package:shared_preferences/shared_preferences.dart';


class StorageService{


  Future<String> getToken() async {
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String token = prefs.getString('token');
      return token;
    }catch(e){
      print(e);
      return "";
    }
  }

  Future<bool> setToken(String token) async {
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.setString('token',token);
    }catch(e){
      print(e);
      return false;
    }
  }

  Future<bool> setEmail(String email) async {
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.setString('email',email);
    }catch(e){
      print(e);
      return false;
    }
  }

  Future<String> getEmail() async {
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String user = prefs.getString('email');
      return user;
    }catch(e){
      print(e);
      return "";
    }
  }

  Future<bool> setUsername(String email) async {
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.setString('username',email);
    }catch(e){
      print(e);
      return false;
    }
  }

  Future<String> getUsername() async {
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String user = prefs.getString('username');
      return user;
    }catch(e){
      print(e);
      return "";
    }
  }
}