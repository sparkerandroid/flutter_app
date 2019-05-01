import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/http/HttpTest.dart';
import 'package:http/http.dart' as http;

class FutureBuilderTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FutureState();
  }
}

class FutureState extends State<FutureBuilderTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FutureBuilder的用法"),
      ),
      body: FutureBuilder<CommonModel>(
        future: doPost(),
        builder: (BuildContext context, AsyncSnapshot<CommonModel> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: CircularProgressIndicator(),
              );
            case ConnectionState.active:
              return Text("active");
            case ConnectionState.done:
              if (snapshot.hasError) {
                return Text("hasError");
              } else {
                return Column(
                  children: <Widget>[
                    Text("${snapshot.data.url}"),
                    Text("${snapshot.data.title}"),
                  ],
                );
              }
              break;
            case ConnectionState.none:
              return Text("none");
          }
        },
      ),
    );
  }

  Future<CommonModel> doPost() async {
    final response = await http
        .get("http://www.devio.org/io/flutter_app/json/test_common_model.json");
    final result = json.decode(Utf8Decoder().convert(response.bodyBytes));
//    final result = json.decode(response.body);//这种方式汉字会出现乱码
    return CommonModel.fromJson(result);
  }
}
