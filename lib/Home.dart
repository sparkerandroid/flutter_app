import 'package:flutter/material.dart';
import 'package:flutter_app/laucher_other_app/launcherApp.dart';
import 'HomePage.dart';
import 'SearchPage.dart';
import 'TravelPage.dart';
import 'MyPage.dart';

void main() {
  runApp(MainPage());
}

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> {
  final PageController _controller = PageController(initialPage: 0);
  int _curPageIndex = 0;
  final Color _defaultColor = Colors.black45;
  final Color _activeColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PageView(
          controller: _controller,
          children: <Widget>[HomePage(), SearchPage(), TravelPage(), MyPage()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _curPageIndex,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: _defaultColor,
                ),
                activeIcon: Icon(
                  Icons.home,
                  color: _activeColor,
                ),
                title: Text(
                  "首页",
                  style: TextStyle(
                      color: _curPageIndex == 0 ? _activeColor : _defaultColor),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  color: _defaultColor,
                ),
                activeIcon: Icon(
                  Icons.search,
                  color: _activeColor,
                ),
                title: Text(
                  "搜索",
                  style: TextStyle(
                      color: _curPageIndex == 1 ? _activeColor : _defaultColor),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.train,
                  color: _defaultColor,
                ),
                activeIcon: Icon(
                  Icons.train,
                  color: _activeColor,
                ),
                title: Text(
                  "旅拍",
                  style: TextStyle(
                      color: _curPageIndex == 2 ? _activeColor : _defaultColor),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: _defaultColor,
                ),
                activeIcon: Icon(
                  Icons.person,
                  color: _activeColor,
                ),
                title: Text(
                  "我的",
                  style: TextStyle(
                      color: _curPageIndex == 3 ? _activeColor : _defaultColor),
                )),
          ],
          onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              _curPageIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
