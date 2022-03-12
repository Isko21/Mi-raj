import 'package:flutter/material.dart';
import 'package:daily_muslim/animations/bottom_animation.dart';
import 'package:daily_muslim/components/properties.dart';

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
        return AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: colorStr,
            title: WidgetAnimator(
                child: Text(title,
                    style:
                        TextStyle(fontSize: 21, fontWeight: FontWeight.bold))));
      case Pages.home:
        return AppBar(
            centerTitle: true,
            backgroundColor: colorStr,
            elevation: 0,
            title: WidgetAnimator(
                child: Text(title,
                    style:
                        TextStyle(fontSize: 21, fontWeight: FontWeight.bold))));
      case Pages.settings:
        return AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: colorStr,
            title: WidgetAnimator(
                child: Text(title,
                    style:
                        TextStyle(fontSize: 21, fontWeight: FontWeight.bold))));
      default:
        return AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(title,
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
          backgroundColor: colorStr,
          actions: [
            PopupMenuButton(
              color: Color.fromARGB(249, 29, 43, 85),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Theme(
                      child: ExpansionTile(
                        collapsedIconColor: white,
                        iconColor: white,
                        textColor: white,
                        title: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "Language",
                              style: TextStyle(color: white),
                            )),
                        children: [
                          PopupMenuItem(
                              onTap: () => change(1),
                              child: ListTile(
                                  leading: Text(
                                    "1. ",
                                    style: TextStyle(color: white),
                                  ),
                                  title: Text(
                                    "Arabic",
                                    style: TextStyle(color: white),
                                  ))),
                          PopupMenuItem(
                              onTap: () => change(2),
                              child: ListTile(
                                  leading: Text(
                                    "2. ",
                                    style: TextStyle(color: white),
                                  ),
                                  title: Text(
                                    "Kyrgyz",
                                    style: TextStyle(color: white),
                                  ))),
                        ],
                      ),
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent)),
                ),
              ],
            ),
          ],
        );
    }
  }

  void languageChangeNotifier(BuildContext context, Pages page) {
    print(page.toString() + " is clicked");
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
