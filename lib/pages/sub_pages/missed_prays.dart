import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:daily_muslim/components/appbar.dart';
import 'package:daily_muslim/components/properties.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/shared_pref.dart';

class MissedPrays extends StatefulWidget {
  MissedPrays({Key? key}) : super(key: key);

  @override
  State<MissedPrays> createState() => _MissedPraysState();
}

class _MissedPraysState extends State<MissedPrays> {
  int _fajr = 0, _dhuhr = 0, _asr = 0, _maghrib = 0, _isha = 0;
  @override
  void initState() {
    super.initState();
    _fajr = AllUserData.getPrayers("fajr");
    _dhuhr = AllUserData.getPrayers("dhuhr");
    _asr = AllUserData.getPrayers("asr");
    _maghrib = AllUserData.getPrayers("maghrib");
    _isha = AllUserData.getPrayers("isha");
  }

  void add(String name) {
    setState(() {
      switch (name) {
        case "fajr":
          _fajr++;
          AllUserData.addPrayer(name);
          _fajr = AllUserData.getPrayers(name);
          break;
        case "dhuhr":
          _dhuhr++;
          AllUserData.addPrayer(name);
          _dhuhr = AllUserData.getPrayers(name);
          break;
        case "asr":
          _asr++;
          AllUserData.addPrayer(name);
          _asr = AllUserData.getPrayers(name);
          break;
        case "maghrib":
          _maghrib++;
          AllUserData.addPrayer(name);
          _maghrib = AllUserData.getPrayers(name);
          break;
        case "isha":
          _isha++;
          AllUserData.addPrayer(name);
          _isha = AllUserData.getPrayers(name);
          break;
      }
    });
  }

  void subtract(String name) {
    setState(() {
      switch (name) {
        case "fajr":
          _fajr--;
          AllUserData.subtractPrayer(name);
          _fajr = AllUserData.getPrayers(name);
          break;
        case "dhuhr":
          _dhuhr--;
          AllUserData.subtractPrayer(name);
          _dhuhr = AllUserData.getPrayers(name);
          break;
        case "asr":
          _asr--;
          AllUserData.subtractPrayer(name);
          _asr = AllUserData.getPrayers(name);
          break;
        case "maghrib":
          _maghrib--;
          AllUserData.subtractPrayer(name);
          _maghrib = AllUserData.getPrayers(name);
          break;
        case "isha":
          _isha--;
          AllUserData.subtractPrayer(name);
          _isha = AllUserData.getPrayers(name);
          break;
      }
    });
  }

  DateTime teenAge = DateTime.now();
  DateTime startPraying = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
          change: () {}, title: "Missed Prays", page: Pages.settings),
      body: Container(
        color: white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: color.withAlpha(50),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MissPrayer(
                        count: _fajr,
                        title: "Fajr",
                        plus: () => add("fajr"),
                        minus: () => subtract("fajr"),
                      ),
                      Divider(
                        height: 10,
                        color: black,
                      ),
                      MissPrayer(
                        count: _dhuhr,
                        title: "Dhuhr",
                        plus: () => add("dhuhr"),
                        minus: () => subtract("dhuhr"),
                      ),
                      Divider(
                        height: 10,
                        color: black,
                      ),
                      MissPrayer(
                        count: _asr,
                        title: "Asr",
                        plus: () => add("asr"),
                        minus: () => subtract("asr"),
                      ),
                      Divider(
                        height: 10,
                        color: black,
                      ),
                      MissPrayer(
                        count: _maghrib,
                        title: "Maghrib",
                        plus: () => add("maghrib"),
                        minus: () => subtract("maghrib"),
                      ),
                      Divider(
                        height: 10,
                        color: black,
                      ),
                      MissPrayer(
                        count: _isha,
                        title: "Isha",
                        plus: () => add("isha"),
                        minus: () => subtract("isha"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () => print('subtract 1 day'),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'SUBTRACT 1 DAY',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: colorStr),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => print('add 1 day'),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'ADD 1 DAY',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: colorStr),
                              ),
                            ),
                          )
                        ],
                      ),
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.resolveWith((states) => 3),
                  shadowColor:
                      MaterialStateColor.resolveWith((states) => Colors.black),
                  minimumSize: MaterialStateProperty.resolveWith(
                      (states) => Size(100, 60)),
                  foregroundColor:
                      MaterialStateColor.resolveWith((states) => white),
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => color),
                ),
                onPressed: () {
                  showModalBottomSheet<void>(
                      backgroundColor: Color.fromARGB(255, 235, 231, 231),
                      isScrollControlled: true,
                      isDismissible: true,
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      context: context,
                      builder: (_) => Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.all(10),
                                    height: 5,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[500],
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                  'When you became a teenager?',
                                  style: getStyle(21, colorStr, false),
                                ),
                              ),
                              CupertinoButton(
                                  color: color,
                                  child: Text(getFirstText(teenAge)),
                                  onPressed: () =>
                                      showAndroidTimePicker(context)),
                              SizedBox(
                                height: 20,
                              ),
                              Center(
                                child: Text(
                                  'When you started praying?',
                                  style: getStyle(21, colorStr, false),
                                ),
                              ),
                              CupertinoButton(
                                  color: colorStr,
                                  child: Text(getFirstText(teenAge)),
                                  onPressed: () =>
                                      showIOSDateTimePicker(context)),
                            ],
                          )));
                },
                icon: Icon(
                  FontAwesomeIcons.calculator,
                ),
                label: Text(
                  'Calculate your all missed prays',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String getFirstText(DateTime dt) {
    return '${dt.month}/${dt.day}/${dt.year}';
  }

  Future showAndroidTimePicker(context) async {
    final newDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 100),
        lastDate: DateTime.now());
    setState(() => teenAge = newDate as DateTime);
  }

  Future showIOSDateTimePicker(context) async {
    showCupertinoModalPopup(
        context: context,
        builder: (_) => Container(
              height: 190,
              color: Color.fromARGB(255, 255, 255, 255),
              child: Column(
                children: [
                  Container(
                    height: 180,
                    child: CupertinoDatePicker(
                        initialDateTime: DateTime.now(),
                        mode: CupertinoDatePickerMode.date,
                        dateOrder: DatePickerDateOrder.mdy,
                        onDateTimeChanged: (val) {
                          setState(() {
                            startPraying = val;
                          });
                        }),
                  ),
                ],
              ),
            ));
  }
}

// ignore: must_be_immutable
class MissPrayer extends StatelessWidget {
  MissPrayer({
    Key? key,
    required this.title,
    required this.count,
    required this.minus,
    required this.plus,
  }) : super(key: key);

  int count;
  final String title;
  final Function plus;
  final Function minus;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 15),
          ),
          Row(
            children: [
              MaterialButton(
                color: color,
                shape: const CircleBorder(),
                onPressed: () => minus.call(),
                child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    '-',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              ),
              Text(
                count.toString(),
                style: TextStyle(fontSize: 15),
              ),
              MaterialButton(
                color: color,
                shape: const CircleBorder(),
                onPressed: () => plus.call(),
                child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    '+',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
