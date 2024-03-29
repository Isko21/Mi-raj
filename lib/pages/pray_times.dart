import 'package:auto_size_text/auto_size_text.dart';
import 'package:muslim_today/components/properties.dart';
import 'package:flutter/material.dart';
import '../animations/bottom_animation.dart';
import 'home.dart';

class PrayTimes extends StatefulWidget {
  PrayTimes({Key? key}) : super(key: key);

  @override
  State<PrayTimes> createState() => _PrayTimesState();
}

class _PrayTimesState extends State<PrayTimes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(top: 30),
      color: color.withAlpha(50),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 10,
            ),
            Image.asset(
              'assets/img/pray_day.png',
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 2),
                      )
                    ],
                    color: Colors.white70,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(children: [
                  WidgetAnimator(
                      child: LinePrayer(
                          pray: getTime(prayerTimes.fajr), title: 'Fajr')),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Divider(
                      color: black,
                    ),
                  ),
                  WidgetAnimator(
                      child: LinePrayer(
                          pray: getTime(prayerTimes.sunrise),
                          title: 'Sunrise')),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Divider(
                      color: black,
                    ),
                  ),
                  WidgetAnimator(
                      child: LinePrayer(
                          pray: getTime(prayerTimes.dhuhr), title: 'Dhuhr')),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Divider(
                      color: black,
                    ),
                  ),
                  WidgetAnimator(
                      child: LinePrayer(
                          pray: getTime(prayerTimes.asr), title: 'Asr')),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Divider(
                      color: black,
                    ),
                  ),
                  WidgetAnimator(
                      child: LinePrayer(
                          pray: getTime(prayerTimes.maghrib),
                          title: 'Maghrib')),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Divider(
                      color: black,
                    ),
                  ),
                  WidgetAnimator(
                      child: LinePrayer(
                          pray: getTime(prayerTimes.isha), title: 'Isha')),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: WidgetAnimator(
                child: AutoSizeText(
                    'The best act of man is namaz.\nThe best namaz is the timely namaz.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
