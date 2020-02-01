import 'package:bigwigx/models/book_cart_item.dart';

import 'package:json_annotation/json_annotation.dart';

part 'book_cart.g.dart';

@JsonSerializable(nullable: true,includeIfNull: false)
class BookCart{
  String username;
  List<BookCartItem> items;

  BookCart({this.username,this.items});



/*  factory BookCart.fromJson(Map<String,dynamic> json){
    if(json!=null && json!=""){
      return BookCart(
          username:json['username'],
          items:BookCartItem.listBooksCartItems(json['items']),
      );
    }
    return null;
  }
  static List<BookCart> listBooksCarts(dynamic listBooksCart){
    if(listBooksCart!=null && listBooksCart!=""){
      var booksCartList = listBooksCart as List;
      List<BookCart> booksCart = booksCartList.map((bookCart)=>BookCart.fromJson(bookCart)).toList();
      return booksCart;
    }return null;
  }*/

  factory BookCart.fromJson(Map<String, dynamic> json) => _$BookCartFromJson(json);

  Map<String, dynamic> toJson() => _$BookCartToJson(this);

}