

import 'package:bigwigx/locators/locators.dart';
import 'package:bigwigx/screens/home_screen.dart';
import 'package:bigwigx/screens/user_authorisation.dart';
import 'package:bigwigx/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeDrawer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeDrawer();
  }
}

class _HomeDrawer extends State<HomeDrawer> {
  UserService _userService = locator<UserService>();

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  String userName = '';

  Widget logOutButton() {
    return ListTile(
      leading: Icon(
        Icons.call_made,
        color: Colors.grey,
      ),
      title: Text(
        'Log Out',
        style: TextStyle(color: Colors.grey),
      ),
      onTap: () {
        _showDialog(context);
      },
    );
  }

  Widget accountListTile() {
    return ListTile(
      leading: Icon(
        Icons.person,
        color: Colors.blueAccent,
      ),
      title: Text(
        'Account',
        style: TextStyle(color: Colors.blueAccent),
      ),
      onTap: () {
        print("account pressed");
      },
    );
  }

  Widget orderHistoryLineTile() {
    return ListTile(
      leading: Icon(
        Icons.receipt,
        color: Colors.blueAccent,
      ),
      title: Text(
        'Order History',
        style: TextStyle(color: Colors.blueAccent),
      ),
      onTap: () {
        print("Order History pressed");
      },
    );
  }

  formatName() {
    if (userName != null) {
      return userName.toUpperCase();
    }
  }

  getUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('email') !=null?prefs.getString('email').split('@')[0]:"GUEST";
    });
  }

  void _showDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Log Out"),
            content: new Text("Are you sure you want to log out?"),
            actions: <Widget>[
              new FlatButton(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _userService.removeToken();
                  MaterialPageRoute route = MaterialPageRoute(
                      builder: (context) => UserAuthorisation(0));
                  Navigator.push(context, route);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0.0),
        children: <Widget>[
          DrawerHeader(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                'Bigwigx',
                style: TextStyle(
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w500,
                    fontSize: 50,
                    color: Colors.white),
              ),
              Text(
                'Rent Read Return ',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text('Hi, ${formatName()}!',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500))
                  ],
                ),
              )
            ]),
            decoration: BoxDecoration(color: Colors.blueAccent),
          ),
          ListTile(
            onTap: () {
              MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) => HomeScreen());
              Navigator.push(context, route);
            },
            leading: Icon(
              Icons.home,
              color: Colors.blueAccent,
            ),
            title: Text(
              'Home',
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
          accountListTile(),
          Divider(
            color: Colors.grey,
          ),
          ListTile(
            title: Text(
              '24/7 Help',
            ),
          ),
          InkWell(
            onTap: () {
              _callMe('984-0544-581');
            },
            child: ListTile(
              leading: Icon(
                Icons.call,
              ),
              title: Text(
                'Call: 984-0544-581',
              ),
            ),
          ),
          InkWell(
            onTap: () {
              _sendMail('naveencm@rocketmail.com');
            },
            child: ListTile(
              leading: Icon(
                Icons.mail,
              ),
              title: Text(
                'Email: naveencm@rocketmail.com',
              ),
            ),
          ),
          InkWell(
            onTap: () {
              print("Return policy");
            },
            child: ListTile(
              leading: Icon(
                Icons.assignment,
              ),
              title: Text(
                'Return Policy',
              ),
            ),
          ),
          Divider(
            color: Colors.grey,
          ),
          logOutButton()
        ],
      ),
    );
  }
}

_sendMail(String email) async {
  // Android and iOS
  final uri = 'mailto:$email?subject=&body=';
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    throw 'Could not launch $uri';
  }
}

_callMe(String phone) async {
  final uri = 'tel:$phone';
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    throw 'Could not launch $uri';
  }
}
