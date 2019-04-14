import 'package:flutter/material.dart';
import 'package:flutter_app/future/FutureBuilderTest.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("搜索"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FutureBuilderTest();
          }));
        },
        child: Text("futureBuilder"),
      ),
    );
  }
}
