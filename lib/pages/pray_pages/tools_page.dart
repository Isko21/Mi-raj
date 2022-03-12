import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:daily_muslim/components/properties.dart';
import 'package:daily_muslim/pages/sub_pages/coming_soon.dart';
import 'package:daily_muslim/pages/sub_pages/missed_prays.dart';

class ToolsPage extends StatefulWidget {
  ToolsPage({Key? key}) : super(key: key);

  @override
  State<ToolsPage> createState() => _ToolsState();
}

class _ToolsState extends State<ToolsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: white),
      child: SafeArea(
        child: ListView(padding: EdgeInsets.all(20), children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Tool(
                  title: "Missed prays",
                  icon: Icon(FontAwesomeIcons.mosque),
                  index: 0),
              Tool(
                  title: "Qibla",
                  icon: Icon(FontAwesomeIcons.compass),
                  index: 1),
              Tool(title: "Zakat", icon: Icon(FontAwesomeIcons.coins), index: 2)
            ],
          )
        ]),
      ),
    );
  }
}

class Tool extends StatelessWidget {
  final String title;
  final Icon icon;
  final int index;
  const Tool(
      {Key? key, required this.icon, required this.title, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        switch (index) {
          case 0:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => new MissedPrays()));
            break;
          case 1:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new ComingSoon(title: "Qibla")));
            break;
          case 2:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => new ComingSoon(title: "Zakat")));
            break;
        }
      },
      child: Container(
        width: width / 3.5,
        height: height / 7,
        decoration: BoxDecoration(
            color: white.withAlpha(200),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon.icon,
                color: colorStr,
                size: 50,
              ),
              AutoSizeText(
                title,
                maxLines: 1,
                style: TextStyle(color: colorStr, fontSize: 20),
              ),
            ]),
      ),
    );
  }
}
