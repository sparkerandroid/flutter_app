import 'package:flutter/material.dart';
import 'package:flutter_app/model/common_model.dart';
import 'package:flutter_app/widget/webview_widget.dart';

class LocalNavWidget extends StatelessWidget {
  final List<CommonModel> localNavList;

  const LocalNavWidget({Key key, this.localNavList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(6.0))),
      child: Padding(
        padding: EdgeInsets.all(7.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _items(context),
        ),
      ),
    );
  }

  _items(BuildContext context) {
    if (localNavList == null) return null;
    return localNavList.map<Widget>((e) => _item(e, context)).toList();
  }

  _item(CommonModel e, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WebView(
            url: e.url,
            hideAppBar: e.hideAppBar,
            statusBarColor: e.statusBarColor,
            backForbid: false,
          );
        }));
      },
      child: Column(
        children: <Widget>[
          Image.network(
            e.icon,
            width: 32,
            height: 32,
          ),
          Text(
            e.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
