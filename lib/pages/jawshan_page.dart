import 'package:flutter/material.dart';
import 'package:muslim_today/components/properties.dart';
import 'package:swipe/swipe.dart';
import 'dart:ui' as ui;
import '../animations/bottom_animation.dart';

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
    }
  }

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: color.withAlpha(50),
      height: MediaQuery.of(context).size.height,
      child: Container(
        decoration: BoxDecoration(
            color: white.withAlpha(200),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        padding: EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Swipe(
                onSwipeLeft: () => setState(
                  () {
                    if (currentIndex != 99) currentIndex++;
                  },
                ),
                onSwipeRight: () => setState(
                  () {
                    if (currentIndex != 0) currentIndex--;
                  },
                ),
                child: ListView.builder(
                  itemCount: jLang == 1
                      ? jawshans[currentIndex].ar.length
                      : jawshans[currentIndex].eng.length,
                  itemBuilder: (context, index) {
                    return WidgetAnimator(
                      child: Text(
                        jLang == 1
                            ? '${jawshans[currentIndex].ar[index]}'
                            : '${jawshans[currentIndex].eng[index]}',
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
                  },
                ),
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
                    min: 0,
                    label: (currentIndex + 1).toString(),
                    value: currentIndex.toDouble(),
                    onChanged: (val) {
                      setState(
                        () {
                          currentIndex = val.toInt();
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Jawshan {
  final List<String> eng;
  final List<String> tr;
  final List<String> ar;

  Jawshan({required this.tr, required this.ar, required this.eng});
}

List<Jawshan> jawshans = <Jawshan>[];