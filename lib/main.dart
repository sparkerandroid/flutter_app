import 'package:flutter/material.dart';

class AnimationWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AnimationState();
  }
}

class MyAnimationWidget extends AnimatedWidget {
  MyAnimationWidget({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    Animation<double> animation = listenable;
    return Center(
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Image.asset("images/test.png"),
        height: animation.value,
        width: animation.value,
      ),
    );
  }
}

class AnimationState extends State<AnimationWidget>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 10000));
    animation = Tween<double>(begin: 0, end: 300).animate(animationController);
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MyAnimationWidget(
      animation: animation,
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Image"),
          ),
          body: Stack(
            children: <Widget>[
              Center(
                child: CircularProgressIndicator(),
              ),
              Center(
                child: FadeInImage.assetNetwork(
                    placeholder: 'images/test.png', image: ''),
              )
            ],
          ),
        ));
  }
}

class MoocFlutterTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mooc Test"),
      ),
      body: Container(
        child: Image.network(
          "https://szimg.mukewang.com/5c7e6835087ef3d806000338-360-202.jpg",
          scale: 2.0,
          repeat: ImageRepeat.repeat,
        ),
        width: 400.0,
        height: 300.0,
        color: Colors.blue,
      ),
    );
  }
}

class ListViewTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListViewState();
  }
}

//Function(BuildContext context, int index)
class ListViewState extends State<ListViewTest> {
  List<Widget> _widgets = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      _widgets.add(Padding(
        padding: EdgeInsets.all(10.0),
        child: Text("Row $i"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView"),
      ),
      body: ListView.builder(
          itemCount: _widgets.length,
          itemBuilder: (BuildContext context, int index) {
            return _getRow(index);
          }),
    );
  }

  Widget _getRow(int index) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text("Row $index"),
      ),
      onTap: () {
        setState(() {
          _widgets.add(_getRow(_widgets.length + 1));
        });
      },
    );
  }
}
