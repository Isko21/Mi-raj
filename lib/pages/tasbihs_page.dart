import 'package:daily_muslim/components/appbar.dart';
import 'package:daily_muslim/pages/quran_page.dart';
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
    return Scaffold(
      backgroundColor: black.withAlpha(50),
      appBar: AppBarCustom(title: 'Tasbih'),
      body: Container(
          padding: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: color.withAlpha(50),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                CoolButtonIcon(
                    image: 'fajr.png', title: 'Fajr', route: '/fajr'),
                CoolButtonIcon(
                    image: 'dhuhr.png', title: 'Dhuhr', route: '/dhuhr'),
                CoolButtonIcon(image: 'asr.png', title: 'Asr', route: '/asr'),
                CoolButtonIcon(
                    image: 'maghrib.png', title: 'Maghrib', route: '/maghrib'),
                CoolButtonIcon(
                    image: 'isha.png', title: 'Isha', route: '/isha'),
              ])),
    );
  }
}
