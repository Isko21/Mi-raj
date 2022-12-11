import 'package:muslim_today/animations/bottom_animation.dart';
import 'package:muslim_today/components/properties.dart';
import 'package:flutter/cupertino.dart';
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
    if (next == 'NONE') next = 'FAJR';
    late String time;
    switch (current) {
      case 'fajr':
        time = getTime(prayerTimes.sunrise);
        break;
      case 'sunrise':
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
    return Container(
      height: height * 0.3,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(20, 75, 20, 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    WidgetAnimator(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'now',
                            style:
                                TextStyle(fontSize: 15, color: Colors.white70),
                          ),
                          Text(current.toUpperCase(),
                              style: TextStyle(
                                  fontSize: 21,
                                  color: white,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    WidgetAnimator(
                      child: Container(
                        child: Image.asset(
                            'assets/img/${current == 'sunrise' ? 'dhuhr' : current}.png'),
                        height: 50,
                      ),
                    ),
                  ]),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WidgetAnimator(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'upcoming',
                          style: TextStyle(fontSize: 15, color: Colors.white70),
                        ),
                        Text(next,
                            style: TextStyle(
                                fontSize: 21,
                                color: white,
                                fontWeight: FontWeight.bold)),
                        Text(
                          time,
                          style: TextStyle(fontSize: 19, color: white),
                        )
                      ],
                    ),
                  ),
                  WidgetAnimator(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(HijriCalendar.now().hDay.toString(),
                            style: TextStyle(
                                fontSize: 23,
                                color: white,
                                fontWeight: FontWeight.bold)),
                        Text(
                          '${HijriCalendar.now().longMonthName}',
                          style: TextStyle(fontSize: 15, color: white),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              city,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(CupertinoIcons.location, color: white)
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        !isGuest
            ? WidgetAnimator(
                child: Text(
                  'Assalamu alaikum, ${user.displayName!.split(' ').first}',
                  style: getStyle(23, white, true),
                ),
              )
            : WidgetAnimator(
                child: Text(
                  'Assalamu alaikum',
                  style: getStyle(23, white, true),
                ),
              ),
      ]),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              'assets/img/head_drawer.jpg',
            ),
            fit: BoxFit.cover),
      ),
    );
  }
}
