import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:daily_muslim/components/shared_pref.dart';
import '../../components/firebase.dart';
import '../../components/location.dart';
import '../../components/properties.dart';

class AuthPage extends StatefulWidget {
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();
    getLocation();
    AllUserData.setPrayers("fajr", 0);
    AllUserData.setPrayers("dhuhr", 0);
    AllUserData.setPrayers("asr", 0);
    AllUserData.setPrayers("maghrib", 0);
    AllUserData.setPrayers("isha", 0);
    print("Succesfully added prayer times");
  }

  late String? city;
  late double? lat, long;
  void getLocation() async {
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
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: width * 0.09,
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
                  onPressed: () {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.googleLogIn();
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
                  onPressed: () => print('your button is working properly'),
                  icon: FaIcon(
                    FontAwesomeIcons.envelopesBulk,
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
