import 'package:flutter/material.dart';
import 'package:daily_muslim/components/appbar.dart';
import 'package:daily_muslim/components/properties.dart';

class Asr extends StatefulWidget {
  @override
  State<Asr> createState() => _AsrState();
}

class _AsrState extends State<Asr> {
  void state() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarCustom(title: "Asr", page: Pages.prayer, change: () {}),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: white,
        ),
        child: ListView(
          padding: EdgeInsets.only(right: 15, left: 15, top: 75),
          children: <Widget>[],
        ),
      ),
    );
  }
}
