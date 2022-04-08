import 'package:daily_muslim/components/properties.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';

class Header extends StatelessWidget {
  Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String current =
        prayerTimes.currentPrayer().toString().split('.').last.toLowerCase();
    if (current == 'none') current = 'isha';
    String next =
        prayerTimes.nextPrayer().toString().split('.').last.toUpperCase();
    late String time;
    switch (current) {
      case 'fajr':
        time = getTime(prayerTimes.dhuhr);
        break;
      case 'dhuhr':
        time = getTime(prayerTimes.asr);
        break;
      case 'asr':
        time = getTime(prayerTimes.maghrib);
        break;
      case 'maghrib':
        time = getTime(prayerTimes.isha);
        break;
      case 'isha':
        time = getTime(prayerTimes.fajr);
        break;
    }
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.3,
      width: width,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                      'now',
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
                  ),
                  Text(
                    DateFormat('EEEE, d MMM').format(DateTime.now()),
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
    );
  }
}
// getPrayerTimes() {
  //   PrayerTime prayers = new PrayerTime();

  //   prayers.setTimeFormat(prayers.getTime24());
  //   prayers.setCalcMethod(prayers.getMWL());
  //   prayers.setAsrJuristic(prayers.getHanafi());
  //   prayers.setAdjustHighLats(prayers.getAdjustHighLats());

  //   List<int> offsets = List.filled(7, 0);
  //   // {F ajr,Sunrise,Dhuhr,Asr,Sunset,Maghrib,Isha}
  //   prayers.tune(offsets);

  //   var currentTime = DateTime.now();

  //   setState(() {
  //     prayerTimes = prayers.getPrayerTimes(
  //         currentTime,
  //         AllUserData.getLatitude(),
  //         AllUserData.getLongitude(),
  //         DateTime.now().timeZoneOffset.inHours + 0.0);
  //     prayerNames = prayers.getTimeNames();
  //   });
  // }
