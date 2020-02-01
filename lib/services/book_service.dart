
import 'dart:convert';
import 'dart:io';

import 'package:bigwigx/locators/locators.dart';
import 'package:bigwigx/models/book.dart';
import 'package:bigwigx/services/storage_service.dart';
import 'package:http/http.dart';
import '../constants/constants.dart';

class BookService{

  StorageService _storageService = locator<StorageService>();

  Future<Response> getBooks(String token) async{
    final response = await get(Constants.bookServiceURL+"/books",headers:{"Content-type": "application/json",HttpHeaders.authorizationHeader: "Bearer $token"});
    print(response.body);
    return response;
  }

  Future<List<Book>> getBooksList() async{
    String token = await _storageService.getToken();
    if(token == null && token==""){
      return null;
    }else{
      Response response = await getBooks(token);
      if (response.statusCode == 200) {
        return Book.listBooks(jsonDecode(response.body));
      }
      return null;
    }
  }

}