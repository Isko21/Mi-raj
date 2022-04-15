import 'package:audioplayers/audioplayers.dart';
import 'package:daily_muslim/components/properties.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:shimmer/shimmer.dart';
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
        SizedBox(height: 15),
        user.displayName != null
            ? Text(
                'Assalamu alaikum, ${user.displayName!.split(' ').first}',
                style: getStyle(23, white, true),
              )
            : Text(
                'Assalamu alaikum',
                style: getStyle(23, black, true),
              ),
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
