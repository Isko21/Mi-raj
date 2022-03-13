import 'package:flutter/material.dart';
import 'package:daily_muslim/animations/bottom_animation.dart';
import 'package:daily_muslim/components/properties.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class AppBarCustom extends StatelessWidget with PreferredSizeWidget {
  String title;
  Pages page;
  Function change;
  AppBarCustom({required this.change, required this.page, required this.title});
  @override
  Widget build(BuildContext context) {
    switch (page) {
      case Pages.quran:
        return Theme(
          data: ThemeData(primaryIconTheme: IconThemeData(color: colorStr)),
          child: AppBar(
              iconTheme: IconThemeData(color: colorStr),
              centerTitle: true,
              backgroundColor: colorStr,
              title: WidgetAnimator(
                  child: Text(title,
                      style: TextStyle(
                          color: colorStr,
                          fontSize: 21,
                          fontWeight: FontWeight.bold)))),
        );
      case Pages.home:
        return AppBar(
            iconTheme: IconThemeData(color: colorStr),
            centerTitle: true,
            backgroundColor: white,
            title: WidgetAnimator(
                child: Text(title,
                    style: TextStyle(
                      color: colorStr,
                      fontSize: 21,
                    ))));
      case Pages.settings:
        return AppBar(
            centerTitle: true,
            iconTheme: IconThemeData(color: colorStr),
            backgroundColor: white,
            title: WidgetAnimator(
                child: Text(title,
                    style: TextStyle(
                        color: colorStr,
                        fontSize: 21,
                        fontWeight: FontWeight.bold))));
      default:
        return AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: colorStr),
          title: Text(title,
              style: TextStyle(
                  fontSize: 21, color: colorStr, fontWeight: FontWeight.bold)),
          backgroundColor: white,
          actions: [
            IconButton(
                onPressed: () => showModalBottomSheet(
                    context: context, builder: (context) => buildSheet()),
                icon: Icon(FontAwesomeIcons.ellipsisH),
                color: colorStr,
                iconSize: 15),
          ],
        );
    }
  }

  Widget buildSheet() => Column(mainAxisSize: MainAxisSize.min, children: [
        ExpansionTile(
          collapsedIconColor: colorStr,
          iconColor: colorStr,
          textColor: colorStr,
          title: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                "Language",
                style: TextStyle(color: colorStr, fontWeight: FontWeight.bold),
              )),
          children: [
            PopupMenuItem(
                onTap: () => change(1),
                child: ListTile(
                    leading: Text(
                      "1. ",
                      style: TextStyle(color: colorStr),
                    ),
                    title: Text(
                      "Arabic",
                      style: TextStyle(color: colorStr),
                    ))),
            PopupMenuItem(
                onTap: () => change(2),
                child: ListTile(
                    leading: Text(
                      "2. ",
                      style: TextStyle(color: colorStr),
                    ),
                    title: Text(
                      "Kyrgyz",
                      style: TextStyle(color: colorStr),
                    ))),
          ],
        ),
      ]);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
