import 'dart:convert';
import 'dart:math';
import 'package:daily_muslim/components/header.dart';
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
    city = AllUserData.getLocationData('city');
    country = AllUserData.getLocationData('country');
    long = AllUserData.getLongitude();
    lat = AllUserData.getLatitude();
    getPrayer();

    Random random = Random();
    ayat = random.nextInt(6236);
    getRandomAyat(ayat);
  }

  Future<void> getRandomAyat(int ayat) async {
    var endPointEN =
        Uri.parse("http://api.alquran.cloud/v1/ayah/$ayat/en.asad");
    var responseEN = await http.get(endPointEN);
    var bodyEN = jsonDecode(responseEN.body);

    var responseAR =
        await http.get(Uri.parse("http://api.alquran.cloud/v1/ayah/$ayat"));
    var bodyAR = jsonDecode(responseAR.body);
    dailyAyatEN = bodyEN['data']['text'];
    dailyAyatAR = bodyAR['data']['text'];
    dailyAyatSurah = bodyEN['data']['surah']['englishName'];
    //await player.setUrl(
    //  'https://cdn.islamic.network//quran//audio//128//ar.alafasy//262.mp3');
    print(ayat);
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
                Container(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Daily Quran Verses for you',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: playAudio,
                          onPressed: () {},
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        dailyAyatAR,
                        textAlign: TextAlign.justify,
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
