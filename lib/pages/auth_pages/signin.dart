import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:daily_muslim/components/shared_pref.dart';
import '../../components/firebase.dart';
import '../../components/location.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../components/properties.dart';

class AuthPage extends StatefulWidget {
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();
    getLocation.call();
    AllUserData.setPrayers("fajr", 0);
    AllUserData.setPrayers("dhuhr", 0);
    AllUserData.setPrayers("asr", 0);
    AllUserData.setPrayers("maghrib", 0);
    AllUserData.setPrayers("isha", 0);
    print("Succesfully added prayer times");
  }

  String? lat, long, coutry, city;

  void getLocation() async {
    final service = UsersLocation();
    final locationData = await service.getLocation();
    if (locationData != null) {
      final placeMark = await service.getPlaceMark(locationData: locationData);

      setState(() {
        lat = locationData.latitude.toString();
        long = locationData.longitude.toString();
        coutry = placeMark?.country.toString();
        city = placeMark?.subAdministrativeArea.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: [
                Image.asset(
                  'assets/img/mus.png',
                  height: height / 2.0,
                ),
                AutoSizeText(
                  'Assalamu alaikum',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: width * 0.2,
                      color: colorStr,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton.icon(
                  style: ButtonStyle(
                      elevation:
                          MaterialStateProperty.resolveWith((states) => 3),
                      shadowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.black),
                      minimumSize: MaterialStateProperty.resolveWith(
                          (states) => Size(100, 60)),
                      backgroundColor:
                          MaterialStateColor.resolveWith((states) => color)),
                  onPressed: () async {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.googleLogIn();
                    AllUserData.setLocationData(city.toString(), 'city');
                    AllUserData.setLocationData(coutry.toString(), 'country');
                    print('all location saved');
                  },
                  icon: FaIcon(
                    FontAwesomeIcons.google,
                  ),
                  label: Text(
                    'Sign in with Google',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                ElevatedButton.icon(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.resolveWith((states) => 3),
                    shadowColor: MaterialStateColor.resolveWith(
                        (states) => Colors.black),
                    minimumSize: MaterialStateProperty.resolveWith(
                        (states) => Size(100, 60)),
                    foregroundColor:
                        MaterialStateColor.resolveWith((states) => color),
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => Colors.white),
                  ),
                  onPressed: () {},
                  icon: FaIcon(
                    FontAwesomeIcons.mailBulk,
                  ),
                  label: Text(
                    'Sign in with Email',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}