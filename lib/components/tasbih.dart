// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:daily_muslim/components/properties.dart';
import 'package:daily_muslim/tasbihs/duas.dart';

class Description extends StatelessWidget {
  final String text;
  final bool isArab;
  Description({required this.text, required this.isArab});
  @override
  Widget build(BuildContext context) {
    if (isArab) {
      switch (text) {
        case "Багымдат":
          return Container(
            color: color.withAlpha(150),
            padding: EdgeInsets.all(10),
            child: Text(
                "After performing the obligatory Fajr prayer and salutation:",
                style: TextStyle(
                    color: colorStr, fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
          );
          break;
        case "Бешим":
          return Container(
            color: color.withAlpha(150),
            padding: EdgeInsets.all(10),
            child: Text(
                "After performing the obligatory Dhuhr prayer and salutation:",
                style: TextStyle(
                    color: colorStr, fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
          );
          break;
        case "Аср":
          return Container(
            color: color.withAlpha(150),
            padding: EdgeInsets.all(10),
            child: Text(
                "After performing the obligatory Asr prayer and salutation:",
                style: TextStyle(
                    color: colorStr, fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
          );
          break;
        case "Шам":
          return Container(
            padding: EdgeInsets.all(10),
            color: color.withAlpha(150),
            child: Text(
                "After performing the obligatory Maghrib prayer and salutation:",
                style: TextStyle(
                    color: colorStr, fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
          );
          break;
        case "Куптан":
          return Container(
            color: color.withAlpha(150),
            padding: EdgeInsets.all(10),
            child: Text(
                "After performing the obligatory Isha prayer and salutation:",
                style: TextStyle(
                    color: colorStr, fontSize: 25, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
          );
      }
    }
    return Container(
      color: color.withAlpha(150),
      padding: EdgeInsets.all(10),
      child: Text(
        text + ' намаздын парзы окулуп, салам берилгенден кийин:',
        style: TextStyle(
            color: colorStr, fontSize: 25, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// ignore: must_be_immutable
class Nav extends StatelessWidget {
  final String textAr;
  bool isArabic;
  final String textRu;
  Nav({required this.textRu, required this.isArabic, required this.textAr});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      color: color.withAlpha(100),
      child: Text(
        isArabic ? textAr : textRu,
        style: TextStyle(
          color: colorStr,
          fontSize: 21,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

// ignore: must_be_immutable
class Solatan extends StatelessWidget {
  final bool bis;
  final String rus;
  final bool isArab;
  final String arab;
  final String desk;
  const Solatan({
    Key? key,
    required this.bis,
    required this.isArab,
    required this.arab,
    required this.rus,
    required this.desk,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isArab ? EdgeInsets.fromLTRB(5, 0, 10, 10) : EdgeInsets.all(5),
      color: color.withAlpha(50),
      child: Column(
        children: <Widget>[
          bis
              ? Text(isArab ? bismiAR : bismiRU,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colorStr, fontSize: 30))
              : Text(''),
          !isArab
              ? Text(
                  rus,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colorStr,
                    fontSize: 18,
                  ),
                )
              : Text(
                  arab,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(fontSize: 21),
                ),
        ],
      ),
    );
  }
}

class Counter extends StatefulWidget {
  final int max;
  final String ar;
  final bool isArabic;
  final String ru;
  Counter(
      {required this.max,
      required this.ar,
      required this.isArabic,
      required this.ru});
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int first = 0;
  void add() {
    setState(() {
      first++;
    });
  }

  bool _canVibrate = true;

  @override
  initState() {
    super.initState();
    init();
  }

  init() async {
    bool canVibrate = await Vibrate.canVibrate;
    setState(() {
      _canVibrate = canVibrate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: !_canVibrate
          ? null
          : () {
              Vibrate.feedback(FeedbackType.light);
              add();
              if (first == widget.max) {
                Vibrate.feedback(FeedbackType.heavy);
              }
              if (first - widget.max == 1) {
                first = 1;
              }
            },
      child: Container(
        color: color.withAlpha(200),
        padding: EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.isArabic ? widget.ar : widget.ru,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colorStr,
                fontSize: widget.isArabic ? 28 : 20,
              ),
            ),
            Text(
              '$first/${widget.max}',
              style: TextStyle(
                color: colorStr,
                fontSize: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
