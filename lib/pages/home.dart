import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:daily_muslim/components/properties.dart';
import 'package:daily_muslim/components/shared_pref.dart';
import 'package:adhan/adhan.dart';
import 'package:hijri/hijri_calendar.dart';
import '../model/pray_time/prayer_time.dart';

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
    getPrayerTimes();
    getPrayer();
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
      prayerTimes = prayers.getPrayerTimes(
          currentTime,
          AllUserData.getLatitude(),
          AllUserData.getLongitude(),
          DateTime.now().timeZoneOffset.inHours + 0.0);
      prayerNames = prayers.getTimeNames();
    });
  }

  late PrayerTimes _prayerTimes;
  getPrayer() {
    var myCoordinates = Coordinates(lat, long);
    var params = CalculationMethod.muslim_world_league.getParameters();
    params.madhab = Madhab.hanafi;
    _prayerTimes = PrayerTimes.today(myCoordinates, params);
  }

  String getTime(DateTime dt) {
    return DateFormat('Hm').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    String current =
        _prayerTimes.currentPrayer().toString().split('.').last.toLowerCase();
    if (current == 'none') current = 'isha';
    String next =
        _prayerTimes.nextPrayer().toString().split('.').last.toUpperCase();
    late String time;
    switch (current) {
      case 'fajr':
        time = getTime(_prayerTimes.fajr);
        break;
      case 'dhuhr':
        time = getTime(_prayerTimes.fajr);
        break;
      case 'asr':
        time = getTime(_prayerTimes.fajr);
        break;
      case 'maghrib':
        time = getTime(_prayerTimes.fajr);
        break;
      case 'isha':
        time = getTime(_prayerTimes.fajr);
        break;
    }
    return SafeArea(
      child: Container(
          height: height,
          width: width,
          color: color.withAlpha(50),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: height * 0.3,
                  width: width,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Now',
                                      style: getStyle(15, white, false),
                                    ),
                                    Text(
                                      current.toUpperCase(),
                                      style: getStyle(25, white, true),
                                    ),
                                  ],
                                ),
                                Container(
                                  child: Image.asset('assets/img/$current.png'),
                                  height: 50,
                                ),
                              ]),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'upcoming',
                                    style: getStyle(15, white, false),
                                  ),
                                  Text(
                                    next,
                                    style: getStyle(25, white, true),
                                  ),
                                  Text(
                                    time,
                                    style: getStyle(25, white, false),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    HijriCalendar.now().hDay.toString(),
                                    style: getStyle(25, white, true),
                                  ),
                                  Text(
                                    '${HijriCalendar.now().longMonthName}',
                                    style: getStyle(15, white, false),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ]),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          'assets/img/back.jpg',
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Column(children: [
                    Text(
                      'Assalamu alaikum',
                      style: getStyle(23, black, true),
                    )
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
