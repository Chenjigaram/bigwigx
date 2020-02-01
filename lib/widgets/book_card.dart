import 'package:bigwigx/models/book.dart';
import 'package:bigwigx/screens/book_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

Widget showBooks(int index, List<Book> books,
    Size _deviceSize, BuildContext context) {
  Book book = books[index];
  return GestureDetector(
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => BookScreen(
              book: books[index],
            ));
        Navigator.of(context).push(route);
      },
      child: SizedBox(
          width: _deviceSize.width * 0.4,
          child: Card(
            elevation: 0.0,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.withOpacity(0.4)),
                borderRadius: BorderRadius.circular(4.0)),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(15),
                  child: FadeInImage(
                    image: books[index].bookImages!=null ?books[index].bookImages[0] != null
                        ? NetworkImage(books[index].bookImages[0])
                        : AssetImage('assets/default/default.jpg'):AssetImage('assets/default/default.jpg'),
                    placeholder:
                        AssetImage('assets/default/default.jpg'),
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  padding: EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Text(
                    book.bookName,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 20.0),
                    child: Text(
                      book.availability.toString(),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, top: 20.0, bottom: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(book.numberOfRatings!=null?book.numberOfRatings.toString():'NA'),
                    ],
                  ),
                ),
                Divider(
                  height: 1.0,
                ),
              ],
            ),
          )));
}

Widget showBook(Book book,BuildContext context){
  return GestureDetector(
    onTap: () {
      MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => BookScreen(
            book: book,
          ));
      Navigator.of(context).push(route);
    },
    child: Stack(
      children: <Widget>[
        Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(0.0, 4.0),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Center(
              child: Hero(
                tag: book.bookName,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image(
                    image: book.bookImages!=null ?book.bookImages[0] != null
                        ? NetworkImage(book.bookImages[0])
                        : AssetImage('assets/default/default.jpg'):AssetImage('assets/default/default.jpg'),
                    height: 220.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 30.0,
          bottom: 40.0,
          child: Container(
            width: 250.0,
            child: Text(
              book.bookName.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget ratingBar(double initialRating, double itemSize) {
  return RatingBar(
    itemCount: 5,
    allowHalfRating: true,
    ignoreGestures: true,
    initialRating: initialRating,
    onRatingUpdate: (index) {},
    itemSize: itemSize,
  );
}

Widget showHoZBook(Book book,BuildContext context,Size deviceSize){
  return GestureDetector(
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => BookScreen(
              book: book,
            ));
        Navigator.of(context).push(route);
      },
      child: Container(
          margin: EdgeInsets.all(5.0),
          width: deviceSize.width * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            image: DecorationImage(image:
            book.bookImages!=null ? book.bookImages[0] != null
                ? NetworkImage(book.bookImages[0])
                : AssetImage('assets/default/default.jpg'):AssetImage('assets/default/default.jpg'),
                fit: BoxFit.fill),
          ),
          child: Stack(children: [
            Container(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Text(
                book.bookName,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.end,
              ),
            ),
          ])));
}
