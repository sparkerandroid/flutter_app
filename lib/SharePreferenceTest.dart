import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 用到了shared_preferences
// 复杂Json解析推荐在线json转dart:http://www.devio.org/io/tools/json-to-dart/
class SharePreferenceTestPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SharePreferState();
  }
}

class SharePreferState extends State<SharePreferenceTestPage> {
  var saveStr = "";
  var retriveStr = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SharePreference插件基本用法"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                _saveValue();
              },
              child: Text("SP存值"),
            ),
            RaisedButton(
              onPressed: () {
                _getValue();
              },
              child: Text("SP取值"),
            ),
            Text(saveStr),
            Text(retriveStr)
          ],
        ),
      ),
    );
  }

  _saveValue() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    await instance.setString("save", "SharePreference插件基本用法");
    setState(() {
      saveStr = "SharePreference插件基本用法";
    });
  }

  _getValue() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    setState(() {
      retriveStr = instance.getString("save");
    });
  }
}
