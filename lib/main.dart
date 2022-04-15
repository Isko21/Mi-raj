import 'package:daily_muslim/pages/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import '../components/auth.dart';
import '../components/firebase.dart';
import '../components/shared_pref.dart';
import '../model/ayat/ayat.dart';
import '../model/juzz/juz_list.dart';
import '../pages/pray_pages/asr_page.dart';
import '../pages/pray_pages/dhuhr_page.dart';
import '../pages/pray_pages/fajr_page.dart';
import '../pages/pray_pages/isha_page.dart';
import '../pages/pray_pages/maghrib_page.dart';
import '../view/sajda/sajda_index.dart';
import '../components/appbar.dart';
import '../components/properties.dart';
import 'model/juzz/juz.dart';
import 'model/sajda/sajda.dart';
import 'model/sajda/sajda_list.dart';
import 'model/surah/surah.dart';
import 'model/surah/surah_list.dart';
import 'view/juzz/juz_index.dart';
import 'view/surahas/surah_index.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<Ayat>(AyatAdapter());
  Hive.registerAdapter<JuzList>(JuzListAdapter());
  Hive.registerAdapter<JuzAyahs>(JuzAyahsAdapter());
  Hive.registerAdapter<SajdaList>(SajdaListAdapter());
  Hive.registerAdapter<SajdaAyat>(SajdaAyatAdapter());
  Hive.registerAdapter<SurahsList>(SurahsListAdapter());
  Hive.registerAdapter<Surah>(SurahAdapter());
  await Hive.openBox('data');
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AllUserData.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => GoogleSignInProvider(),
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/fajr': (context) => Fajr(),
            '/asr': (context) => Asr(),
            '/dhuhr': (context) => Dhuhr(),
            '/maghrib': (context) => Maghrib(),
            '/isha': (context) => Isha(),
            '/surahIndex': (context) => SurahIndex(),
            '/sajdaIndex': (context) => SajdaIndex(),
            '/juzIndex': (context) => JuzIndex(),
            '/settings': (context) => Settings()
          },
          debugShowCheckedModeBanner: false,
          title: 'Daily Muslim',
          theme: ThemeData(
            fontFamily: 'Comfortaa',
            brightness: Brightness.light,
          ),
          home: MyHomePage(),
        ),
      );
}

class LoggedIn extends StatefulWidget {
  const LoggedIn({
    Key? key,
  }) : super(key: key);

  @override
  State<LoggedIn> createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {
  @override
  void initState() {
    super.initState();
  }

  void state() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      extendBodyBehindAppBar: true,
      appBar: AppBarCustom(title: appBar),
      // drawer: NavBar(
      //   state: state,
      //   fullname: user.displayName,
      //   email: user.email,
      //   url: user.photoURL,
      // ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: color.withAlpha(50),
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        showUnselectedLabels: false,
        unselectedLabelStyle: TextStyle(color: Colors.white70),
        unselectedIconTheme: IconThemeData(color: Colors.white70),
        fixedColor: white,
        onTap: (_index) => setState(() {
          index = _index;
          switch (index) {
            case 0:
              appBar = 'Home';
              break;
            case 1:
              appBar = 'Quran';
              break;
            case 2:
              appBar = 'Prayer Times';
              break;
            case 3:
              appBar = 'Jawshan';
              break;
            case 4:
              appBar = 'Settings';
              break;
          }
        }),
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.home,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.bookQuran,
              ),
              label: 'Quran'),
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.clock,
              ),
              label: 'Times'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shield_moon,
              ),
              label: 'Jawshan'),
          BottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.person,
              ),
              label: 'Me')
        ],
      ),

      body: pages[index],
      // bottomNavigationBar: BottomNavigationBar(items: [BottomNavigationBarItem(icon: Icon)]),)
    );
  }
}
