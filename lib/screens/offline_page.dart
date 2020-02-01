import 'package:flutter/material.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';


class OfflinePage extends StatefulWidget {

  @override
  _OfflinePageState createState() => _OfflinePageState();
}

class _OfflinePageState extends State<OfflinePage> {

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.removeAll();
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
    return true;
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
                    Icons.signal_wifi_off,
                    color: Colors.white,
                    size: 100.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'You are not connected to the internet.',
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
    );
  }
}
