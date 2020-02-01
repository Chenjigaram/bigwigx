import 'package:bigwigx/screens/bigwigx_screen.dart';
import 'package:bigwigx/services/user_service.dart';
import 'package:flutter/material.dart';

import 'locators/locators.dart';

void main() {
  setUpObjects();
  runApp(MyApp());
}



class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  UserService _userService = locator<UserService>();

  @override
  void initState() {
    _userService.getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Books Rentals',
        initialRoute: '/bigwigx',
        routes: {
          '/bigwigx' : (context) => BigwigxPage()
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.white,
        ),
        home: BigwigxPage(),
      );
  }
}
