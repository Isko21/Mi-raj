// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:muslim_today/components/properties.dart';
import 'package:muslim_today/components/shared_pref.dart';
import 'package:http/http.dart' as http;

import '../components/appbar.dart';
import '../components/header.dart';
import '../components/verses.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dailyAyatAR = '';
  String dailyAyatEN = '';
  String dailyAyatSurah = '';
  int dailyVerseDate = 0;
  String dailyVerseUrl = '';
  String city = '';
  String country = '';
  @override
  void initState() {
    super.initState();
    String dailyAyatAR = AllUserData.getVerse('ar');
    String dailyAyatEN = AllUserData.getVerse('en');
    String dailyAyatSurah = AllUserData.getSurahName();
    int dailyVerseDate = AllUserData.getVerseDate();
    String dailyVerseUrl = AllUserData.getVerseAudio();
    String city = AllUserData.getLocationData('city');
    String country = AllUserData.getLocationData('country');
    if (dailyVerseDate != DateTime.now().day) {
      Random random = Random();
      int ayat = random.nextInt(6236);
      getRandomAyat(ayat);
    }
  }

  void getRandomAyat(int ayat) async {
    var endPointEN =
        Uri.parse("http://api.alquran.cloud/v1/ayah/$ayat/en.asad");
    var responseEN = await http.get(endPointEN);
    var bodyEN = jsonDecode(responseEN.body);
    var responseAR = await http
        .get(Uri.parse("http://api.alquran.cloud/v1/ayah/$ayat/ar.alafasy"));
    var bodyAR = jsonDecode(responseAR.body);
    AllUserData.setVerse(bodyEN['data']['text'], 'en');
    AllUserData.setVerse(bodyAR['data']['text'], 'ar');
    AllUserData.setSurahName(bodyEN['data']['surah']['englishName'] +
        ' : ' +
        bodyEN['data']['numberInSurah'].toString());
    AllUserData.setVerseDate(DateTime.now().day);
    AllUserData.setVerseAudio(bodyAR['data']['audio']);
    setState(() {
      dailyAyatAR = AllUserData.getVerse('ar');
      dailyAyatEN = AllUserData.getVerse('en');
      dailyAyatSurah = AllUserData.getSurahName();
      dailyVerseDate = AllUserData.getVerseDate();
      dailyVerseUrl = AllUserData.getVerseAudio();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: colorBg,
      appBar: AppBarCustom(title: "Mi'raj", elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Header(),
            const ToolsRow(),
            DailyVerse(url: dailyVerseUrl),
          ],
        ),
      ),
    );
  }
}

class LinePrayer extends StatelessWidget {
  const LinePrayer({
    Key? key,
    required this.title,
    required this.pray,
  }) : super(key: key);

  final String pray;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            pray,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
