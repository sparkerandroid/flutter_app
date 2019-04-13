import 'package:flutter/material.dart';
import 'package:flutter_app/pick_image/PickImageTest.dart';
import 'package:url_launcher/url_launcher.dart';

class LauncherTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("启动第三方App"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            MaterialButton(
              onPressed: () {
                _launchUrl();
              },
              child: Text("启动浏览器"),
            ),
            MaterialButton(
              onPressed: () {
                _openMap();
              },
              child: Text("启动地图"),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PickImagePage();
        }));
      }),
    );
  }

  _launchUrl() async {
    const url = "http://www.devio.org/";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _openMap() async {
    //需要scheme
    const url = 'geo:52.32,4.917';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
