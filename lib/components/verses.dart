import 'package:daily_muslim/components/properties.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:shimmer/shimmer.dart';

import '../animations/bottom_animation.dart';

class DailyVerse extends StatefulWidget {
  DailyVerse({Key? key}) : super(key: key);

  @override
  State<DailyVerse> createState() => _DailyVerseState();
}

class _DailyVerseState extends State<DailyVerse> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: color.withAlpha(50),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(children: [
        user.displayName != null
            ? Text(
                'Assalamu alaikum, ${user.displayName!.split(' ').first}',
                style: getStyle(23, black, true),
              )
            : Text(
                'Assalamu alaikum',
                style: getStyle(23, black, true),
              ),
        Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Daily Quran Verse',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 20, color: color, fontWeight: FontWeight.bold),
            ),
            IconButton(
              icon: playAudio,
              onPressed: () {},
            ),
          ],
        ),
        dailyAyatAR.length != 0 && dailyAyatEN.length != 0
            ? Container(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      dailyAyatAR,
                      textAlign: TextAlign.center,
                      textDirection: ui.TextDirection.rtl,
                      style: TextStyle(fontSize: 22, fontFamily: 'Noore'),
                    ),
                  ),
                  Text(
                    dailyAyatEN,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(dailyAyatSurah)
                ]),
              )
            : Center(
                child: Shimmer.fromColors(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('assets/img/ico.png', height: 100),
                    WidgetAnimator(
                        child: Text("Loading Verse..!",
                            style: TextStyle(fontSize: 20)))
                  ],
                ),
                baseColor: color,
                highlightColor: const Color(0xfff9e9b8),
              ))
      ]),
    );
  }
}
