import 'package:flutter/material.dart';

import '../../components/appbar.dart';
import '../../components/properties.dart';

class ComingSoon extends StatelessWidget {
  final String title;
  const ComingSoon({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorStr,
        appBar: AppBarCustom(change: () {}, title: title, page: Pages.settings),
        extendBodyBehindAppBar: true,
        body: Container(
          child: SafeArea(
              child: Center(
            child: Text(
              "Coming Soon",
              style: TextStyle(fontSize: 35, color: white),
            ),
          )),
        ));
  }
}
