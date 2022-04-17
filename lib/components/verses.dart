import 'package:audioplayers/audioplayers.dart';
import 'package:daily_muslim/components/properties.dart';
import 'package:daily_muslim/pages/sub_pages/missed_prays.dart';
import 'package:daily_muslim/pages/sub_pages/qibla_compass.dart';
import 'package:daily_muslim/pages/tasbihs_page.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';
import '../animations/bottom_animation.dart';

class DailyVerse extends StatefulWidget {
  final String url;
  DailyVerse({Key? key, required this.url}) : super(key: key);

  @override
  State<DailyVerse> createState() => _DailyVerseState();
}

class _DailyVerseState extends State<DailyVerse> {
  bool playing = false;
  AudioPlayer audioPlayer = AudioPlayer();
  PlayerState playerState = PlayerState.PAUSED;

  @override
  void initState() {
    super.initState();
    audioPlayer.onPlayerStateChanged.listen((event) {
      setState(() {
        playerState = event;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.release();
    audioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: white.withAlpha(50),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Daily Quran Verse',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 20, color: color, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: !playing ? Icon(Icons.play_arrow) : Icon(Icons.pause),
                  onPressed: () {
                    playing ? pauseVerse() : playVerse();
                  },
                ),
              ],
            ),
            dailyAyatAR.length != 0 && dailyAyatEN.length != 0
                ? Container(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          dailyAyatAR,
                          textAlign: TextAlign.center,
                          textDirection: ui.TextDirection.rtl,
                          style: TextStyle(fontSize: 22, fontFamily: 'Noore'),
                        ),
                      ),
                      Text(
                        dailyAyatEN,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(dailyAyatSurah)
                    ]),
                  )
                : Center(
                    child: Shimmer.fromColors(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/img/ico.png', height: 100),
                        WidgetAnimator(
                            child: Text("Loading Verse..!",
                                style: TextStyle(fontSize: 20)))
                      ],
                    ),
                    baseColor: color,
                    highlightColor: const Color(0xfff9e9b8),
                  ))
          ]),
        ),
      ],
    );
  }

  playVerse() async {
    await audioPlayer.play(widget.url);
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
    // ignore: unused_local_variable
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.only(right: 8),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => new TasbihsPage())),
                  child: Container(
                    width: width / 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            margin: EdgeInsets.all(5),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(20), // Image border
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(30),
                                child: Image.asset('assets/img/tasbih.png',
                                    fit: BoxFit.cover),
                              ),
                            )),
                        Text(
                          'Tasbih',
                          style: TextStyle(color: white, fontSize: 12),
                        ),
                        SizedBox(height: 8)
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MissedPrays())),
                  child: Container(
                      width: width / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: SizedBox.fromSize(
                                  size: Size.fromRadius(30),
                                  child: Image.asset('assets/img/missed.png',
                                      fit: BoxFit.cover),
                                ),
                              )),
                          Text('Missed Prayers',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(color: white, fontSize: 12)),
                          SizedBox(height: 8),
                        ],
                      )),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => QiblaCompass())),
                  child: Container(
                    width: width / 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(30),
                                child: Image.asset('assets/img/qibla.png',
                                    fit: BoxFit.cover),
                              ),
                            )),
                        Text('Qibla',
                            style: TextStyle(color: white, fontSize: 12)),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () => launch(
                      'https://www.google.com/maps/search/mosques+near+me'),
                  child: Container(
                      width: width / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: SizedBox.fromSize(
                                  size: Size.fromRadius(30),
                                  child: Image.asset('assets/img/mosque.png',
                                      fit: BoxFit.cover),
                                ),
                              )),
                          Text('Mosques',
                              style: TextStyle(fontSize: 12, color: white)),
                          SizedBox(height: 8),
                        ],
                      )),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () => launch(
                      'https://www.google.com/maps/search/halal+places+near+me'),
                  child: Container(
                      width: width / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: SizedBox.fromSize(
                                  size: Size.fromRadius(30),
                                  child: Image.asset('assets/img/halal.png',
                                      fit: BoxFit.cover),
                                ),
                              )),
                          Text('Halal Places',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: white,
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis)),
                          SizedBox(height: 8),
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                      width: width / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: SizedBox.fromSize(
                                  size: Size.fromRadius(30),
                                  child: Image.asset('assets/img/name.png',
                                      fit: BoxFit.cover),
                                ),
                              )),
                          Text('Allah Names',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: white,
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis)),
                          SizedBox(height: 8),
                        ],
                      )),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                      width: width / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: SizedBox.fromSize(
                                  size: Size.fromRadius(30),
                                  child: Image.asset('assets/img/dua.png',
                                      fit: BoxFit.cover),
                                ),
                              )),
                          Text('Duas',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: white,
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis)),
                          SizedBox(height: 8),
                        ],
                      )),
                ),
                InkWell(
                  onTap: () =>
                      launch('https://www.youtube.com/watch?v=h4LV2viNHmk'),
                  child: Container(
                      width: width / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: SizedBox.fromSize(
                                  size: Size.fromRadius(30),
                                  child: Image.asset('assets/img/kaaba.png',
                                      fit: BoxFit.cover),
                                ),
                              )),
                          Text('Kaaba Live',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: white,
                                  fontSize: 12,
                                  overflow: TextOverflow.ellipsis)),
                          SizedBox(height: 8),
                        ],
                      )),
                ),
              ],
            )
          ],
        ),
        decoration: BoxDecoration(
            color: color.withAlpha(50),
            borderRadius: BorderRadius.all(Radius.circular(20))));
  }
}
