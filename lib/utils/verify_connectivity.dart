import 'dart:async';

import 'package:bigwigx/screens/offline_page.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class NetworkVerifier {
  
  Connectivity connectivity = new Connectivity();
  ConnectivityState connectivityState;
  bool isPageAdded = false;
  StreamSubscription<ConnectivityResult> subscription;
  Flushbar flushBar;

  void init(BuildContext context){
    subscription =
        connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
          if (result == ConnectivityResult.wifi ||
              result == ConnectivityResult.mobile) {
            if (connectivityState != null &&
                connectivityState != ConnectivityState.online)
              connectivityState = ConnectivityState.online;
            if (isPageAdded) Navigator.of(context).pop();
            isPageAdded = false;
          } else {
            connectivityState = ConnectivityState.offline;
            showOfflineScreen(context);
          }
        });
  }

  void showOfflineScreen(BuildContext context) {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new OfflinePage();
        },
        fullscreenDialog: true));
    isPageAdded = true;
  }
  void dispose() {
    subscription.cancel();
  }
}

enum ConnectivityState { offline, online }
