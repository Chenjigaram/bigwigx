import 'dart:convert';

import 'package:bigwigx/locators/locators.dart';
import 'package:bigwigx/models/book.dart';
import 'package:bigwigx/models/book_cart_item.dart';
import 'package:bigwigx/services/cart_service.dart';
import 'package:bigwigx/widgets/circular_clipper.dart';
import 'package:bigwigx/widgets/content_scroll.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:uuid/uuid.dart';



class BookScreen extends StatefulWidget {
  final Book book;

  BookScreen({this.book});

  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {

  CartService _cartService = locator<CartService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                child: Hero(
                  tag: widget.book.bookName,
                  child: ClipShadowPath(
                    clipper: CircularClipper(),
                    shadow: Shadow(blurRadius: 20.0),
                    child: Image(
                      height: 400.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      image: widget.book.bookImages!=null ? widget.book.bookImages[0] != null
                          ? NetworkImage(widget.book.bookImages[0])
                          : AssetImage('assets/default/default.jpg'):AssetImage('assets/default/default.jpg'),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    padding: EdgeInsets.only(left: 30.0),
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back),
                    iconSize: 30.0,
                    color: Colors.blue,
                  ),
                  Container(),
                ],
              ),
              Positioned.fill(
                bottom: 10.0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RawMaterialButton(
                    padding: EdgeInsets.all(10.0),
                    elevation: 12.0,
                    onPressed: () => print('Play Video'),
                    shape: CircleBorder(),
                    fillColor: Colors.white,
                    child: Icon(
                      Icons.book,
                      size: 60.0,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 20.0,
                child: IconButton(
                  onPressed: () {
                    BookCartItem bookCartItem = BookCartItem(id:Uuid().v1(),book:Book.newBook(widget.book),toReturn: false,isCompleted: false,itemStatus: ["IN_CART"]);
                    _cartService.postCartItem(bookCartItem).then((Response onValue){

                      if(onValue.statusCode==200){
                        print("added to cart");
                        _cartService.getCart().then((Response onValue){
                          print(jsonDecode(onValue.body));
                        });
                      }else{
                        print("added to cart failed");
                      }

                    });
                },
                  icon: Icon(Icons.add),
                  iconSize: 40.0,
                  color: Colors.blue,
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 25.0,
                child: IconButton(
                  onPressed: () => print('Share'),
                  icon: Icon(Icons.share),
                  iconSize: 35.0,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.book.bookName.toUpperCase(),
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.0),
                Text(
                  widget.book.category,
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  '⭐ ⭐ ⭐ ⭐',
                  style: TextStyle(fontSize: 25.0),
                ),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'Author',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          widget.book.author!=null? widget.book.author:'NA',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Availability',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          widget.book.availability!=null?widget.book.availability.toString():'NA',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Avearge Reading Time',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          widget.book.averageReadingTime!=null?'${widget.book.averageReadingTime} min':'NA',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25.0),
                Container(
                  height: 120.0,
                  child: SingleChildScrollView(
                    child: Text(
                      widget.book.description,
                      style: TextStyle(
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
