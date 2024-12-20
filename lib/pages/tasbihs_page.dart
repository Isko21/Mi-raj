import 'package:muslim_today/components/appbar.dart';
import 'package:muslim_today/pages/quran_page.dart';
import 'package:flutter/material.dart';
import 'package:muslim_today/components/properties.dart';

class TasbihsPage extends StatefulWidget {
  const TasbihsPage({Key? key}) : super(key: key);

  @override
  State<TasbihsPage> createState() => _TasbihsPageState();
}

class _TasbihsPageState extends State<TasbihsPage> {
  bool isArabic = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      appBar: AppBarCustom(title: "Mi'raj", elevation: 0),
      body: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: color.withAlpha(50),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            CoolButtonIcon(image: 'fajr.png', title: 'Fajr', route: '/fajr'),
            CoolButtonIcon(image: 'dhuhr.png', title: 'Dhuhr', route: '/dhuhr'),
            CoolButtonIcon(image: 'asr.png', title: 'Asr', route: '/asr'),
            CoolButtonIcon(
                image: 'maghrib.png', title: 'Maghrib', route: '/maghrib'),
            CoolButtonIcon(image: 'isha.png', title: 'Isha', route: '/isha'),
          ],
        ),
      ),
    );
  }
}
