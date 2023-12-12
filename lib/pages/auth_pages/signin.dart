import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:muslim_today/components/shared_pref.dart';
import '../../components/firebase.dart';
import '../../components/properties.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();
    // getLocation();
    AllUserData.setPrayers("fajr", 0);
    AllUserData.setPrayers("dhuhr", 0);
    AllUserData.setPrayers("asr", 0);
    AllUserData.setPrayers("maghrib", 0);
    AllUserData.setPrayers("isha", 0);
    AllUserData.setInstallDate(DateTime.now().toString());
    print("Succesfully added prayer times");
    AllUserData.setPrayers('source', 4);
    // calcMethod = AllUserData.getPrayers('source');
    AllUserData.setPrayers('madhab', 0);
    // asrMethod = AllUserData.getPrayers('madhab');
    AllUserData.setInteget('loop', 0);
  }

  late String? city;
  late String? country;
  void getLocation() async {
    // final service = UsersLocation();
    // final locationData = await service.getLocation();
    // if (locationData != null) {
    //   city = locationData.first;
    //   country = locationData.last;
    //   await AllUserData.setLocationData(city!, 'city');
    //   await AllUserData.setLocationData(country!, 'country');
    //   print('all location saved');
    // }
  }

  final AnonymousSignInProvider _provider = AnonymousSignInProvider();
  bool pressed = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20.0),
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
                ElevatedButton(
                  style: ButtonStyle(
                      elevation:
                          MaterialStateProperty.resolveWith((states) => 3),
                      shadowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.black),
                      minimumSize: MaterialStateProperty.resolveWith(
                          (states) => const Size(100, 60)),
                      backgroundColor:
                          MaterialStateColor.resolveWith((states) => colorStr)),
                  onPressed: () async {
                    print('started');
                    dynamic res = await _provider.signIn();
                    if (res == null) {
                      print('error');
                    } else {
                      print("success");
                      setState(() {});
                    }
                  },
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
