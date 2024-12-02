// ignore_for_file: deprecated_member_use

import 'package:audioplayers/audioplayers.dart';
import 'package:muslim_today/components/properties.dart';
import 'package:muslim_today/pages/sub_pages/asmaulhusna.dart';
import 'package:muslim_today/pages/sub_pages/missed_prays.dart';
import 'package:muslim_today/pages/sub_pages/qibla_compass.dart';
import 'package:muslim_today/pages/tasbihs_page.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class DailyVerse extends StatefulWidget {
  final String url;
  const DailyVerse({Key? key, required this.url}) : super(key: key);

  @override
  State<DailyVerse> createState() => _DailyVerseState();
}

class _DailyVerseState extends State<DailyVerse> {
  bool playing = false;
  AudioPlayer audioPlayer = AudioPlayer();
  PlayerState playerState = PlayerState.paused;

  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((event) {
      playerState = event;
    });
  }

  @override
  void dispose() {
    audioPlayer.release();
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: white.withOpacity(0.9),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Daily Quran Verse',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 20,
                      color: colorStr,
                      fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: !playing
                      ? Icon(
                          Icons.play_arrow,
                          color: colorStr,
                        )
                      : Icon(
                          Icons.pause,
                          color: colorStr,
                        ),
                  onPressed: () {
                    playing ? pauseVerse() : playVerse();
                  },
                ),
              ],
            ),
            // dailyAyatAR.isNotEmpty && dailyAyatEN.isNotEmpty
            //     ? Column(children: [
            //         Padding(
            //           padding: const EdgeInsets.symmetric(vertical: 10.0),
            //           child: Text(
            //             dailyAyatAR,
            //             textAlign: TextAlign.center,
            //             textDirection: ui.TextDirection.rtl,
            //             style:
            //                 const TextStyle(fontSize: 22, fontFamily: 'Noore'),
            //           ),
            //         ),
            //         Text(
            //           dailyAyatEN,
            //           textAlign: TextAlign.center,
            //           style: const TextStyle(fontSize: 18),
            //         ),
            //         const SizedBox(
            //           height: 15,
            //         ),
            //         Text('Surah $dailyAyatSurah')
            //       ])
            //     :
            Center(
                child: Shimmer.fromColors(
              baseColor: color,
              highlightColor: const Color(0xfff9e9b8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset('assets/img/ico.png', height: 100),
                  const Text("Loading Verse..!", style: TextStyle(fontSize: 20))
                ],
              ),
            ))
          ]),
        ),
      ],
    );
  }

  playVerse() async {
    await audioPlayer.play(UrlSource(widget.url));
    setState(() {
      playing = !playing;
    });
  }

  pauseVerse() async {
    await audioPlayer.pause();
    setState(() {
      playing = !playing;
    });
  }
}

class ToolsRow extends StatelessWidget {
  const ToolsRow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () => PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const TasbihsPage(),
                ),
                child: SizedBox(
                  width: width / 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          margin: const EdgeInsets.all(5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(30),
                              child: Image.asset('assets/img/tasbih.png',
                                  fit: BoxFit.cover),
                            ),
                          )),
                      Text(
                        'Tasbih',
                        style: TextStyle(color: white, fontSize: 12),
                      ),
                      const SizedBox(height: 8)
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const MissedPrays(),
                ),
                child: SizedBox(
                    width: width / 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            margin: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(30),
                                child: Image.asset('assets/img/missed.png',
                                    fit: BoxFit.cover),
                              ),
                            )),
                        Text('Missed Prayers',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(color: white, fontSize: 12)),
                        const SizedBox(height: 8),
                      ],
                    )),
              ),
              InkWell(
                onTap: () => PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const AsMaulHusna(),
                ),
                child: SizedBox(
                    width: width / 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            margin: const EdgeInsets.all(5),
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: SizedBox.fromSize(
                                size: const Size.fromRadius(30),
                                child: Image.asset('assets/img/name.png',
                                    fit: BoxFit.cover),
                              ),
                            )),
                        Text('Names',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: white,
                                fontSize: 12,
                                overflow: TextOverflow.ellipsis)),
                        const SizedBox(height: 8),
                      ],
                    )),
              ),
              InkWell(
                onTap: () => PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const QiblaCompass(),
                ),
                child: SizedBox(
                  width: width / 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                          margin: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(30),
                              child: Image.asset('assets/img/qibla.png',
                                  fit: BoxFit.cover),
                            ),
                          )),
                      Text('Qibla',
                          style: TextStyle(color: white, fontSize: 12)),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void launchUrlString(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
