import 'package:flutter/material.dart';
import 'package:flutter_app/model/common_model.dart';
import 'package:flutter_app/model/grid_nav_model.dart';

class GridNav extends StatelessWidget {
  final GridNavModel gridNavModel;

  const GridNav({Key key, this.gridNavModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      //为布局的整体设置四周的圆角
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      child: Column(
        children: _gridItems(gridNavModel),
      ),
    );
  }

  _gridItems(GridNavModel gridModel) {
    List<Widget> widgets = [];
    if (gridModel == null) {
      return widgets;
    }
    if (gridModel.hotel != null) {
      widgets.add(_gridItem(gridModel.hotel));
    }
    if (gridModel.flight != null) {
      widgets.add(_gridItem(gridModel.flight));
    }
    if (gridModel.travel != null) {
      widgets.add(_gridItem(gridModel.travel));
    }
    return widgets;
  }

  _gridItem(GridNavItem navItem) {
    return Container(
      height: 88,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(int.parse('0xff' + navItem.startColor)),
        Color(int.parse('0xff' + navItem.endColor))
      ])),
      child: Row(children: <Widget>[
        Expanded(
          child: _mainItem(navItem.mainItem),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Expanded(child: _item(navItem.item1, true)), //垂直方向充满父布局
              Expanded(child: _item(navItem.item2, false))
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: <Widget>[
              Expanded(child: _item(navItem.item3, true)), //垂直方向充满父布局
              Expanded(child: _item(navItem.item4, false))
            ],
          ),
        )
      ]),
    );
  }

  _mainItem(CommonModel mainItem) {
    return Container(
      child: GestureDetector(
        onTap: () {},
        child: Stack(
          children: <Widget>[
            Image.network(
              mainItem.icon,
              height: 88,
              width: 121,
              alignment: AlignmentDirectional.bottomEnd,
            ),
            Center(
                child: Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Text(
                mainItem.title,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            )),
          ],
        ),
      ),
    );
  }

  _item(CommonModel item, bool isFirst) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      //水平方向充满父布局
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                left: borderSide,
                bottom: isFirst ? borderSide : BorderSide.none)),
        child: Center(
          child: Text(
            item.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
