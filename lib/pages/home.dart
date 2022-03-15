import 'package:flutter/material.dart';
import 'package:daily_muslim/animations/bottom_animation.dart';
import 'package:daily_muslim/components/properties.dart';
import 'package:daily_muslim/components/shared_pref.dart';

import '../model/pray_time/prayer_time.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var city = '';
  var country = '';
  List<String> _prayerTimes = [];
  List<String> _prayerNames = [];

  @override
  void initState() {
    super.initState();
    city = AllUserData.getLocationData('city');
    country = AllUserData.getLocationData('country');
    getPrayerTimes();
    //this.getWeather();
  }

  getPrayerTimes() {
    PrayerTime prayers = new PrayerTime();

    prayers.setTimeFormat(prayers.getTime24());
    prayers.setCalcMethod(prayers.getMWL());
    prayers.setAsrJuristic(prayers.getHanafi());
    prayers.setAdjustHighLats(prayers.getAdjustHighLats());

    List<int> offsets = List.filled(7, 0);
    // {Fajr,Sunrise,Dhuhr,Asr,Sunset,Maghrib,Isha}
    prayers.tune(offsets);

    var currentTime = DateTime.now();

    setState(() {
      _prayerTimes = prayers.getPrayerTimes(
          currentTime,
          AllUserData.getLatitude(),
          AllUserData.getLongitude(),
          DateTime.now().timeZoneOffset.inHours + 0.0);
      _prayerNames = prayers.getTimeNames();
    });
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
                    children: [],
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
                      WidgetAnimator(
                          child: LinePrayer(
                              pray: _prayerTimes[0], title: _prayerNames[0])),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Divider(
                          color: black,
                        ),
                      ),
                      WidgetAnimator(
                          child: LinePrayer(
                              pray: _prayerTimes[1], title: _prayerNames[1])),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Divider(
                          color: black,
                        ),
                      ),
                      WidgetAnimator(
                          child: LinePrayer(
                              pray: _prayerTimes[2], title: _prayerNames[2])),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Divider(
                          color: black,
                        ),
                      ),
                      WidgetAnimator(
                          child: LinePrayer(
                              pray: _prayerTimes[3], title: _prayerNames[3])),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Divider(
                          color: black,
                        ),
                      ),
                      WidgetAnimator(
                          child: LinePrayer(
                              pray: _prayerTimes[5], title: _prayerNames[5])),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Divider(
                          color: black,
                        ),
                      ),
                      WidgetAnimator(
                          child: LinePrayer(
                              pray: _prayerTimes[6], title: _prayerNames[6])),
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
