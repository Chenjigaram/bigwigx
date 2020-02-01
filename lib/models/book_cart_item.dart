import 'dart:convert';

import 'book.dart';

import 'package:json_annotation/json_annotation.dart';

part 'book_cart_item.g.dart';

@JsonSerializable(nullable: true,includeIfNull: false)
class BookCartItem{
  String id;
  Book book;
  bool toReturn;
  bool isCompleted;
  List<String> itemStatus;
  BookCartItem({this.id,this.book,this.toReturn,this.isCompleted,this.itemStatus});

  factory BookCartItem.fromJson(Map<String, dynamic> json) => _$BookCartItemFromJson(json);

  Map<String, dynamic> toJson() => _$BookCartItemToJson(this);

/*  factory BookCartItem.fromJson(Map<String,dynamic> json){
    if(json!=null && json!=""){
      return BookCartItem(
          id:json['id'],
          book:Book.fromJson(json['book']),
          toReturn:json['toReturn'],
          isCompleted:json['isCompleted'],
          itemStatus:Book.listString(json['itemStatus']),
      );
    }
    return null;
  }

  static List<BookCartItem> listBooksCartItems(dynamic listBooksCartItems){
    if(listBooksCartItems!=null && listBooksCartItems!=""){
      var booksCartListItems = listBooksCartItems as List;
      List<BookCartItem> booksCart = booksCartListItems.map((bookCartItem)=>BookCartItem.fromJson(bookCartItem)).toList();
      return booksCart;
    }return null;
  }
  Map<String, dynamic> toJson(){
    var jsonValue = {
    'id':this.id,
    'book':json.encode(book),
    'toReturn':this.toReturn,
    'isCompleted':this.isCompleted,
    'itemStatus':jsonEncode(this.itemStatus),
    };
    jsonValue.removeWhere((k,v)=>v==null);
    return jsonValue;
  }*/

}