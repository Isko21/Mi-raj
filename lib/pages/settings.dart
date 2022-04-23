import 'package:daily_muslim/components/properties.dart';
import 'package:daily_muslim/components/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/location.dart';
import '../components/picker.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
    data = DateTime.parse(AllUserData.getInstallDate());
    diff = DateTime.now().difference(data).inDays + 1;
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
  late int diff;
  late DateTime data;
  @override
  Widget build(BuildContext context) {
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
            child: Text(
              firstName[0].toUpperCase(),
              style: TextStyle(
                  color: white, fontSize: 41, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          Text(
            userName,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, color: white),
          ),
          Text(
            userEmail,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: white.withOpacity(0.5)),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Member: $diff days',
                style: TextStyle(color: white),
              )
            ],
          ),
          SizedBox(height: 10),
          Divider(
            color: white,
            height: 1,
          ),
          SizedBox(height: 20),
          Text(
            'LOCATION',
            style: TextStyle(color: white, fontSize: 18),
          ),
          Container(
            decoration: BoxDecoration(
                color: white.withAlpha(50),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            margin: EdgeInsets.only(top: 10, bottom: 20),
            height: 60,
            child: InkWell(
              onTap: () async {
                await getLocation();
                showDialog(
                  context: context,
                  builder: (context) => Container(
                    color: colorStr,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          city!,
                          style: TextStyle(color: white),
                        )
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
                      CupertinoIcons.location_circle_fill,
                      color: white,
                      size: 35,
                    ),
                  ),
                  Text(
                    AllUserData.getLocationData('city'),
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
              ),
            ),
          ),
          Text(
            'TIMINGS',
            style: TextStyle(color: white, fontSize: 18),
          ),
          Container(
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
                                      switch (calcMethod) {
                                        case 0:
                                          calcMet =
                                              'Egyptian General Authority of Survey';
                                          break;
                                        case 1:
                                          calcMet =
                                              'University of Islamic Sciences, Karachi';

                                          break;
                                        case 2:
                                          calcMet = 'Kuwait';

                                          break;
                                        case 3:
                                          calcMet =
                                              'Moonsighting Committee Worldwide';

                                          break;
                                        case 4:
                                          calcMet = 'Muslim World League';

                                          break;
                                        case 5:
                                          calcMet =
                                              'Islamic Society of North America';

                                          break;
                                        case 6:
                                          calcMet = 'Qatar';

                                          break;
                                        case 7:
                                          calcMet =
                                              'Majlis Ugama Islam Singapura';

                                          break;
                                        case 8:
                                          calcMet =
                                              'Institute of Geophysics, Tehran';

                                          break;
                                        case 9:
                                          calcMet =
                                              'Diyanet İşleri Başkanlığı, Turkey';

                                          break;
                                        case 10:
                                          calcMet =
                                              'Umm Al-Qura University, Makkah';
                                          break;
                                      }
                                      AllUserData.setLocationData(
                                          calcMet, 'calc');
                                      calcMet =
                                          AllUserData.getLocationData('calc');

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
          Container(
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
                      'Standard (Shafii, Maliki, Hanbali)',
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
          SizedBox(
            height: 20,
          ),
          Text(
            'OTHER',
            style: TextStyle(color: white, fontSize: 18),
          ),
          SizedBox(height: 10),
          InkWell(
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
          InkWell(
            onTap: () => showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    children: [],
                  );
                }),
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
        ],
      ),
    );
  }
}
