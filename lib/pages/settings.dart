import 'package:daily_muslim/components/properties.dart';
import 'package:daily_muslim/components/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
    data = DateTime.parse(AllUserData.getInstallDate());
    diff = data.difference(DateTime.now()).inDays;
    if (diff == 0) diff = 1;
  }

  late int diff;
  late DateTime data;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color.withAlpha(50),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        padding: EdgeInsets.only(right: 15, left: 15, top: 75),
        children: <Widget>[
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
                      color: white, fontWeight: FontWeight.bold, fontSize: 17),
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
                )
              ],
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
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.source,
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
                    Text('Muslim World League (MWL)',
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
                      )),
                ),
              ],
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
                    Text('Standard (Shafii, Maliki, Hanbali)',
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
                      )),
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
          InkWell(
            onTap: () => launch('https://www.buymeacoffee.com/iskhak'),
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
                      CupertinoIcons.money_dollar_circle_fill,
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
          SizedBox(height: 30),
          Center(
            child: RichText(
              text: TextSpan(
                text: 'Made with 💜 in ',
                style: TextStyle(
                    fontSize: 18, color: white, fontFamily: 'Comfortaa'),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Kyrgyzstan',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'Comfortaa',
                          color: white)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
