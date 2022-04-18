import 'package:daily_muslim/pages/jawshan_page.dart';
import 'package:daily_muslim/pages/sub_pages/asmaulhusna.dart';
import 'package:daily_muslim/pages/tasbihs_page.dart';
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
import '../components/properties.dart';
import 'components/location.dart';
import 'model/juzz/juz.dart';
import 'model/sajda/sajda.dart';
import 'model/sajda/sajda_list.dart';
import 'model/surah/surah.dart';
import 'model/surah/surah_list.dart';
import 'view/juzz/juz_index.dart';
import 'package:flutter/services.dart' show rootBundle;
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
            '/tasbih': (context) => TasbihsPage()
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
    getLocation();
    getNames();
    getJawshan();
  }

  getNames() async {
    String res;
    res = await rootBundle.loadString('assets/names.txt');
    var line = res.split('.');
    for (int i = 0; i < line.length; i++) {
      names.add(AlHusna(
          tr: line[i].split('	')[3],
          eng: line[i].split('	')[2],
          ar: line[i].split('	')[1]));
    }
  }

  getJawshan() async {
    String res;
    res = await rootBundle.loadString('assets/jawshan.txt');
    var bapp = res.split('(');
    var ar = <String>[];
    var eng = <String>[];
    var tr = <String>[];
    for (int i = 1; i < bapp.length; i++) {
      for (int j = 0; j < bapp[i].split('\n').length; j++) {
        if (j == 0 || i == 0) continue;
        if ((j + 3) % 4 == 0) {
          ar.add(bapp[i].split('\n')[j]);
        } else if ((j + j) % 4 == 0) {
          eng.add(bapp[i].split('\n')[j]);
        } else {
          tr.add(bapp[i].split('\n')[j]);
        }
      }
      jawshans.add(Jawshan(tr: tr, ar: ar, eng: eng));
      ar = <String>[];
      eng = <String>[];
      tr = <String>[];
    }
  }

  void state() {
    setState(() {});
  }

  void getLocation() async {
    final service = UsersLocation();
    final locationData = await service.getLocation();
    if (locationData != null) {
      final placeMark = await service.getPlaceMark(locationData: locationData);
      try {
        setState(() {
          city = placeMark!.subLocality!;
        });
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      extendBodyBehindAppBar: true,
      appBar: appBars[index] as PreferredSizeWidget,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: color.withAlpha(50),
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        showUnselectedLabels: true,
        unselectedLabelStyle: TextStyle(color: Colors.white60),
        unselectedIconTheme: IconThemeData(color: Colors.white60),
        unselectedItemColor: white.withOpacity(0.5),
        selectedItemColor: white,
        onTap: (_index) => setState(() => index = _index),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.bookQuran), label: 'Quran'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.clock), label: 'Timings'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shield_moon), label: 'Jawshan'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person), label: 'Me')
        ],
      ),
      body: pages[index],
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: white,
        ),
        backgroundColor: color,
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
