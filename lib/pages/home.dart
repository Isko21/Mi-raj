import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:daily_muslim/components/properties.dart';
import 'package:daily_muslim/components/shared_pref.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:adhan/adhan.dart';
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
          color: color.withAlpha(50),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: height * 0.3,
                  width: width,
                  child: Column(children: []),
                  decoration: BoxDecoration(
                    color: color.withAlpha(50),
                    image: DecorationImage(
                        image: AssetImage('assets/img/mosque.png'),
                        fit: BoxFit.fitWidth),
                  ),
                ),
                Text(
                  HijriCalendar.now().hDay.toString(),
                  style: TextStyle(fontSize: 30),
                ),
                Text(DateFormat.j().format(_prayerTimes.fajr)),
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
