import 'package:flutter/material.dart';
import 'package:gesture_recognition_example/demo/setting_page.dart';
import 'package:gesture_recognition_example/demo/verify_page.dart';

void main() => runApp(MainPage());

class MainPage extends StatelessWidget {

  void _routeToPage(BuildContext context,Widget page) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context){
          return page;
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Gesture Recoginition"),),
        body: Builder(
            builder: (context) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    MaterialButton(
                        child: Container(
                          height: 60,
                          child: Center(
                            child: Text(
                              "Setting Gesture",
                              style: TextStyle(fontSize: 20,color: Colors.black),
                            ),
                          ),
                        ),
                        onPressed: () => _routeToPage(context,SettingPage())
                    ),
                    MaterialButton(
                        child: Container(
                          height: 60,
                          child: Center(
                            child: Text(
                              "Verification Gesture",
                              style: TextStyle(fontSize: 20,color: Colors.black),
                            ),
                          ),
                        ),
                        onPressed: () => _routeToPage(context,VerifyPage())
                    ),
                  ],
                ),
              );
            }
        ),
      ),
    );
  }
}
