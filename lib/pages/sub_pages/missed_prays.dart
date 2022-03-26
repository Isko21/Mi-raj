// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:daily_muslim/components/appbar.dart';
import 'package:daily_muslim/components/properties.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import '../../components/missed_prays_widget.dart';
import '../../components/shared_pref.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MissedPrays extends StatefulWidget {
  MissedPrays({Key? key}) : super(key: key);

  @override
  State<MissedPrays> createState() => _MissedPraysState();
}

class _MissedPraysState extends State<MissedPrays>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  int _fajr = 0, _dhuhr = 0, _asr = 0, _maghrib = 0, _isha = 0;
  @override
  void initState() {
    super.initState();
    _fajr = AllUserData.getPrayers("fajr");
    _dhuhr = AllUserData.getPrayers("dhuhr");
    _asr = AllUserData.getPrayers("asr");
    _maghrib = AllUserData.getPrayers("maghrib");
    _isha = AllUserData.getPrayers("isha");
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  void add(String name, int count) {
    setState(() {
      switch (name) {
        case "fajr":
          _fajr++;
          AllUserData.addPrayer(name, count);
          _fajr = AllUserData.getPrayers(name);
          break;
        case "dhuhr":
          _dhuhr++;
          AllUserData.addPrayer(name, count);
          _dhuhr = AllUserData.getPrayers(name);
          break;
        case "asr":
          _asr++;
          AllUserData.addPrayer(name, count);
          _asr = AllUserData.getPrayers(name);
          break;
        case "maghrib":
          _maghrib++;
          AllUserData.addPrayer(name, count);
          _maghrib = AllUserData.getPrayers(name);
          break;
        case "isha":
          _isha++;
          AllUserData.addPrayer(name, count);
          _isha = AllUserData.getPrayers(name);
          break;
      }
    });
  }

  String getText(DateTime dt, int a) {
    if (dt.day == DateTime.now().day) {
      return a == 1
          ? 'When you bacame a teenager?'
          : 'When you started praying?';
    } else {
      return DateFormat('MM/dd/yyyy').format(dt);
    }
  }

  Future<DateTime> pickDate(BuildContext context, int a) async {
    final newDate = await showDatePicker(
      context: context,
      initialDate: teenAge,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime.now(),
    );

    if (newDate == null) return teenAge;
    setState(() {
      switch (a) {
        case 1:
          teenAge = newDate;
          break;
        case 2:
          startPraying = newDate;
          break;
      }
    });
    return newDate;
  }

  void subtract(String name, int a) {
    setState(() {
      switch (name) {
        case "fajr":
          _fajr--;
          AllUserData.subtractPrayer(name, a);
          _fajr = AllUserData.getPrayers(name);
          break;
        case "dhuhr":
          _dhuhr--;
          AllUserData.subtractPrayer(name, a);
          _dhuhr = AllUserData.getPrayers(name);
          break;
        case "asr":
          _asr--;
          AllUserData.subtractPrayer(name, a);
          _asr = AllUserData.getPrayers(name);
          break;
        case "maghrib":
          _maghrib--;
          AllUserData.subtractPrayer(name, a);
          _maghrib = AllUserData.getPrayers(name);
          break;
        case "isha":
          _isha--;
          AllUserData.subtractPrayer(name, a);
          _isha = AllUserData.getPrayers(name);
          break;
      }
    });
  }

  bool isVisible = false;
  DateTime teenAge = DateTime.now();
  DateTime startPraying = DateTime.now();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBarCustom(
          change: () {}, title: "Missed Prays", page: Pages.settings),
      body: Container(
        color: white,
        child: ListView(
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
                        plus: () => add("fajr", 1),
                        minus: () => subtract("fajr", 1),
                      ),
                      Divider(
                        height: 10,
                        color: black,
                      ),
                      MissPrayer(
                        count: _dhuhr,
                        title: "Dhuhr",
                        plus: () => add("dhuhr", 1),
                        minus: () => subtract("dhuhr", 1),
                      ),
                      Divider(
                        height: 10,
                        color: black,
                      ),
                      MissPrayer(
                        count: _asr,
                        title: "Asr",
                        plus: () => add("asr", 1),
                        minus: () => subtract("asr", 1),
                      ),
                      Divider(
                        height: 10,
                        color: black,
                      ),
                      MissPrayer(
                        count: _maghrib,
                        title: "Maghrib",
                        plus: () => add("maghrib", 1),
                        minus: () => subtract("maghrib", 1),
                      ),
                      Divider(
                        height: 10,
                        color: black,
                      ),
                      MissPrayer(
                        count: _isha,
                        title: "Isha",
                        plus: () => add("isha", 1),
                        minus: () => subtract("isha", 1),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FlatButton(
                            onPressed: () => print('subtract 1 day'),
                            child: Text(
                              'SUBTRACT 1 DAY',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: colorStr),
                            ),
                          ),
                          FlatButton(
                            onPressed: () => print('add 1 day'),
                            child: Text(
                              'ADD 1 DAY',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: colorStr),
                            ),
                          )
                        ],
                      ),
                    ]),
              ),
            ),
            Visibility(
                replacement: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      elevation:
                          MaterialStateProperty.resolveWith((states) => 3),
                      shadowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.black),
                      minimumSize: MaterialStateProperty.resolveWith(
                          (states) => Size(100, 60)),
                      foregroundColor:
                          MaterialStateColor.resolveWith((states) => white),
                      backgroundColor:
                          MaterialStateColor.resolveWith((states) => color),
                    ),
                    onPressed: () {
                      if (!isVisible) {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      }
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
                visible: isVisible,
                maintainAnimation: isVisible,
                maintainSize: isVisible,
                maintainState: isVisible,
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: colorStr.withAlpha(50)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CupertinoButton(
                              color: color,
                              child: AutoSizeText(
                                getText(teenAge, 1),
                                maxLines: 1,
                                style: getStyle(21, white, false),
                              ),
                              onPressed: () => pickDate(context, 1)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CupertinoButton(
                              color: color,
                              child: AutoSizeText(getText(startPraying, 2),
                                  maxLines: 1),
                              onPressed: () => pickDate(context, 2)),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        CupertinoButton(
                            color: colorStr,
                            child: Text('Calculate'),
                            onPressed: () {
                              print(startPraying.difference(teenAge).inDays);
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (_) => ScaleTransition(
                                  scale: scaleAnimation,
                                  child: Center(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 18.0, vertical: 10.0),
                                        width: width * 0.75,
                                        height: height * 0.39,
                                        decoration: ShapeDecoration(
                                          color: white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text('Your Missed Days',
                                                textAlign: TextAlign.center,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5),
                                            SizedBox(
                                              height: height * 0.02,
                                            ),
                                            Text(
                                                startPraying
                                                    .difference(teenAge)
                                                    .inDays
                                                    .toString(),
                                                style: getStyle(
                                                    130.0, colorStr, true)),
                                            Text(
                                              'Do you want to set this data?',
                                              style: getStyle(18, black, false),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                FlatButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        isVisible = !isVisible;
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'NO',
                                                      style: getStyle(
                                                          18, color, false),
                                                    )),
                                                FlatButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        isVisible = !isVisible;
                                                      });
                                                      add(
                                                          'fajr',
                                                          startPraying
                                                              .difference(
                                                                  teenAge)
                                                              .inDays);
                                                      add(
                                                          'dhuhr',
                                                          startPraying
                                                              .difference(
                                                                  teenAge)
                                                              .inDays);
                                                      add(
                                                          'asr',
                                                          startPraying
                                                              .difference(
                                                                  teenAge)
                                                              .inDays);
                                                      add(
                                                          'maghrib',
                                                          startPraying
                                                              .difference(
                                                                  teenAge)
                                                              .inDays);
                                                      add(
                                                          'isha',
                                                          startPraying
                                                              .difference(
                                                                  teenAge)
                                                              .inDays);
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text(
                                                      'YES',
                                                      style: getStyle(
                                                          18, color, false),
                                                    )),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  // void showAndroidTimePicker(context) {
  //   final newDate = showDatePicker(
  //       context: context,
  //       initialDate: teenAge,
  //       firstDate: DateTime(DateTime.now().year - 100),
  //       lastDate: DateTime.now());
  //   teenAge = newDate as DateTime;
  // }

  // void showIOSDateTimePicker(context) {
  //   showCupertinoModalPopup(
  //       context: context,
  //       builder: (_) => Container(
  //             height: 190,
  //             color: Color.fromARGB(255, 255, 255, 255),
  //             child: Column(
  //               children: [
  //                 Container(
  //                   height: 180,
  //                   child: CupertinoDatePicker(
  //                     initialDateTime: startPraying,
  //                     mode: CupertinoDatePickerMode.date,
  //                     dateOrder: DatePickerDateOrder.mdy,
  //                     onDateTimeChanged: (val) => startPraying = val,
  //                   ),
  //                 )
  //               ],
  //             ),
  //           ));
  // }
}
