// ignore_for_file: deprecated_member_use

import 'package:auto_size_text/auto_size_text.dart';
import 'package:muslim_today/animations/bottom_animation.dart';
import 'package:muslim_today/components/properties.dart';
import 'package:muslim_today/components/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../components/location.dart';
import '../components/picker.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  @override
  void initState() {
    super.initState();
    data = DateTime.parse(AllUserData.getInstallDate());
    diff = DateTime.now().difference(data).inDays + 1;
    calcMet = getIndex(AllUserData.getPrayers('source'));
    asrMethod = AllUserData.getPrayers('madhab');
    subLocality = AllUserData.getLocationData('city');
    if (asrMethod == 0)
      asrMet = 'Hanafi';
    else
      asrMet = 'Shafii, Maliki, Hanbali';
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  late String? city;
  late double? lat, long;
  Future getLocation() async {
    final service = UsersLocation();
    final locationData = await service.getLocation();
    if (locationData != null) {
      final placeMark = await service.getPlaceMark(locationData: locationData);

      city = placeMark!.subLocality;
      lat = locationData.latitude!;
      long = locationData.longitude!;
      await AllUserData.setLocationData(city!, 'city');
      await AllUserData.setLatitude(lat!);
      await AllUserData.setLongitude(long!);
      print('all location saved');
    }
  }

  String getIndex(int method) {
    switch (method) {
      case 0:
        calcMet = 'Egyptian General Authority of Survey';
        break;
      case 1:
        calcMet = 'University of Islamic Sciences, Karachi';

        break;
      case 2:
        calcMet = 'Kuwait';

        break;
      case 3:
        calcMet = 'Moonsighting Committee Worldwide';

        break;
      case 4:
        calcMet = 'Muslim World League';

        break;
      case 5:
        calcMet = 'Islamic Society of North America';

        break;
      case 6:
        calcMet = 'Qatar';

        break;
      case 7:
        calcMet = 'Majlis Ugama Islam Singapura';

        break;
      case 8:
        calcMet = 'Institute of Geophysics, Tehran';

        break;
      case 9:
        calcMet = 'Diyanet İşleri Başkanlığı, Turkey';

        break;
      case 10:
        calcMet = 'Umm Al-Qura University, Makkah';
        break;
    }
    return calcMet;
  }

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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: color.withAlpha(50),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        padding: EdgeInsets.only(right: 15, left: 15, top: 0),
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          CircleAvatar(
            backgroundColor: color,
            radius: 40,
            child: WidgetAnimator(
              child: Text(
                firstName[0].toUpperCase(),
                style: TextStyle(
                    color: white, fontSize: 41, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(height: 10),
          WidgetAnimator(
            child: Text(
              userName,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, color: white),
            ),
          ),
          WidgetAnimator(
            child: Text(
              userEmail,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: white.withOpacity(0.5)),
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              WidgetAnimator(
                child: Text(
                  'Member: $diff days',
                  style: TextStyle(color: white),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Divider(
            color: white,
            height: 1,
          ),
          SizedBox(height: 20),
          WidgetAnimator(
            child: Text(
              'LOCATION',
              style: TextStyle(color: white, fontSize: 18),
            ),
          ),
          WidgetAnimator(
            child: Container(
              decoration: BoxDecoration(
                  color: white.withAlpha(50),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: EdgeInsets.only(top: 10, bottom: 20),
              height: 60,
              child: InkWell(
                  onTap: () async {
                    await getLocation();
                    isLoading = !isLoading;
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
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('Your Location is changed',
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5),
                                  Image.asset(
                                    'assets/img/map.png',
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  AutoSizeText(city!,
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
                      ),
                    );
                  },
                  child: !isLoading
                      ? Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Icon(
                                CupertinoIcons.location_circle_fill,
                                color: white,
                                size: 35,
                              ),
                            ),
                            Text(
                              subLocality,
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
                                ),
                              ),
                            )
                          ],
                        )
                      : Center(
                          child: CircularProgressIndicator.adaptive(
                          valueColor: AlwaysStoppedAnimation<Color>(white),
                        ))),
            ),
          ),
          WidgetAnimator(
            child: Text(
              'TIMINGS',
              style: TextStyle(color: white, fontSize: 18),
            ),
          ),
          WidgetAnimator(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              height: 60,
              decoration: BoxDecoration(
                  color: white.withAlpha(50),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                    backgroundColor: colorStr,
                    isScrollControlled: true,
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                    ),
                    context: context,
                    builder: (context) => Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 10),
                          Text(
                            'Calculation methods',
                            style: TextStyle(
                                color: white,
                                fontSize: 21,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 350,
                            child: ListView.separated(
                              separatorBuilder: (context, index) =>
                                  Divider(color: white),
                              itemBuilder: (context, index) {
                                PickerItem pickerItem = paymentModes[index];
                                bool isItemSelected = index == calcMethod;
                                return InkWell(
                                  onTap: () {
                                    setState(
                                      () {
                                        calcMethod = index;
                                        AllUserData.setPrayers(
                                            'source', calcMethod);
                                        calcMet = getIndex(
                                            AllUserData.getPrayers('source'));
                                        getPrayer();
                                        Navigator.pop(context);
                                      },
                                    );
                                  },
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: [
                                          SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              pickerItem.label,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  overflow:
                                                      TextOverflow.ellipsis),
                                            ),
                                          ),
                                          isItemSelected
                                              ? Icon(
                                                  Icons.check_circle,
                                                  size: 16,
                                                  color: white,
                                                )
                                              : Container(),
                                        ],
                                      ),
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
                        Text(calcMet,
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
          ),
          WidgetAnimator(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              height: 60,
              decoration: BoxDecoration(
                  color: white.withAlpha(50),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: InkWell(
                onTap: () => showModalBottomSheet(
                    context: context,
                    backgroundColor: colorStr,
                    isScrollControlled: true,
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15)),
                    ),
                    builder: (context) => Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  'Asr calculation method',
                                  style: TextStyle(
                                      color: white,
                                      fontSize: 21,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  height: 100,
                                  child: ListView.separated(
                                      itemBuilder: (context, index) {
                                        PickerItem pickItem =
                                            asrCalcMethods[index];
                                        bool isSelected = index == asrMethod;
                                        return InkWell(
                                          onTap: () => setState(() {
                                            asrMethod = index;
                                            AllUserData.setPrayers(
                                                'madhab', index);
                                            asrMethod = AllUserData.getPrayers(
                                                'madhab');
                                            if (asrMethod == 0)
                                              asrMet = pickItem.label;
                                            else
                                              asrMet = pickItem.label;
                                            getPrayer();
                                            Navigator.pop(context);
                                          }),
                                          child: Container(
                                            padding: EdgeInsets.all(4),
                                            child: Row(children: [
                                              SizedBox(width: 4),
                                              Expanded(
                                                child: Text(
                                                  pickItem.label,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                ),
                                              ),
                                              isSelected
                                                  ? Icon(
                                                      Icons.check_circle,
                                                      size: 16,
                                                      color: white,
                                                    )
                                                  : Container(),
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
                          asrMet,
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
          ),
          SizedBox(
            height: 20,
          ),
          WidgetAnimator(
            child: Text(
              'OTHER',
              style: TextStyle(color: white, fontSize: 18),
            ),
          ),
          SizedBox(height: 10),
          WidgetAnimator(
            child: InkWell(
              onTap: () => launch('https://www.buymeacoffee.com/iskhak'),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    color: white.withAlpha(50),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        CupertinoIcons.money_dollar_circle_fill,
                        color: white,
                        size: 35,
                      ),
                    ),
                    Text(
                      'Support the project',
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
          ),
          WidgetAnimator(
            child: InkWell(
              onTap: () => showDialog(
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
                            Text(
                              'This app helps all Muslims around the world to perform their daily worship. It\'s absolutely free and doesn\'t contain any ads.',
                              textAlign: TextAlign.center,
                            ),
                            FutureBuilder(
                              future: getVersionNumber(),
                              builder: (BuildContext context,
                                      AsyncSnapshot<String> snapshot) =>
                                  Text(
                                snapshot.hasData
                                    ? 'v' + snapshot.data!
                                    : "Loading ...",
                                style: TextStyle(color: Colors.black38),
                              ),
                            ),
                            Text('Made in Kyrgyzstan'),
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
              ),
              child: Container(
                margin: EdgeInsets.only(top: 10),
                height: 60,
                decoration: BoxDecoration(
                    color: white.withAlpha(50),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
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
                      'About the app',
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
          ),
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
