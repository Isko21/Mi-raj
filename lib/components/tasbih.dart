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
          return Text(
              "After performing the obligatory Fajr prayer and salutation:",
              style: TextStyle(
                  color: colorStr, fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center);
          break;
        case "Бешим":
          return Text(
              "After performing the obligatory Dhuhr prayer and salutation:",
              style: TextStyle(
                  color: colorStr, fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center);
          break;
        case "Аср":
          return Text(
              "After performing the obligatory Asr prayer and salutation:",
              style: TextStyle(
                  color: colorStr, fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center);
          break;
        case "Шам":
          return Text(
              "After performing the obligatory Maghrib prayer and salutation:",
              style: TextStyle(
                  color: colorStr, fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center);
          break;
        case "Куптан":
          return Text(
              "After performing the obligatory Isha prayer and salutation:",
              style: TextStyle(
                  color: colorStr, fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center);
      }
    }
    return Text(
      text + ' намаздын парзы окулуп, салам берилгенден кийин:',
      style:
          TextStyle(color: colorStr, fontSize: 25, fontWeight: FontWeight.bold),
      textAlign: TextAlign.center,
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
    return Text(
      isArabic ? textAr : textRu,
      style: TextStyle(
        color: colorStr,
        fontSize: 21,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
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
  final TextAlign align;
  const Solatan(
      {Key? key,
      required this.bis,
      required this.isArab,
      required this.arab,
      required this.rus,
      required this.desk,
      required this.align});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Column(
        children: <Widget>[
          bis
              ? Text(isArab ? bismiAR : bismiRU,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: colorStr, fontSize: 30))
              : Text(''),
          Text(
            isArab ? arab : rus,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colorStr,
              fontSize: isArab ? 28 : 20,
            ),
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
    return Padding(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: !_canVibrate
            ? null
            : () {
                Vibrate.feedback(FeedbackType.light);
                add();
                if (first == widget.max) {
                  Vibrate.feedback(FeedbackType.heavy);
                  first = 1;
                }
              },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 1, color: colorStr),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Solatan(
                bis: false,
                arab: widget.ar,
                isArab: widget.isArabic,
                rus: widget.ru,
                desk: '',
                align: TextAlign.center,
              ),
              Text(
                first.toString(),
                style: TextStyle(
                  color: colorStr,
                  fontSize: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
