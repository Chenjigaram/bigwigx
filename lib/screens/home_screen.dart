import 'package:bigwigx/locators/locators.dart';
import 'package:bigwigx/models/book.dart';
import 'package:bigwigx/models/category.dart';
import 'package:bigwigx/screens/search.dart';
import 'package:bigwigx/services/book_service.dart';
import 'package:bigwigx/utils/verify_connectivity.dart';
import 'package:bigwigx/widgets/book_card.dart';
import 'package:bigwigx/widgets/cart_button.dart';
import 'package:bigwigx/widgets/category_box.dart';
import 'package:bigwigx/widgets/drawer_homescreen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'book_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  bool _myBooksLoading = true;
  bool _myRecommendsLoading = true;
  bool _isAuthenticated = false;
  BookService _bookService = locator<BookService>();
  Size _deviceSize;
  List<Book> myBooks = [];
  List<Category> categories = [];
  List<Book> recommendations = [];
  List<String> bannerLinks = [];

  @override
  void initState() {
    super.initState();
    getMyBooks();
    getRecommends();
    getCategories();
    //locator<NetworkVerifier>().init(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //locator<NetworkVerifier>().dispose();
  }

  @override
  Widget build(BuildContext context) {
    _deviceSize = MediaQuery.of(context).size;
    List<Widget> actions = [];

    for (int i = 0; i < myBooks.length; i++) {
      actions.add(bannerCards(i));
    }

    Widget bannerCarousel = CarouselSlider(
      items: _myBooksLoading ? [bannerCards(0)] : actions,
      autoPlay: true,
      enlargeCenterPage: true,
    );
    return Scaffold(
      appBar: AppBar(
        title: Container(
            padding: EdgeInsets.all(10),
            child: Text(
              'Bigwigx',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.w500,
                  fontSize: 50),
            )),
        actions: <Widget>[
          CartButton(),
        ],
        bottom: PreferredSize(
          preferredSize: Size(_deviceSize.width, 70),
          child: searchBar(),
        ),
      ),
      drawer: HomeDrawer(),
      body: Container(
        color: Colors.white,
        child: CustomScrollView(slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                  color: Colors.grey.withOpacity(0.1), child: bannerCarousel)
            ]),
          ),
          SliverToBoxAdapter(
            child: Divider(
              height: 1.0,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                width: _deviceSize.width,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.category,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Text('Books by Category',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontFamily: "OpenSans")),
                    ],
                  ),
                ),
              ),
            ]),
          ),
          categories.length > 0
              ? SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return categoryBox(index, context, _deviceSize, categories);
                  }, childCount: categories.length + 1),
                )
              : SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      width: _deviceSize.width,
                      color: Colors.white,
                      child: Center(
                        child: Text('No items present'),
                      ),
                    ),
                  ]),
                ),
          SliverToBoxAdapter(
            child: Container(
              height: 20.0,
              color: Colors.grey.withOpacity(0.1),
            ),
          ),
          SliverToBoxAdapter(
            child: Divider(
              height: 1.0,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                  width: _deviceSize.width,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.local_offer,
                          color: Colors.orange,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text('Recommendations',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontFamily: "OpenSans")),
                      ],
                    ),
                  ))
            ]),
          ),
          _myRecommendsLoading
              ? SliverList(
                  delegate: SliverChildListDelegate([
                  Container(
                    height: _deviceSize.height * 0.47,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlue,
                    ),
                  )
                ]))
              : SliverToBoxAdapter(
                  child: Container(
                    height: 280.0,
                    width: double.infinity,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: recommendations.length,
                      itemBuilder: (context, index) {
                        return showBook(recommendations[index], context);
                      },
                    ),
                  ),
                ),
          SliverToBoxAdapter(
            child: Divider(),
          ),
        ]),
      ),
    );
  }

  Widget bannerCards(int index) {
    if (_myBooksLoading) {
      return Container(
        width: _deviceSize.width * 0.8,
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          elevation: 2,
          margin: EdgeInsets.symmetric(
              vertical: _deviceSize.height * 0.05,
              horizontal: _deviceSize.width * 0.02),
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              child: Image.asset(
                'assets/default/default.jpg',
                fit: BoxFit.fill,
              )),
        ),
      );
    } else {
      return GestureDetector(
          onTap: () {
            MaterialPageRoute route = MaterialPageRoute(
                builder: (context) => BookScreen(
                      book: myBooks[index],
                    ));
            Navigator.of(context).push(route);
          },
          child: Container(
            width: _deviceSize.width * 0.8,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
              elevation: 2,
              margin: EdgeInsets.symmetric(
                  vertical: _deviceSize.height * 0.05,
                  horizontal: _deviceSize.width * 0.02),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                child: FadeInImage(
                  image: myBooks[index].bookImages != null
                      ? myBooks[index].bookImages[0] != null
                          ? NetworkImage(myBooks[index].bookImages[0])
                          : AssetImage('assets/default/default.jpg')
                      : AssetImage('assets/default/default.jpg'),
                  placeholder: AssetImage('assets/default/default.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ));
    }
  }

  getCategories() async {
    setState(() {
      categories.addAll(Category.getCategories());
    });
  }

  Widget searchBar() {
    return GestureDetector(
        onTap: () {
          print("Search clicked");
          MaterialPageRoute route = MaterialPageRoute(
              builder: (context) => BookSearch());
          Navigator.of(context).push(route);
        },
        child: Column(children: [
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)),
            width: _deviceSize.width,
            height: 49,
            margin: EdgeInsets.all(010),
            child: ListTile(
              leading: Icon(Icons.search),
              title: Text(
                'Lets Read ...',
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
            ),
          ),
          Container()
        ]));
  }

  getMyBooks() async {
    myBooks = await _bookService.getBooksList();
    setState(() {
      _myBooksLoading = false;
    });
  }

  getRecommends() async {
    recommendations = await _bookService.getBooksList();
    setState(() {
      _myRecommendsLoading = false;
    });
  }
}
