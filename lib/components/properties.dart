import 'package:daily_muslim/pages/pray_pages/pray_times.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:daily_muslim/pages/settings.dart';
import '../pages/home.dart';
import '../pages/pray_pages/jawshan_page.dart';
import '../pages/pray_pages/tasbihs_page.dart';
import '../pages/pray_pages/tools_page.dart';
import '../pages/pray_pages/quran_page.dart';

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
  TasbihsPage(),
  JawshanPage(),
  ToolsPage(),
  Settings()
];
String appBar = "Home";
int index = 0;

TextStyle getStyle(double size, Color c, bool isBold) {
  return TextStyle(
      color: c,
      fontSize: size,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal);
}

late String city;
late double lat, long;
late String country;
List<String> prayerTimes = [];
List<String> prayerNames = [];
