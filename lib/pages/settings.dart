// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:auto_size_text/auto_size_text.dart';
import 'package:muslim_today/components/firebase.dart';
import 'package:muslim_today/components/properties.dart';
import 'package:muslim_today/components/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/appbar.dart';
import '../components/picker.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
    data = DateTime.parse(AllUserData.getInstallDate());
    diff = DateTime.now().difference(data).inDays + 1;
    // calcMet = getIndex(AllUserData.getPrayers('source'));
    // asrMethod = AllUserData.getPrayers('madhab');
    subLocality = AllUserData.getLocationData('city');
    // if (asrMethod == 0) {
    //   asrMet = 'Hanafi';
    // } else {
    //   asrMet = 'Shafii, Maliki, Hanbali';
    // }
  }

  // String getIndex(int method) {
  //   switch (method) {
  //     case 0:
  //       calcMet = 'Egyptian General Authority of Survey';
  //       break;
  //     case 1:
  //       calcMet = 'University of Islamic Sciences, Karachi';

  //       break;
  //     case 2:
  //       calcMet = 'Kuwait';

  //       break;
  //     case 3:
  //       calcMet = 'Moonsighting Committee Worldwide';

  //       break;
  //     case 4:
  //       calcMet = 'Muslim World League';

  //       break;
  //     case 5:
  //       calcMet = 'Islamic Society of North America';

  //       break;
  //     case 6:
  //       calcMet = 'Qatar';

  //       break;
  //     case 7:
  //       calcMet = 'Majlis Ugama Islam Singapura';

  //       break;
  //     case 8:
  //       calcMet = 'Institute of Geophysics, Tehran';

  //       break;
  //     case 9:
  //       calcMet = 'Diyanet İşleri Başkanlığı, Turkey';

  //       break;
  //     case 10:
  //       calcMet = 'Umm Al-Qura University, Makkah';
  //       break;
  //   }
  //   return calcMet;
  // }

  final List<PickerItem> paymentModes = [
    PickerItem("Egyptian General Authority of Survey"),
    PickerItem("University of Islamic Sciences, Karachi"),
    PickerItem("Kuwait"),
    PickerItem("Moonsighting Committee Worldwide"),
    PickerItem("Muslim World League"),
    PickerItem("Islamic Society of North America"),
    PickerItem("Qatar"),
    PickerItem("Majlis Ugama Islam Singapura"),
    PickerItem("Institute of Geophysics, University of Tehran"),
    PickerItem("Diyanet İşleri Başkanlığı, Turkey"),
    PickerItem('Umm Al-Qura University, Makkah'),
  ];
  final List<PickerItem> asrCalcMethods = [
    PickerItem('Hanafi'),
    PickerItem('Shafii, Maliki, Hanbali')
  ];
  late int diff;
  late DateTime data;
  late String subLocality;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      appBar: AppBarCustom(title: "Mi'raj", elevation: 0),
      body: ListView(
        padding: const EdgeInsets.only(right: 15, left: 15, top: 0),
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          CircleAvatar(
            backgroundColor: color,
            radius: 40,
            child: Text(
              'G',
              style: TextStyle(
                  color: white, fontSize: 41, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Member: $diff days',
                style: TextStyle(color: white),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(
            color: white,
            height: 1,
          ),
          const SizedBox(height: 20),
          Text(
            'LOCATION',
            style: TextStyle(color: white, fontSize: 18),
          ),
          Container(
            decoration: BoxDecoration(
                color: white.withAlpha(50),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            margin: const EdgeInsets.only(top: 10, bottom: 20),
            height: 60,
            child: InkWell(
                onTap: () async {
                  // await getLocation();
                  isLoading = !isLoading;
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_) => Center(
                      child: Material(
                        color: Colors.transparent,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 10.0),
                          decoration: ShapeDecoration(
                            color: white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Your Location is changed',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.headline5),
                              Image.asset(
                                'assets/img/map.png',
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                              AutoSizeText('Warsaw',
                                  style: TextStyle(
                                      color: black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40),
                                  maxLines: 1),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                      onPressed: () {
                                        setState(() {
                                          subLocality =
                                              AllUserData.getLocationData(
                                                  'city');
                                          isLoading = !isLoading;
                                        });

                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'OK',
                                        style: getStyle(18, color, false),
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                child: !isLoading
                    ? const Row()
                    : Center(
                        child: CircularProgressIndicator.adaptive(
                        valueColor: AlwaysStoppedAnimation<Color>(white),
                      ))),
          ),
          Text(
            'TIMINGS',
            style: TextStyle(color: white, fontSize: 18),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: 60,
            decoration: BoxDecoration(
                color: white.withAlpha(50),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: colorStr,
                  isScrollControlled: true,
                  elevation: 1.0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                  ),
                  context: context,
                  builder: (context) => Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          'Calculation methods',
                          style: TextStyle(
                              color: white,
                              fontSize: 21,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 350,
                          child: ListView.separated(
                            separatorBuilder: (context, index) =>
                                Divider(color: white),
                            itemBuilder: (context, index) {
                              PickerItem pickerItem = paymentModes[index];
                              return InkWell(
                                onTap: () {
                                  setState(
                                    () {
                                      // calcMethod = index;
                                      // AllUserData.setPrayers(
                                      //     'source', calcMethod);
                                      // calcMet = getIndex(
                                      //     AllUserData.getPrayers('source'));
                                      // getPrayer();
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          pickerItem.label,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                      ),
                                      Container(),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: paymentModes.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      CupertinoIcons.moon_fill,
                      color: white,
                      size: 35,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Prayer times source',
                        style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                      Text('Muslim World League',
                          style: TextStyle(
                              color: white.withOpacity(0.5),
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                    ],
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          FontAwesomeIcons.ellipsis,
                          size: 20,
                          color: white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: 60,
            decoration: BoxDecoration(
                color: white.withAlpha(50),
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            child: InkWell(
              onTap: () => showModalBottomSheet(
                  context: context,
                  backgroundColor: colorStr,
                  isScrollControlled: true,
                  elevation: 1.0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                  ),
                  builder: (context) => Container(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                'Asr calculation method',
                                style: TextStyle(
                                    color: white,
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                height: 100,
                                child: ListView.separated(
                                    itemBuilder: (context, index) {
                                      PickerItem pickItem =
                                          asrCalcMethods[index];
                                      return InkWell(
                                        onTap: () => setState(() {
                                          // asrMethod = index;
                                          // AllUserData.setPrayers(
                                          //     'madhab', index);
                                          // asrMethod =
                                          //     AllUserData.getPrayers('madhab');
                                          // if (asrMethod == 0) {
                                          //   asrMet = pickItem.label;
                                          // } else {
                                          //   asrMet = pickItem.label;
                                          // }
                                          // // getPrayer();
                                          Navigator.pop(context);
                                        }),
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          child: Row(children: [
                                            const SizedBox(width: 4),
                                            Expanded(
                                              child: Text(
                                                pickItem.label,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              ),
                                            ),
                                            Container(),
                                          ]),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        Divider(color: white),
                                    itemCount: 2),
                              )
                            ]),
                      )),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.calculate,
                      color: white,
                      size: 35,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Asr calculation method',
                        style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                      Text(
                        'HANAFI',
                        style: TextStyle(
                            color: white.withOpacity(0.5),
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          FontAwesomeIcons.ellipsis,
                          size: 20,
                          color: white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'OTHER',
            style: TextStyle(color: white, fontSize: 18),
          ),
          InkWell(
            onTap: () => showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => Center(
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 10.0),
                    decoration: ShapeDecoration(
                      color: white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('Mi\'raj',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headline5),
                        Image.asset(
                          'assets/img/ic_launcher.png',
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                        const Text(
                          'This app helps all Muslims around the world to perform their daily worship. It\'s absolutely free and doesn\'t contain any ads.',
                          textAlign: TextAlign.center,
                        ),
                        FutureBuilder(
                          future: getVersionNumber(),
                          builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) =>
                              Text(
                            snapshot.hasData
                                ? 'v${snapshot.data!}'
                                : "Loading ...",
                            style: const TextStyle(color: Colors.black38),
                          ),
                        ),
                        const Text('Made in Kyrgyzstan'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  setState(() {});

                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'OK',
                                  style: getStyle(18, color, false),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              height: 60,
              decoration: BoxDecoration(
                  color: white.withAlpha(50),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.help,
                      color: white,
                      size: 35,
                    ),
                  ),
                  Text(
                    'About app',
                    style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            FontAwesomeIcons.ellipsis,
                            size: 20,
                            color: white,
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              await preferences.clear();
              AnonymousSignInProvider().signOut();
            },
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                  color: white.withAlpha(50),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.exit_to_app_rounded,
                      color: white,
                      size: 35,
                    ),
                  ),
                  Text(
                    'Log out',
                    style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            FontAwesomeIcons.ellipsis,
                            size: 20,
                            color: white,
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              await preferences.clear();

              AnonymousSignInProvider().signOut();
              setState(() {});
              // exit(0);
            },
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                  color: white.withAlpha(50),
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(
                      Icons.delete,
                      color: white,
                      size: 35,
                    ),
                  ),
                  Text(
                    'Delete account',
                    style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  ),
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Icon(
                            FontAwesomeIcons.ellipsis,
                            size: 20,
                            color: white,
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;

    return version;
  }
}
