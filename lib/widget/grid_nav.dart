import 'package:flutter/material.dart';
import 'package:flutter_app/model/grid_nav_model.dart';

class GridNav extends StatelessWidget {
  final GridNavModel gridNavModel;
  final String name;

  const GridNav({Key key, this.gridNavModel, this.name = "json"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(name);
  }
}
