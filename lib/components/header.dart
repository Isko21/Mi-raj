import 'package:muslim_today/components/properties.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // String current =
    //     prayerTimes.currentPrayer().toString().split('.').last.toLowerCase();
    // if (current == 'none') current = 'isha';
    // String next =
    //     prayerTimes.nextPrayer().toString().split('.').last.toUpperCase();
    // if (next == 'NONE') next = 'FAJR';
    // late String time;
    // switch (current) {
    //   case 'fajr':
    //     time = getTime(prayerTimes.sunrise);
    //     break;
    //   case 'sunrise':
    //     time = getTime(prayerTimes.dhuhr);
    //     break;
    //   case 'dhuhr':
    //     time = getTime(prayerTimes.asr);
    //     break;
    //   case 'asr':
    //     time = getTime(prayerTimes.maghrib);
    //     break;
    //   case 'maghrib':
    //     time = getTime(prayerTimes.isha);
    //     break;
    //   case 'isha':
    //     time = getTime(prayerTimes.fajr);
    //     break;
    // }
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img/head_drawer.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(20, 75, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'now',
                          style: TextStyle(fontSize: 15, color: Colors.white70),
                        ),
                        Text(
                          'current.toUpperCase()',
                          style: TextStyle(
                            fontSize: 21,
                            color: white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                      child: Image.asset(
                        'assets/img/asr.png',
                        // 'assets/img/${current == 'sunrise' ? 'dhuhr' : current}.png'
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'upcoming',
                          style: TextStyle(fontSize: 15, color: Colors.white70),
                        ),
                        Text(
                          'next',
                          style: TextStyle(
                            fontSize: 21,
                            color: white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'time',
                          style: TextStyle(fontSize: 19, color: white),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          HijriCalendar.now().hDay.toString(),
                          style: TextStyle(
                            fontSize: 23,
                            color: white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          HijriCalendar.now().longMonthName,
                          style: TextStyle(fontSize: 15, color: white),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Warsaw',
                              style: TextStyle(
                                fontSize: 17,
                                color: white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Icon(CupertinoIcons.location, color: white),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text('Assalamu alaikum', style: getStyle(23, white, true)),
        ],
      ),
    );
  }
}
