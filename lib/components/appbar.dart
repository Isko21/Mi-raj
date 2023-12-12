import 'package:flutter/material.dart';
import 'package:muslim_today/components/properties.dart';

// ignore: must_be_immutable
class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  String title;
  double elevation;
  AppBarCustom({Key? key, required this.elevation, required this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      title: Text(title,
          style: TextStyle(
              color: white, fontWeight: FontWeight.bold, fontSize: 31)),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
