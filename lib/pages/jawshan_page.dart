import 'package:card_swiper/card_swiper.dart';
import 'package:daily_muslim/animations/bottom_animation.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:daily_muslim/components/properties.dart';

class JawshanPage extends StatefulWidget {
  @override
  State<JawshanPage> createState() => _JawshanPageState();
}

class _JawshanPageState extends State<JawshanPage> {
  double currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: color.withAlpha(50),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(children: <Widget>[
        Expanded(
          child: Swiper(
            scrollDirection: Axis.horizontal,
            curve: Curves.ease,
            layout: SwiperLayout.DEFAULT,
            controller: SwiperController(),
            index: currentIndex.toInt(),
            loop: false,
            onIndexChanged: (i) {
              currentIndex = (i).toDouble();
              setState(() {});
            },
            itemCount: jawshans.length - 1,
            itemBuilder: (context, i) => ListView.builder(
                itemCount: jLang == 1
                    ? jawshans[currentIndex.toInt()].ar.length
                    : jLang == 2
                        ? jawshans[currentIndex.toInt()].eng.length
                        : jLang == 4
                            ? jawshans[currentIndex.toInt()].tr.length
                            : 3,
                itemBuilder: (context, index) {
                  return WidgetAnimator(
                    child: Text(
                      jLang == 1
                          ? '$index ${jawshans[currentIndex.toInt()].ar[index]}'
                          : jLang == 2
                              ? '$index ${jawshans[currentIndex.toInt()].eng[index]}'
                              : jLang == 4
                                  ? jawshans[currentIndex.toInt()].tr[index]
                                  : '',
                      style: TextStyle(
                        fontSize: jLang == 1 ? 24 : 18,
                        color: white,
                        fontFamily: jLang == 1 ? 'Noore' : 'Comfortaa',
                      ),
                      textDirection: jLang == 1
                          ? ui.TextDirection.rtl
                          : ui.TextDirection.ltr,
                    ),
                  );
                }),
          ),
        ),
        Container(
          height: 70,
          child: Column(
            children: [
              Text(
                '${(currentIndex + 1).round()}',
                style: TextStyle(color: white),
              ),
              Slider(
                max: 101,
                divisions: 20,
                min: 1,
                label: currentIndex.round().toString(),
                value: currentIndex + 1,
                onChanged: (val) {
                  currentIndex = val;
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

String bap = '';

class Jawshan {
  final List<String> eng;
  final List<String> tr;
  final List<String> ar;
  int bap = 0;

  Jawshan({required this.tr, required this.ar, required this.eng}) {
    bap++;
  }
}

List<Jawshan> jawshans = <Jawshan>[];
