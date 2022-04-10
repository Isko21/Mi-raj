import 'dart:convert';
import 'dart:math';
import 'package:daily_muslim/components/header.dart';
import 'package:daily_muslim/components/verses.dart';
import 'package:flutter/material.dart';
import 'package:daily_muslim/components/properties.dart';
import 'package:daily_muslim/components/shared_pref.dart';
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
    Random random = Random();
    ayat = random.nextInt(6236);
    dailyAyatAR = AllUserData.getVerse('ar');
    dailyAyatEN = AllUserData.getVerse('en');
    dailyAyatSurah = AllUserData.getSurahName();
    dailyVerseDate = AllUserData.getVerseDate();
    dailyVerseUrl = AllUserData.getVerseAudio();
    if (dailyVerseDate != DateTime.now().day) {
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Container(
          height: height,
          width: width,
          color: color.withAlpha(50),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Header(),
                DailyVerse(
                  url: dailyVerseUrl,
                )
              ],
            ),
          )),
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
