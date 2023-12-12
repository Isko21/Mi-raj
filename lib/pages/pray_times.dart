import 'package:auto_size_text/auto_size_text.dart';
import 'package:muslim_today/components/properties.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/appbar.dart';
import '../model/pray_time/prayer_time.dart';
import 'home.dart';

class PrayTimes extends StatefulWidget {
  const PrayTimes({Key? key}) : super(key: key);

  @override
  State<PrayTimes> createState() => _PrayTimesState();
}

class _PrayTimesState extends State<PrayTimes> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      appBar: AppBarCustom(title: "Mi'raj", elevation: 0),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              height: 10,
            ),
            Image.asset(
              'assets/img/pray_day.png',
              height: MediaQuery.of(context).size.height * 0.25,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 2),
                      )
                    ],
                    color: Colors.white70,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Consumer<PrayerTimingsProvider>(
                  builder: (context, prayerTimingsProvider, _) {
                    if (prayerTimingsProvider.prayerTimings == null) {
                      return const CircularProgressIndicator.adaptive();
                    } else {
                      return Column(children: [
                        LinePrayer(
                            pray: prayerTimingsProvider
                                .prayerTimings!.data!.timings.fajr,
                            title: 'Fajr'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Divider(
                            color: black,
                          ),
                        ),
                        LinePrayer(
                            pray: prayerTimingsProvider.sunrise!,
                            title: 'Sunrise'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Divider(
                            color: black,
                          ),
                        ),
                        LinePrayer(
                            pray: prayerTimingsProvider.dhuhr!, title: 'Dhuhr'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Divider(
                            color: black,
                          ),
                        ),
                        LinePrayer(
                            pray: prayerTimingsProvider.asr!, title: 'Asr'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Divider(
                            color: black,
                          ),
                        ),
                        LinePrayer(
                            pray: prayerTimingsProvider.maghrib!,
                            title: 'Maghrib'),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Divider(
                            color: black,
                          ),
                        ),
                        LinePrayer(
                            pray: prayerTimingsProvider.isha!, title: 'Isha'),
                      ]);
                    }
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: AutoSizeText(
                  'The best act of man is namaz.\nThe best namaz is the timely namaz.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: white)),
            )
          ],
        ),
      ),
    );
  }
}
