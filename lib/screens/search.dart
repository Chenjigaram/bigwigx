import 'dart:convert';

import 'package:bigwigx/locators/locators.dart';
import 'package:bigwigx/models/book.dart';
import 'package:bigwigx/models/category.dart';
import 'package:bigwigx/services/book_service.dart';
import 'package:bigwigx/widgets/book_card.dart';
import 'package:bigwigx/widgets/book_container.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class BookSearch extends StatefulWidget {
  final String searchString;
  BookSearch({this.searchString});
  @override
  State<StatefulWidget> createState() {
    return _BookSearchState();
  }
}

class _BookSearchState extends State<BookSearch> {
  String searchString = '';
  TextEditingController _controller = TextEditingController();
  // List<SearchProduct> searchProducts = [];
  List<Book> searchBooks = [];
  BookService _bookService = locator<BookService>();
  bool _isLoading = false;
  Book tappedBook = Book();
  final int perPage = 20;
  int currentPage = 1;
  int subCatId = 0;
  bool isSearched = false;
  Size _deviceSize;
  int totalCount = 0;
  static const int PAGE_SIZE = 20;
  final scrollController = ScrollController();
  bool hasMore = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  List<Category> _categories = Category.getCategories();
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  String _currentItem;
  Map<dynamic, dynamic> responseBody;
  String sortBy = '';
  List filterItems = [
    "Newest",
    "Avg.Customer Review",
    "Most Reviews",
    "A TO Z",
    "Z TO A"
  ];
  List<DropdownMenuItem<String>> getDropDownMenuItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String city in filterItems) {
      items.add(new DropdownMenuItem(
        value: city,
        child: Text(
          city,
        ),
      ));
    }
    return items;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sortBy = '';
    _dropDownMenuItems = getDropDownMenuItems();
    _currentItem = _dropDownMenuItems[0].value;
    if (widget.searchString != null) {
      print("SLUG AVAILABLE ${widget.searchString}");
      setState(() {
        searchString = widget.searchString;
        isSearched = true;
        searchBooks = [];
        currentPage = 1;
      });
      searchBook();
    }
    scrollController.addListener(() {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        searchBook();
      }
    });
    //locator<NetworkVerifier>().init(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //locator<NetworkVerifier>().dispose();
  }

  @override
  Widget build(BuildContext mainContext) {
    _deviceSize = MediaQuery.of(mainContext).size;
      return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            elevation: 1.0,
            backgroundColor: Colors.white,
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Container(
              padding: EdgeInsets.only(left: 15),
              child: TextField(
                controller: _controller,
                onChanged: (value) {
                  setState(() {
                    searchString = value;
                  });
                },
                onSubmitted: (value) {
                  isSearched = true;
                  searchBooks = [];
                  currentPage = 1;
                  searchBook();
                  print("ENTER PRESSED ------> $value");
                },
                autofocus: true,
                decoration: InputDecoration(
                    hintText: 'Search',
                    border: InputBorder.none,
                    labelStyle:
                        TextStyle(fontWeight: FontWeight.w300, fontSize: 18)),
              ),
            ),
            actions: <Widget>[
              Visibility(
                visible: searchString != null && searchString.isNotEmpty,
                child: IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _controller.clear();
                      searchString = '';
                      setState(() {
                        searchBooks.clear();
                        isSearched = false;
                      });
                    });
                  },
                ),
              ),
            ],
          ),
          endDrawer: filterDrawer(),
          body: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 90.0),
                child: isSearched
                    ? Theme(
                        data: ThemeData(primarySwatch: Colors.blue),
                        child: ListView.builder(
                            controller: scrollController,
                            itemCount: searchBooks.length + 1,
                            itemBuilder: (mainContext, index) {
                              if (index < searchBooks.length) {

                                //return showBook(searchBooks[index],mainContext);
                                return bookContainer(
                                    _scaffoldKey.currentContext,
                                    searchBooks[index]);
                              }
                              if (hasMore && searchBooks.length == 0) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 50.0),
                                  child: Center(
                                    child: Text(
                                      'No Books Found',
                                      style: TextStyle(fontSize: 20.0),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              }
                              if (!hasMore) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 25.0),
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                  )),
                                );
                              } else {
                                return Container();
                              }
                            }),
                      )
                    : Container(),
              ),
              Visibility(
                  visible: searchBooks.length > 0,
                  child: Material(
                    elevation: 2.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      height: 50.0,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 18.0, left: 16.0),
                        child: Text(
                          '$totalCount Results',
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ),
                    ),
                  )),
              Visibility(
                visible: searchBooks.length > 0,
                child: Container(
                  padding: EdgeInsets.only(right: 20.0, top: 20.0),
                  alignment: Alignment.topRight,
                  child: FloatingActionButton(
                    onPressed: () {
                      _scaffoldKey.currentState.openEndDrawer();
                    },
                    child: Icon(
                      Icons.filter_list,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
              Visibility(
                  visible: isSearched && searchBooks.length == 0,
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.blue,
                    ),
                  )),
              // )
            ],
          ));
  }

  Future<List<Book>> searchBook() async {
    print('SENDING REQUEST $searchString');
    setState(() {
      hasMore = false;
    });
    if (sortBy != null) {
      print('SORT BYT $sortBy');
    } else {

    }


    isSearched = true;
    searchBooks = await _bookService.getBooksList();
    totalCount = searchBooks.length;
    print(hasMore);
    print(searchBooks.length);
    setState(() {
      hasMore = true;
      _isLoading = false;
    });
    return searchBooks;
  }

  Widget filterDrawer() {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Material(
            elevation: 3.0,
            child: Container(
                alignment: Alignment.centerLeft,
                color: Colors.blue,
                height: 150.0,
                child: ListTile(
                  title: Row(
                    children: <Widget>[
                      Text(
                        'Sort By:  ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18.0),
                      ),
                      DropdownButton(
                        underline: Container(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.0,
                            fontWeight: FontWeight.normal),
                        hint: Text(
                          _currentItem,
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold),
                        ),
                        value: null,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.white,
                        ),
                        items: _dropDownMenuItems,
                        onChanged: changedDropDownItem,
                      )
                    ],
                  ),
                )),
          ),
          Expanded(
            child: Theme(
                data: ThemeData(primarySwatch: Colors.blue),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(8.0),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            _isLoading = true;
                            searchString = _categories[index].name;
                            isSearched = true;
                            searchBooks = [];
                            currentPage = 1;
                            searchBook();
                          });
                        },
                        child: Container(
                            width: _deviceSize.width,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            child: Text(
                              _categories[index].name,
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            )));
                  },
                  itemCount: _categories.length,
                )),
          ),
        ],
      ),
    );
  }


  void changedDropDownItem(String sortedBy) {
    String sortingWith = '';
    Navigator.pop(context);
    setState(() {
      _currentItem = sortedBy;
      switch (_currentItem) {
        case 'Newest':
          sortingWith = 'updated_at+asc';
          break;
        case 'Avg.Customer Review':
          sortingWith = 'avg_rating+desc ';
          break;
        case 'Most Reviews':
          sortingWith = 'reviews_count+desc';
          break;
        case 'A TO Z':
          sortingWith = 'name+asc';
          break;
        case 'Z TO A':
          sortingWith = 'name+desc';
          break;
      }
      isSearched = true;
      searchBooks = [];
      currentPage = 1;
      this.sortBy = sortingWith;
      searchBook();
    });
  }
}
