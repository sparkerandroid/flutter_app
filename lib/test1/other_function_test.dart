import 'package:flutter/material.dart';
import 'package:flutter_app/SharePreferenceTest.dart';
import 'package:flutter_app/future/FutureBuilderTest.dart';
import 'package:flutter_app/http/HttpTest.dart';
import 'package:flutter_app/laucher_other_app/launcherApp.dart';
import 'package:flutter_app/layout/flutter_layout_page.dart';
import 'package:flutter_app/pick_image/PickImageTest.dart';

class OtherFunctionTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OtherFunctionState();
  }
}

class OtherFunctionState extends State<OtherFunctionTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("flutter相关练习"),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.blue),
        child: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                  child: Text("Future"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return FutureBuilderTest();
                    }));
                  }),
              RaisedButton(
                  child: Text("http"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return HttpSendPage();
                    }));
                  }),
              RaisedButton(
                  child: Text("launch_other_app"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LauncherTestPage();
                    }));
                  }),
              RaisedButton(
                  child: Text("layout"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LayoutTestPage();
                    }));
                  }),
              RaisedButton(
                  child: Text("pickImage"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PickImagePage();
                    }));
                  }),
              RaisedButton(
                  child: Text("SharePreference"),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return SharePreferenceTestPage();
                    }));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
