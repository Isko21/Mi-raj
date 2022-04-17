import 'package:daily_muslim/components/appbar.dart';
import 'package:flutter/material.dart';

import '../../components/properties.dart';

class ComingSoon extends StatefulWidget {
  final String title;
  ComingSoon({required this.title});

  @override
  State<ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black.withAlpha(50),
        extendBodyBehindAppBar: true,
        appBar: AppBarCustom(title: widget.title),
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: color.withAlpha(50),
            child: Center(child: Text(name))));
  }

  String name = 'Warsawa';
}
