import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpSendPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HttpSendState();
  }
}

class HttpSendState extends State<HttpSendPage> {
  String showResult = "";

  Future<CommonModel> doPost() async {
    final response = await http
        .get("http://www.devio.org/io/flutter_app/json/test_common_model.json");
    final result = json.decode(response.body);
    return CommonModel.fromJson(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("http网络编程"),
      ),
      body: GestureDetector(
          onTap: () {
            doPost().then((CommonModel value) {
              setState(() {
                showResult = value.title + "----" + value.icon;
              });
            });
          },
          child: Center(
              child: Padding(
            padding: EdgeInsets.all(60),
            child: Column(
              children: <Widget>[
                Text(
                  "点我",
                  style: TextStyle(color: Colors.blue),
                ),
                Text(
                  showResult,
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
          ))),
    );
  }
}

class CommonModel {
  final String icon;
  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;

  CommonModel(
      {this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar});

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
        icon: json["icon"],
        title: json["title"],
        url: json["url"],
        statusBarColor: json["statusBarColor"],
        hideAppBar: json["hideAppBar"]);
  }
}
