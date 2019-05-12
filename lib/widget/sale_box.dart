import 'package:flutter/material.dart';
import 'package:flutter_app/model/common_model.dart';
import 'package:flutter_app/model/sales_box_model.dart';

class SalesBox extends StatelessWidget {
  final SalesBoxModel salesBoxModel;

  const SalesBox({Key key, this.salesBoxModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _saleBoxItems(salesBoxModel),
    );
  }

  List<Widget> _saleBoxItems(SalesBoxModel salesBoxModel) {
    List<Widget> widgets = [];
    if (salesBoxModel == null) {
      return widgets;
    }
    widgets.add(_doubleItems(
        salesBoxModel.bigCard1, salesBoxModel.bigCard2, true, true));
    widgets.add(_doubleItems(
        salesBoxModel.smallCard1, salesBoxModel.smallCard2, false, false));
    widgets.add(_doubleItems(
        salesBoxModel.smallCard3, salesBoxModel.smallCard4, false, false));
    return widgets;
  }

  Widget _doubleItems(
      CommonModel leftCard, CommonModel rightCard, bool isBig, bool isLeft) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _item(leftCard, isBig, isLeft, false),
        ),
        Expanded(
          child: _item(rightCard, isBig, isLeft, true),
        )
      ],
    );
  }

  Widget _item(CommonModel card, bool isBig, bool isLeft, bool isLast) {
    BorderSide borderSide = BorderSide(width: 1, color: Color(0xfff2f2f2));
    return Container(
      decoration: BoxDecoration(
          border: Border(
              left: isLeft ? BorderSide.none : borderSide,
              bottom: isLast ? BorderSide.none : borderSide)),
      child: Image.network(
        card.icon,
        fit: BoxFit.fill,
        height: isBig ? 128 : 64,
      ),
    );
  }
}
