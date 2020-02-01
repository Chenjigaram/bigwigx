import 'package:flutter/material.dart';

Widget CartButton() {
    return new Padding(
      padding:
          const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 25, left: 10),
      child: new Container(
        height: 150.0,
        width: 30.0,
        child: new GestureDetector(
          onTap: () {
            print("cart clicked");
          },
          child: new Stack(
            children: <Widget>[
              new IconButton(
                iconSize: 30,
                icon: new Icon(
                  Icons.book,
                  color: Colors.white,
                ),
                onPressed: null,
              ),
              new Positioned(
                child: Container(
                  width: 21.0,
                  height: 21.0,
                  child: new Stack(
                    children: <Widget>[
                      new Icon(Icons.brightness_1,
                          size: 21.0, color: Colors.yellow),
                      new Center(
                        child: new Text(
                          '0',
                          style: new TextStyle(
                              color: Colors.black,
                              fontSize: 11.0,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
}
