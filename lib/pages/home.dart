import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:daily_muslim/animations/bottom_animation.dart';
import 'package:daily_muslim/components/properties.dart';
import "package:http/http.dart" as http;
import 'package:daily_muslim/components/shared_pref.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var fajr = '',
      sunrise = '',
      dhuhr = '',
      asr = '',
      maghrib = '',
      isha = '',
      arDate = '';

  var city = '';

  var country = '';

  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(
        'http://api.aladhan.com/v1/timingsByCity?city=' +
            city.toString() +
            '&country=' +
            country.toString() +
            '&method=3&school=1'));
    var result = jsonDecode(response.body);
    setState(() {
      this.fajr = result['data']['timings']['Fajr'];
      this.sunrise = result['data']['timings']['Sunrise'];
      this.dhuhr = result['data']['timings']['Dhuhr'];
      this.asr = result['data']['timings']['Asr'];
      this.maghrib = result['data']['timings']['Maghrib'];
      this.isha = result['data']['timings']['Isha'];
      this.arDate = result['data']['date']['hijri']['day'] +
          ' ' +
          result['data']['date']['hijri']['month']['en'] +
          ' ' +
          result['data']['date']['hijri']['year'] +
          ' ' +
          result['data']['date']['hijri']['designation']['abbreviated'];
    });
  }

  @override
  void initState() {
    super.initState();
    city = AllUserData.getLocationData('city');
    country = AllUserData.getLocationData('country');
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(color: white),
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20.0),
          children: [
            WidgetAnimator(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.date_range, color: colorStr),
                      ),
                      Text(arDate,
                          style: TextStyle(color: colorStr, fontSize: 19)),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.location_on, color: colorStr),
                      ),
                      Text(city,
                          style: TextStyle(color: colorStr, fontSize: 20))
                    ],
                  )
                ],
              ),
            ),
            Image.asset(
              'assets/img/pray_day.png',
              height: MediaQuery.of(context).size.height * 0.5,
            ),
            Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: colorStr,
                      blurRadius: 2.0,
                      spreadRadius: 0.0,
                      offset: Offset(2.0, 2.0),
                    )
                  ],
                  color: white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: WidgetAnimator(
                          child: Text(
                            "Today's prayer times",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      fajr.isEmpty
                          ? Shimmer.fromColors(
                              highlightColor: Colors.grey[100]!,
                              baseColor: Colors.grey[300]!,
                              child: LinePrayer(pray: "Loading", title: "Fajr"))
                          : WidgetAnimator(
                              child: LinePrayer(pray: fajr, title: "Fajr")),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Divider(
                          color: black,
                        ),
                      ),
                      fajr.isEmpty
                          ? Shimmer.fromColors(
                              child:
                                  LinePrayer(pray: "Loading", title: "Sunrise"),
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!)
                          : WidgetAnimator(
                              child:
                                  LinePrayer(pray: sunrise, title: "Sunrise")),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Divider(
                          color: black,
                        ),
                      ),
                      fajr.isEmpty
                          ? Shimmer.fromColors(
                              child:
                                  LinePrayer(pray: "Loading", title: "Dhuhr"),
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!)
                          : WidgetAnimator(
                              child: LinePrayer(pray: dhuhr, title: "Dhuhr")),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Divider(
                          color: black,
                        ),
                      ),
                      fajr.isEmpty
                          ? Shimmer.fromColors(
                              child: LinePrayer(pray: "Loading", title: "Asr"),
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!)
                          : WidgetAnimator(
                              child: LinePrayer(pray: asr, title: "Asr")),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Divider(
                          color: black,
                        ),
                      ),
                      fajr.isEmpty
                          ? Shimmer.fromColors(
                              child:
                                  LinePrayer(pray: "Loading", title: "Maghrib"),
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!)
                          : WidgetAnimator(
                              child:
                                  LinePrayer(pray: maghrib, title: "Maghrib")),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Divider(
                          color: black,
                        ),
                      ),
                      fajr.isEmpty
                          ? Shimmer.fromColors(
                              child: LinePrayer(pray: "Loading", title: "Isha"),
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!)
                          : WidgetAnimator(
                              child: LinePrayer(pray: isha, title: 'Isha')),
                    ]),
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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

// ignore: must_be_immutable
class MissPrayer extends StatelessWidget {
  MissPrayer({
    Key? key,
    required this.title,
    required this.count,
    required this.minus,
    required this.plus,
  }) : super(key: key);

  int count;
  final String title;
  final Function plus;
  final Function minus;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 15),
          ),
          Row(
            children: [
              MaterialButton(
                color: colorStr,
                shape: const CircleBorder(),
                onPressed: () => minus.call(),
                child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    '-',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
              Text(
                count.toString(),
                style: TextStyle(fontSize: 15),
              ),
              MaterialButton(
                color: colorStr,
                shape: const CircleBorder(),
                onPressed: () => plus.call(),
                child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    '+',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
