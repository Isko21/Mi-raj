import 'dart:io' show Platform;
import 'package:apple_sign_in_safety/apple_sign_in.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:muslim_today/components/shared_pref.dart';
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
    AllUserData.setInstallDate(DateTime.now().toString());
    print("Succesfully added prayer times");
    AllUserData.setPrayers('source', 4);
    calcMethod = AllUserData.getPrayers('source');
    AllUserData.setPrayers('madhab', 0);
    asrMethod = AllUserData.getPrayers('madhab');
    AllUserData.setInteget('loop', 0);
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

  final AnonymousSignInProvider _provider = AnonymousSignInProvider();
  bool pressed = false;
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
                !pressed
                    ? ElevatedButton.icon(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.resolveWith(
                                (states) => 3),
                            shadowColor: MaterialStateColor.resolveWith(
                                (states) => Colors.black),
                            minimumSize: MaterialStateProperty.resolveWith(
                                (states) => Size(100, 60)),
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => color)),
                        onPressed: () {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.googleLogIn();
                          setState(() {
                            pressed = !pressed;
                          });
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
                        ))
                    : ElevatedButton(
                        style: ButtonStyle(
                            elevation: MaterialStateProperty.resolveWith(
                                (states) => 3),
                            shadowColor: MaterialStateColor.resolveWith(
                                (states) => Colors.black),
                            minimumSize: MaterialStateProperty.resolveWith(
                                (states) => Size(100, 60)),
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => color)),
                        onPressed: () {},
                        child: CircularProgressIndicator.adaptive(
                          valueColor: AlwaysStoppedAnimation<Color>(white),
                        ),
                      ),
                SizedBox(height: 10.0),
                if (Platform.isIOS)
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
                      if (!await AppleSignIn.isAvailable()) {
                        return;
                      }
                      final res = await AppleSignIn.performRequests([
                        AppleIdRequest(
                            requestedScopes: [Scope.email, Scope.fullName])
                      ]);
                      switch (res.status) {
                        case AuthorizationStatus.authorized:
                          try {
                            final AppleIdCredential appleIdCredential =
                                res.credential!;
                            final OAuthProvider oAuthProvider =
                                OAuthProvider('apple.com');
                            final credential = oAuthProvider.credential(
                                idToken: String.fromCharCodes(
                                    appleIdCredential.identityToken!),
                                accessToken: String.fromCharCodes(
                                    appleIdCredential.authorizationCode!));
                            final result = await FirebaseAuth.instance
                                .signInWithCredential(credential);
                            result.user!.displayName;
                          } on PlatformException catch (e) {
                            print(e);
                          } on FirebaseAuthException catch (e) {
                            print(e);
                          }
                          break;
                        case AuthorizationStatus.error:
                          print('break');
                          break;
                        case AuthorizationStatus.cancelled:
                          print('cancelled');
                          break;
                      }
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.apple,
                    ),
                    label: Text(
                      'Sign in with Apple',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                if (Platform.isIOS) SizedBox(height: 10.0),
                ElevatedButton.icon(
                    style: ButtonStyle(
                        elevation:
                            MaterialStateProperty.resolveWith((states) => 3),
                        shadowColor: MaterialStateColor.resolveWith(
                            (states) => Colors.black),
                        minimumSize: MaterialStateProperty.resolveWith(
                            (states) => Size(100, 60)),
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => colorStr)),
                    onPressed: () async {
                      print('started');
                      dynamic res = await _provider.signIn();
                      if (res == null) {
                        print('error');
                      } else {
                        print("success");
                        setState(() {
                          AllUserData.setBool('guest', true);
                          isGuest = AllUserData.getBool('guest');
                        });
                      }
                    },
                    icon: FaIcon(FontAwesomeIcons.userSecret),
                    label: Text(
                      "Sign in as a Guest",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
