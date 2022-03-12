import 'package:flutter/material.dart';
import 'package:daily_muslim/components/appbar.dart';
import '../../components/properties.dart';

class Isha extends StatefulWidget {
  @override
  State<Isha> createState() => _IshaState();
}

class _IshaState extends State<Isha> {
  void state() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBarCustom(title: "Isha", page: Pages.prayer, change: () {}),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: white),
          child: ListView(
            padding: EdgeInsets.only(right: 15, left: 15, top: 75),
            children: <Widget>[],
          ),
        ));
  }
}
