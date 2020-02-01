import 'dart:convert';
import 'dart:io';

import 'package:bigwigx/constants/constants.dart';
import 'package:bigwigx/locators/locators.dart';
import 'package:bigwigx/models/book_cart.dart';
import 'package:bigwigx/models/book_cart_item.dart';
import 'package:bigwigx/models/login_data.dart';
import 'package:bigwigx/models/order.dart';
import 'package:bigwigx/models/user.dart';
import 'package:bigwigx/services/storage_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';


class CartService{

  List<Order> orders;
  List<BookCartItem> bookCartItems;
  StorageService _storageService = locator<StorageService>();


  Future<http.Response> getOrders(String filter) async{

    String token = await _storageService.getToken();
    final response = await http.get(Constants.cartServiceURL+"/orders?filter=$filter",headers:{"Content-type": "application/json",HttpHeaders.authorizationHeader: "Bearer $token"});
    print(response.body);
    return response;
  }

  Future<http.Response> postOrder(Order order) async{
    String token = await _storageService.getToken();
    final response = await http.post(Constants.cartServiceURL+"/users/me",headers:{"Content-type": "application/json",HttpHeaders.authorizationHeader: "Bearer $token"},body: json.encode(order));
    print(response.body);
    return response;
  }

  Future<http.Response> postCartItem(BookCartItem item) async{
    String token = await _storageService.getToken();
    String username = await _storageService.getUsername();
    print(jsonEncode(item));
    final response = await http.post(Constants.cartServiceURL+"/bookscart/$username/items",headers:{"Content-type": "application/json",HttpHeaders.authorizationHeader: "Bearer $token"},body: jsonEncode(item));
    print(response.body);
    return response;
  }

  Future<http.Response> getCart() async{
    String token = await _storageService.getToken();
    String username = await _storageService.getUsername();
    final response = await http.get(Constants.cartServiceURL+"/bookscart/$username",headers:{"Content-type": "application/json",HttpHeaders.authorizationHeader: "Bearer $token"});
    print(response.body);
    return response;
  }

  Future<http.Response> deleteCart() async{
    String token = await _storageService.getToken();
    String username = await _storageService.getUsername();
    final response = await http.delete(Constants.cartServiceURL+"/bookscart/$username",headers:{"Content-type": "application/json",HttpHeaders.authorizationHeader: "Bearer $token"});
    print(response.body);
    return response;
  }

  Future<http.Response> putCartItem(BookCart item) async{
    String token = await _storageService.getToken();
    String username = await _storageService.getUsername();
    final response = await http.put(Constants.cartServiceURL+"/bookscart/$username",headers:{"Content-type": "application/json",HttpHeaders.authorizationHeader: "Bearer $token"},body: json.encode(item));
    print(response.body);
    return response;
  }


  Future<void> removeToken() async {
    await _storageService.setEmail("");
    await _storageService.setToken("");
    await _storageService.setUsername("");
  }

}