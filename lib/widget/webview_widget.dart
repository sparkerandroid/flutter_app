import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const CATCH_URLS = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5'];

class WebView extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  const WebView(
      {Key key,
      this.url,
      this.statusBarColor,
      this.title,
      this.hideAppBar,
      this.backForbid})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MyWebViewState();
  }
}

class MyWebViewState extends State<WebView> {
  var webViewPlugin = FlutterWebviewPlugin();
  StreamSubscription<String> _urlChange;
  StreamSubscription<WebViewHttpError> _httpError;
  StreamSubscription<WebViewStateChanged> _stateChanged;
  bool exiting = false;

  @override
  void initState() {
    super.initState();
    webViewPlugin.close(); //防止页面重新打开
    _urlChange = webViewPlugin.onUrlChanged.listen((String data) {});
    _httpError =
        webViewPlugin.onHttpError.listen((WebViewHttpError errorInfo) {});
    _stateChanged =
        webViewPlugin.onStateChanged.listen((WebViewStateChanged change) {
      switch (change.type) {
        case WebViewState.startLoad:
          if (_isToMain(change.url) && !exiting) {
            if (widget.backForbid) {
              webViewPlugin.launch(change.url);
            } else {
              exiting = true;
              Navigator.pop(context);
            }
          }
          break;
        default:
          break;
      }
    });
    webViewPlugin.launch(widget.url);
  }

  @override
  void dispose() {
    super.dispose();
    _urlChange.cancel();
    _httpError.cancel();
    _stateChanged.cancel();
    webViewPlugin.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Expanded(
          child: WebviewScaffold(
        url: widget.url ?? "",
        withZoom: true,
        withLocalStorage: true,
        //hidden与initialChild配合，在url未加载出来之前，显示什么
        hidden: true,
        initialChild: Container(
          color: Colors.white,
          child: Center(
            child: Text("loading......"),
          ),
        ),
      )),
    );
  }

  bool _isToMain(String curUrl) {
    for (var url in CATCH_URLS) {
      if (curUrl?.endsWith(url) ?? false) {
        return true;
      }
    }
    return false;
  }

  Widget _appBar() {
    if (widget.hideAppBar ?? false) {
      return Container(
        height: 60,
        color: Color(int.parse(widget.statusBarColor ?? 'ffffff')),
      );
    }
    return FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: <Widget>[
            GestureDetector(
                onTap: () {},
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.close,
                    size: 26,
                  ),
                )),
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(widget.title ?? ""),
              ),
            )
          ],
        ));
  }
}
