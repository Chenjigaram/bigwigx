import 'package:bigwigx/models/book.dart';
import 'package:bigwigx/screens/book_screen.dart';
import 'package:flutter/material.dart';

Widget bookContainer(BuildContext context, Book book) {
  return GestureDetector(
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => BookScreen(
              book: book,
            ));
        Navigator.of(context).push(route);
      },
      child: Container(
        padding: EdgeInsets.only(top: 15.0),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 150,
                      color: Colors.white,
                      child: FadeInImage(
                        image: book.bookImages!=null ? book.bookImages[0] != null
                            ? NetworkImage(book.bookImages[0])
                            : AssetImage('assets/default/default.jpg'):AssetImage('assets/default/default.jpg'),
                        placeholder: AssetImage(
                            'assets/default/default.jpg'),
                      ),
                    ),
                  ],
                ),
                Container(
                    width: 150,
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    alignment: Alignment.center,
                    child: Text(
                      'More Choices\nAvailable',
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0, top: 0.0),
                    child: RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: '${book.bookName} ',
                          style: TextStyle(
                              color: Color(0xff676767),
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ]),
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child:RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'Available : ',
                              style: TextStyle(
                                  color: Color(0xff676767),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal),
                            ),
                            TextSpan(
                              text: book.availability.toString(),
                              style: TextStyle(
                                  color: book.availability < 9 ?Colors.red : Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          ]),
                        ),
                      ),

                      Container(),
                    ],
                  ),
                  SizedBox(height: 7),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5.0, top: 0.0),
                      child: Container(),
                    ),
                  ),
                  SizedBox(height: 7),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(),
                      SizedBox(
                        width: 5.0,
                      ),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'Language : ',
                            style: TextStyle(
                                color: Color(0xff676767),
                                fontSize: 16.0,
                                fontWeight: FontWeight.normal),
                          ),
                          TextSpan(
                            text: book.language,
                            style: TextStyle(
                                color: book.availability < 9 ?Colors.red : Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ]),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    // indent: 150.0,
                    height: 1.0,
                  )
                ],
              ),
            ),
          ],
        ),
      ));
}
