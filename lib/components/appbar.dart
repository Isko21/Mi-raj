import 'package:flutter/material.dart';
import 'package:daily_muslim/animations/bottom_animation.dart';
import 'package:daily_muslim/components/properties.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class AppBarCustom extends StatelessWidget with PreferredSizeWidget {
  String title;
  AppBarCustom({required this.title});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      title: WidgetAnimator(
          child: Text(title,
              style: TextStyle(
                  color: white, fontWeight: FontWeight.bold, fontSize: 31))),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class AppBarWithSetState extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final Function change;
  const AppBarWithSetState(
      {Key? key, required this.title, required this.change})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      iconTheme: IconThemeData(color: colorStr),
      title: Text(title, style: TextStyle(fontSize: 21, color: colorStr)),
      backgroundColor: white,
      actions: [
        IconButton(
            onPressed: () => showModalBottomSheet(
                backgroundColor: Color.fromARGB(255, 235, 231, 231),
                isScrollControlled: true,
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ),
                context: context,
                builder: (context) => buildSheet(change)),
            // ignore: deprecated_member_use
            icon: Icon(FontAwesomeIcons.ellipsisH),
            color: colorStr,
            iconSize: 15),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

Widget buildSheet(Function change) => Container(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
          margin: EdgeInsets.all(10),
          height: 5,
          width: 50,
          decoration: BoxDecoration(
              color: Colors.grey[500],
              borderRadius: BorderRadius.all(Radius.circular(8))),
        ),
        Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            initiallyExpanded: false,
            collapsedIconColor: colorStr,
            iconColor: colorStr,
            textColor: colorStr,
            title: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  "Language",
                  style:
                      TextStyle(color: colorStr, fontWeight: FontWeight.bold),
                )),
            children: [
              Card(
                elevation: 2.0,
                child: PopupMenuItem(
                  onTap: () => change(1),
                  child: ListTile(
                    leading: Text(
                      "1.",
                      style: TextStyle(color: colorStr),
                    ),
                    title: Text(
                      "Arabic",
                      style: TextStyle(color: colorStr),
                    ),
                    trailing: Text(
                      '🇸🇦',
                      style: TextStyle(color: colorStr),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 2.0,
                child: PopupMenuItem(
                  onTap: () => change(2),
                  child: ListTile(
                    leading: Text(
                      "2.",
                      style: TextStyle(color: colorStr),
                    ),
                    title: Text(
                      "Kyrgyz",
                      style: TextStyle(color: colorStr),
                    ),
                    trailing: Text(
                      '🇰🇬',
                      style: TextStyle(color: colorStr),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
