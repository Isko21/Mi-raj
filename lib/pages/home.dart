import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:daily_muslim/components/properties.dart';
import 'package:daily_muslim/components/shared_pref.dart';
import 'package:hijri/hijri_calendar.dart';
// ignore: import_of_legacy_library_into_null_safe, unused_import
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
    return SafeArea(
      child: Container(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              HijriCalendar.now().hDay.toString(),
              style: TextStyle(fontSize: 30),
            ),
            Text(DateFormat.j().format(_prayerTimes.fajr)),
            Text(DateFormat.j().format(_prayerTimes.sunrise)),
            Text(DateFormat.j().format(_prayerTimes.dhuhr)),
            Text(DateFormat.j().format(_prayerTimes.asr)),
            Text(DateFormat.j().format(_prayerTimes.maghrib)),
            Text(DateFormat.j().format(_prayerTimes.isha)),
            Text(_prayerTimes.nextPrayer().index.toString()),
            Text(_prayerTimes.currentPrayer().index.toString()),
            Text(_prayerTimes.nextPrayerByDateTime(DateTime.now()).toString())
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
