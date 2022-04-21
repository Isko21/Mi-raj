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
  @override
  void initState() {
    super.initState();
  }

  change(int a) {
    if (a == 1) {
      jLang = 1;
    } else if (a == 2) {
      jLang = 2;
    } else if (a == 3) {
      jLang = 3;
    } else if (a == 4) {
      jLang = 4;
    }
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: color.withAlpha(50),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Container(
        decoration: BoxDecoration(
            color: white.withAlpha(200),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        padding: EdgeInsets.only(top: 10, right: 10, left: 10),
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
                setState(() {
                  currentIndex = i;
                });
              },
              itemCount: jawshans.length,
              itemBuilder: (context, i) => ListView.builder(
                  itemCount: jLang == 1
                      ? jawshans[currentIndex].ar.length
                      : jLang == 2
                          ? jawshans[currentIndex].eng.length
                          : jLang == 4
                              ? jawshans[currentIndex].tr.length
                              : 3,
                  itemBuilder: (context, index) {
                    return WidgetAnimator(
                      child: Text(
                        jLang == 1
                            ? '${jawshans[currentIndex].ar[index]}'
                            : jLang == 2
                                ? '${jawshans[currentIndex].eng[index]}'
                                : jLang == 4
                                    ? jawshans[currentIndex].tr[index]
                                    : '',
                        style: TextStyle(
                          fontSize: jLang == 1 ? 25 : 18,
                          color: black,
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${currentIndex + 1}',
                  style: TextStyle(color: black),
                ),
                Slider(
                  activeColor: color,
                  thumbColor: colorStr,
                  max: 99,
                  divisions: 20,
                  min: 1,
                  label: currentIndex.toString(),
                  value: currentIndex + 1,
                  onChanged: (val) {
                    setState(() {
                      currentIndex = val.toInt();
                    });
                  },
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

String bap = '';

class Jawshan {
  final List<String> eng;
  final List<String> tr;
  final List<String> ar;

  Jawshan({required this.tr, required this.ar, required this.eng});
}

List<Jawshan> jawshans = <Jawshan>[];
