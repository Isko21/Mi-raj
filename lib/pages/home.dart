import 'dart:convert';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:muslim_today/animations/bottom_animation.dart';
import 'package:muslim_today/components/header.dart';
import 'package:muslim_today/components/verses.dart';
import 'package:flutter/material.dart';
import 'package:muslim_today/components/properties.dart';
import 'package:muslim_today/components/shared_pref.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    print(user);
    dailyAyatAR = AllUserData.getVerse('ar');
    dailyAyatEN = AllUserData.getVerse('en');
    dailyAyatSurah = AllUserData.getSurahName();
    dailyVerseDate = AllUserData.getVerseDate();
    dailyVerseUrl = AllUserData.getVerseAudio();
    if (dailyVerseDate != DateTime.now().day) {
      Random random = Random();
      ayat = random.nextInt(6236);
      getRandomAyat(ayat);
    }
    city = AllUserData.getLocationData('city');
    country = AllUserData.getLocationData('country');
    long = AllUserData.getLongitude();
    lat = AllUserData.getLatitude();
    getPrayer();
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
    return Container(
      height: MediaQuery.of(context).size.height,
      color: color.withAlpha(50),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Header(),
            WidgetAnimator(child: ToolsRow()),
            WidgetAnimator(
              child: DailyVerse(
                url: dailyVerseUrl,
              ),
            ),
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
            style: TextStyle(fontSize: 16),
          ),
          Text(
            pray,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
