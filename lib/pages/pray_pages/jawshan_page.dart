import 'package:flutter/material.dart';
import 'package:daily_muslim/components/properties.dart';

class JawshanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: colorStr,
      ),
      child: ListView(
        padding: EdgeInsets.only(right: 15, left: 15, top: 75),
        children: <Widget>[],
      ),
    );
  }
}
