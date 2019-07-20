import 'package:flutter/material.dart';
import 'package:gesture_recognition/gesture_view.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingState();
  }

}

class _SettingState extends State<SettingPage> {

  List<int> result = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        title: Text("Setting Gesture"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 120,
              child: Center(
                child: Text(
                  "result: ${result.toString()}",
                  style: TextStyle(fontSize: 24,color: Colors.blue,fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Center(
              child: GestureView(
                immediatelyClear: true,
                size: MediaQuery.of(context).size.width,
                onPanUp: (List<int> items) {
                  setState(() {
                    result = items;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}