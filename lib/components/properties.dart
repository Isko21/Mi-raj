import 'package:adhan/adhan.dart';
import 'package:daily_muslim/pages/pray_times.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:daily_muslim/pages/settings.dart';
import 'package:intl/intl.dart';

import '../pages/home.dart';
import '../pages/jawshan_page.dart';
import '../pages/quran_page.dart';

String userName = user.displayName.toString();
String firstName = userName.split(' ')[0];
String userEmail = user.email.toString();
String userPhoto = user.photoURL.toString();
Color black = Colors.black;
Color red = Colors.red;
Color white = Colors.white;
Padding kPadding = Padding(padding: EdgeInsets.symmetric(horizontal: 20));
Color menu = Color(0xFF262AAA);
Color color = Color.fromRGBO(103, 118, 237, 1);
Color colorStr = Color.fromRGBO(0, 78, 141, 1);
int surahs = 114;
List<int> aya = List.filled(114, 0);
late String dailyAyatAR = '';
late String dailyAyatEN = '';
late int dailyVerseDate = 0;
late String dailyVerseSurah = '';
late String dailyVerseUrl = '';
String dailyAyatSurah = '';
late int ayat;
String language = 'ar';
var user = FirebaseAuth.instance.currentUser!;
enum Pages {
  home,
  prayer,
  tasbihs,
  jawshan,
  settings,
  tools,
  quran,
}
final pages = [
  HomePage(),
  QuranPage(),
  PrayTimes(),
  JawshanPage(),
  Settings(),
];

int jLang = 1;
int index = 0;
bool isArabic = true;
TextStyle getStyle(double size, Color c, bool isBold) {
  return TextStyle(
      color: c,
      fontSize: size,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal);
}

late String city = 'Loading';
late double lat, long;
late String country;
String getTime(DateTime dt) {
  return DateFormat('Hm').format(dt);
}

late PrayerTimes prayerTimes;
getPrayer() {
  var myCoordinates = Coordinates(lat, long);
  var params = CalculationMethod.muslim_world_league.getParameters();
  params.madhab = Madhab.hanafi;
  prayerTimes = PrayerTimes.today(myCoordinates, params);
}

int calcMethod = -1;
String calcMet = '';
int loop = 0;
