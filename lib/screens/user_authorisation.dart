import 'dart:convert';

import 'package:bigwigx/locators/locators.dart';
import 'package:bigwigx/models/login_data.dart';
import 'package:bigwigx/models/user.dart';
import 'package:bigwigx/screens/home_screen.dart';
import 'package:bigwigx/services/storage_service.dart';
import 'package:bigwigx/services/user_service.dart';
import 'package:bigwigx/utils/verify_connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserAuthorisation extends StatefulWidget {
  final int index;
  UserAuthorisation(this.index);
  @override
  State<StatefulWidget> createState() {
    return _UserAuthorisationState();
  }
}

class _UserAuthorisationState extends State<UserAuthorisation>
    with SingleTickerProviderStateMixin {
  final Map<String, dynamic> _formData = {'email': null, 'password': null};
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyForLogin = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _passwordTextController = TextEditingController();
  final UnderlineInputBorder _underlineInputBorder =
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.black54));
  UserService _userService = locator<UserService>();
  StorageService _storageService = locator<StorageService>();
  bool _isLoader = false;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(initialIndex: widget.index, vsync: this, length: 2);
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
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550.0 ? 500.0 : deviceWidth * 0.95;
    return MaterialApp(
      color: Colors.blue,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.white,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            centerTitle: false,
            backgroundColor: Colors.blue,
            bottom: TabBar(
              indicatorWeight: 4.0,
              controller: _tabController,
              indicatorColor: Colors.blue,
              tabs: [
                Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "SIGN IN",
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                Text(
                  "CREATE ACCOUNT",
                  style: TextStyle(fontSize: 13),
                )
              ],
            ),
            title: Text(
              'Bigwigx',
              style: TextStyle(fontFamily: 'Quicksand',fontWeight: FontWeight.w500, fontSize: 35),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              _renderLogin(targetWidth),
              _renderSignup(targetWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderLogin(double targetWidth) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Container(
            width: targetWidth,
            child: Form(
              key: _formKeyForLogin,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30.0,
                  ),
                  _buildEmailTextField(),
                  SizedBox(
                    height: 45.0,
                  ),
                  _buildPasswordTextField(false),
                  SizedBox(
                    height: 35.0,
                  ),
                  _isLoader
                      ? CircularProgressIndicator(backgroundColor: Colors.blue)
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(15),
                          child: FlatButton(
                            textColor: Colors.white,
                            color: Colors.deepOrange,
                            child: Text(
                              'SIGN IN',
                              style: TextStyle(fontSize: 12.0),
                            ),
                            onPressed: () => _loginUser(),
                          )),
                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      print("Forget password clicked");
                    },
                    child: Text(
                      'FORGOT YOUR PASSWORD?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.green,
                          fontSize: 14.0),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
  }

  Widget _renderSignup(double targetWidth) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Container(
          width: targetWidth,
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                _buildEmailTextField(),
                SizedBox(
                  height: 45.0,
                ),
                _buildPasswordTextField(true),
                SizedBox(
                  height: 45.0,
                ),
                _buildPasswordConfirmTextField(),
                SizedBox(
                  height: 45.0,
                ),
                _isLoader
                    ? CircularProgressIndicator(backgroundColor: Colors.green)
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(15),
                        child: FlatButton(
                          textColor: Colors.white,
                          color: Colors.deepOrange,
                          child: Text('CREATE ACCOUNT',
                              style: TextStyle(fontSize: 12.0)),
                          onPressed: () => _submitForm(),
                        )),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: TextFormField(
          decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.grey),
              labelText: 'Email',
              contentPadding: EdgeInsets.all(0.0),
              enabledBorder: _underlineInputBorder),
          keyboardType: TextInputType.emailAddress,
          validator: (String value) {
            if (value.isEmpty ||
                !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                    .hasMatch(value)) {
              return 'Please enter a valid email';
            }
            return null;
          },
          onSaved: (String value) {
            _formData['email'] = value;
          },
        ));
  }

  Widget _buildPasswordTextField([bool isLimitCharacter = false]) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15.0),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: isLimitCharacter
                ? 'Password (Atleast 6 Characters)'
                : 'Password',
            labelStyle: TextStyle(color: Colors.grey),
            contentPadding: EdgeInsets.all(0.0),
            enabledBorder: _underlineInputBorder),
        obscureText: true,
        controller: _passwordTextController,
        validator: (String value) {
          if (value.isEmpty || value.length < 8 ) {
            return 'Password must be atleast 8 characters';
          }
          return null;
        },
        onSaved: (String value) {
          _formData['password'] = value;
        },
      ),
    );
  }

  Widget _buildPasswordConfirmTextField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Theme(
          data: ThemeData(hintColor: Colors.grey.shade700),
          child: TextFormField(
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.grey),
              labelText: 'Confirm Password',
              enabledBorder: _underlineInputBorder,
              contentPadding: EdgeInsets.all(0.0),
            ),
            obscureText: true,
            validator: (String value) {
              if (_passwordTextController.text != value) {
                return 'Passwords do not match.';
              }
              return null;
            },
          ),
        ));
  }


  void _loginUser() {
    setState(() {
      _isLoader = true;
    });
    if (!_formKeyForLogin.currentState.validate()) {
      setState(() {
        _isLoader = false;
      });
      return;
    }
    _formKeyForLogin.currentState.save();
    LoginData data = LoginData(email: _formData['email'],
        password: _formData['password']);
     _userService.doLogin(data).then((Response onValue) {
      if (onValue.statusCode == 200) {
        _storageService.setToken(json.decode(onValue.body)['token']);
        _storageService.setEmail(_formData['email']);
        _userService.getUser().then((User user){
          if(user!=null){
            _storageService.setUsername(user.username);
            MaterialPageRoute route = MaterialPageRoute(
                builder: (context) => HomeScreen());
            Navigator.of(context).push(route);
          }
        });
      }else if(onValue.statusCode == 422){
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Email is invalid'),
          duration: Duration(seconds: 1),
        ));
      }else if(onValue.statusCode == 401){
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(json.decode(onValue.body)['error']['message']),
          duration: Duration(seconds: 1),
        ));
      }else{
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Login failed"),
          duration: Duration(seconds: 1),
        ));
      }
    });
    setState(() {
      _isLoader = false;
    });
  }


  void _submitForm() async {
    setState(() {
      _isLoader = true;
    });
    if (!_formKey.currentState.validate()) {
      setState(() {
        _isLoader = false;
      });
      return;
    }
    _formKey.currentState.save();
    final Map<String, dynamic> authData = {
      "spree_user": {
        'email': _formData['email'],
        'password': _formData['password'],
      }
    };


    setState(() {
      _isLoader = false;
    });
  }

  Widget _alertDialog(String boxTitle, String message, BuildContext context) {
    return AlertDialog(
      title: Text(boxTitle),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          child: Text('Later',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.green.shade300)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        FlatButton(
          child: Text('Sign In',
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.green.shade300)),
          onPressed: () {
            Navigator.pop(context);
            MaterialPageRoute route =
                MaterialPageRoute(builder: (context) => UserAuthorisation(0));
            Navigator.push(context, route);
          },
        )
      ],
    );
  }
}
