import 'package:adhan/adhan.dart';
import 'package:muslim_today/pages/pray_times.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muslim_today/pages/settings.dart';
import 'package:intl/intl.dart';

import '../pages/home.dart';
import '../pages/jawshan_page.dart';
import '../pages/quran_page.dart';

bool isGuest = false;
String userName = isGuest ? 'Guest' : user.displayName.toString();
String firstName = isGuest ? '' : userName.split(' ')[0];
String userEmail = isGuest ? '' : user.email.toString();
String userPhoto = isGuest ? '' : user.photoURL.toString();
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
  var params;
  switch (calcMethod) {
    case 0:
      params = CalculationMethod.egyptian.getParameters();
      break;
    case 1:
      params = CalculationMethod.karachi.getParameters();
      break;
    case 2:
      params = CalculationMethod.kuwait.getParameters();
      break;
    case 3:
      params = CalculationMethod.moon_sighting_committee.getParameters();
      break;
    case 4:
      params = CalculationMethod.muslim_world_league.getParameters();
      break;
    case 5:
      params = CalculationMethod.north_america.getParameters();
      break;
    case 6:
      params = CalculationMethod.qatar.getParameters();
      break;
    case 7:
      params = CalculationMethod.singapore.getParameters();
      break;
    case 8:
      params = CalculationMethod.tehran.getParameters();
      break;
    case 9:
      params = CalculationMethod.turkey.getParameters();
      break;
    case 10:
      params = CalculationMethod.umm_al_qura.getParameters();
      break;
    default:
      params = CalculationMethod.muslim_world_league.getParameters();
  }
  var myCoordinates = Coordinates(lat, long);
  switch (asrMethod) {
    case 0:
      params.madhab = Madhab.hanafi;
      break;
    case 1:
      params.madhab = Madhab.shafi;
      break;
  }
  prayerTimes = PrayerTimes.today(myCoordinates, params);
}

int calcMethod = 4;
String calcMet = '';
int asrMethod = 0;
String asrMet = '';
int loop = 0;
