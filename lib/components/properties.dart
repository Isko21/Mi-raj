import 'package:flutter/material.dart';

Color black = Colors.black;
Color red = Colors.red;
Color white = Colors.white;
Padding kPadding = const Padding(padding: EdgeInsets.symmetric(horizontal: 20));
Color menu = const Color(0xFF262AAA);
Color color = const Color.fromRGBO(103, 118, 237, 1);
Color colorBg = const Color.fromRGBO(13, 34, 65, 1);
Color colorStr = const Color.fromRGBO(0, 78, 141, 1);

TextStyle getStyle(double size, Color c, bool isBold) {
  return TextStyle(
    color: c,
    fontSize: size,
    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
  );
}
// String dailyAyatAR = '';
// String dailyAyatEN = '';
// int dailyVerseDate = 0;
// String dailyVerseSurah = '';
// String dailyVerseUrl = '';
// String dailyAyatSurah = '';
//TODO

// late PrayerTimings timings;
// late int ayat;
// String language = 'ar';
// var user = FirebaseAuth.instance.currentUser;

