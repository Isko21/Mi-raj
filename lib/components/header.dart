import 'package:daily_muslim/components/properties.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';

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
                      style: TextStyle(fontSize: 25, color: white),
                    ),
                    Text(current.toUpperCase(),
                        style: TextStyle(
                            fontSize: 25,
                            color: white,
                            fontWeight: FontWeight.bold)),
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
                    style: TextStyle(fontSize: 25, color: white),
                  ),
                  Text(next,
                      style: TextStyle(
                          fontSize: 25,
                          color: white,
                          fontWeight: FontWeight.bold)),
                  Text(
                    time,
                    style: TextStyle(fontSize: 25, color: white),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(HijriCalendar.now().hDay.toString(),
                      style: TextStyle(
                          fontSize: 25,
                          color: white,
                          fontWeight: FontWeight.bold)),
                  Text(
                    '${HijriCalendar.now().longMonthName}',
                    style: TextStyle(fontSize: 25, color: white),
                  ),
                  Text(
                    DateFormat('EEEE, d MMM').format(DateTime.now()),
                    style: TextStyle(fontSize: 25, color: white),
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
