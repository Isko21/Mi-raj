import 'package:flutter/material.dart';
import 'package:daily_muslim/components/properties.dart';

class TasbihsPage extends StatefulWidget {
  TasbihsPage({Key? key}) : super(key: key);

  @override
  State<TasbihsPage> createState() => _TasbihsPageState();
}

class _TasbihsPageState extends State<TasbihsPage> {
  bool isArabic = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: white,
        ),
        child: SafeArea(
          child: ListView(
              padding: EdgeInsets.only(right: 15, left: 15, top: 75),
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/fajr');
                  },
                  child: Text("Fajr"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/dhuhr');
                  },
                  child: Text("Dhuhr"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/asr');
                  },
                  child: Text("Asr"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/maghrib');
                  },
                  child: Text("Maghrib"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/isha');
                  },
                  child: Text("Isha"),
                ),
              ]),
        ));
  }
}
