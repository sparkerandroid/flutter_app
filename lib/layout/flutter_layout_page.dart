import 'package:flutter/material.dart';

class LayoutTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("flutter布局"),
      ),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipOval(
                child: SizedBox(
                  //SizedBox不是必须的，因为Image也可以自己设置
                  height: 100,
                  width: 100,
                  child: Image.network("http://www.devio.org/img/avatar.png"),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Opacity(
                      opacity: 0.6,
                      child:
                          Image.network("http://www.devio.org/img/avatar.png"),
                    )),
              ),
              Container(
                //画出一个圆
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(36)),
              )
            ],
          ),
          Container(
              height: 150,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: PhysicalModel(
                  //将布局显示成不同形状的组件
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  clipBehavior: Clip.antiAlias,
                  child: PageView(
                    children: <Widget>[
                      Container(
                        color: Colors.blue,
                        child: Text("page1"),
                      ),
                      Container(
                        color: Colors.red,
                        child: Text("page2"),
                      ),
                      Container(
                        color: Colors.yellowAccent,
                        child: Text("page3"),
                      ),
                    ],
                  ),
                ),
              )),
          Column(
            children: <Widget>[
              //expand也可以达到填充整个布局效果
              FractionallySizedBox(
                //约束布局可以撑多大
                widthFactor: 1,
                child: Container(
                  decoration: BoxDecoration(color: Colors.cyan),
                  child: Text("宽度充满屏幕"),
                ),
              ),
            ],
          ),
          Stack(
            children: <Widget>[
              Image.network(
                "http://www.devio.org/img/avatar.png",
                width: 100,
                height: 100,
              ),
              Positioned(
                left: 0,
                bottom: 0,
                child: Image.network(
                  "http://www.devio.org/img/avatar.png",
                  width: 40,
                  height: 40,
                ),
              )
            ],
          ),
          Wrap(
            //从左到右的布局，会自动换行
            spacing: 10, //水平间距
            runSpacing: 10, //垂直间距
            children: <Widget>[
              _getChip(1),
              _getChip(2),
              _getChip(3),
              _getChip(4),
              _getChip(5),
              _getChip(6),
            ],
          ),
        ],
      ),
    );
  }
}

Chip _getChip(int index) {
  return Chip(
    label: Text("chip$index"),
    avatar: CircleAvatar(
      child: Image.network(
        "http://www.devio.org/img/avatar.png",
      ),
    ),
  );
}
