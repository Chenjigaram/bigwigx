import 'package:bigwigx/locators/locators.dart';
import 'package:bigwigx/models/user.dart';
import 'package:bigwigx/screens/home_screen.dart';
import 'package:bigwigx/screens/user_authorisation.dart';
import 'package:bigwigx/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';


class BigwigxPage extends StatefulWidget {

  @override
  _BigwigxPageState createState() => _BigwigxPageState();
}

class _BigwigxPageState extends State<BigwigxPage> {

  UserService _userService = locator<UserService>();
  bool isLoadingDone = false;
  bool _isAuthenticated = false;
  User user;
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
    return true;
  }

  void checkUser(){
    _userService.getUser().then((User onValue){
      if(onValue != null){
        MaterialPageRoute route = MaterialPageRoute(
            builder: (context) => HomeScreen());
        Navigator.of(context).push(route);
      }
      else{
        setState(() {
          isLoadingDone = true;
        });
      }
    });
  }

  Widget bottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (index) {
        MaterialPageRoute route =
        MaterialPageRoute(builder: (context) => UserAuthorisation(index));

        Navigator.push(context, route);
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline, color: Colors.blue),
          title: Text('LOG IN'),
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              color: Colors.blue,
            ),
            title: Text('SIGN UP',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                    fontWeight: FontWeight.w600))),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.blue,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Text(
                  'Bigwigx',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Quicksand',fontWeight: FontWeight.w500, fontSize: 50, color: Colors.white),
                ),
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.book,
                    color: Colors.white,
                    size: 100.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Rent Read Return ....',
                      style: TextStyle(color: Colors.white, fontSize: 22.0),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar:
      isLoadingDone ? !_isAuthenticated?bottomNavigationBar() : null:null,
    );
  }
}
