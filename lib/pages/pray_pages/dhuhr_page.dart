import 'package:flutter/material.dart';
import 'package:daily_muslim/components/appbar.dart';
import '../../components/properties.dart';

// ignore: must_be_immutable
class Dhuhr extends StatefulWidget {
  @override
  State<Dhuhr> createState() => _DhuhrState();
}

class _DhuhrState extends State<Dhuhr> {
  bool isArabic = true;
  void state() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarCustom(title: "Dhuhr", page: Pages.prayer, change: () {}),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: white),
        child: ListView(
            padding: EdgeInsets.only(right: 15, left: 15, top: 75),
            children: []),
      ),
    );
  }
}
