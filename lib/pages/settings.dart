import 'package:daily_muslim/components/properties.dart';
import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: color.withAlpha(50),
      ),
      child: ListView(
        padding: EdgeInsets.only(right: 15, left: 15, top: 75),
        children: <Widget>[],
      ),
    );
  }
}
