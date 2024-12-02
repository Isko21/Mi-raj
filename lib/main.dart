import 'package:flutter/cupertino.dart';
import 'package:ionicons/ionicons.dart';
import 'package:muslim_today/pages/home.dart';
import 'package:muslim_today/pages/sub_pages/counter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../components/auth.dart';
import '../components/firebase.dart';
import '../components/shared_pref.dart';
import '../model/ayat/ayat.dart';
import '../model/juzz/juz_list.dart';
import '../components/properties.dart';
import 'model/juzz/juz.dart';
import 'model/pray_time/prayer_time.dart';
import 'model/sajda/sajda.dart';
import 'model/sajda/sajda_list.dart';
import 'model/surah/surah.dart';
import 'model/surah/surah_list.dart';
import 'pages/pray_times.dart';
import 'pages/quran_page.dart';
import 'pages/settings.dart';
import 'package:flutter/services.dart' show rootBundle;

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
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AnonymousSignInProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PrayerTimingsProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Mi'raj",
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child!,
          );
        },
        theme: ThemeData(
          fontFamily: 'OpenSans',
          brightness: Brightness.light,
        ),
        home: const MyHomePage(),
      ),
    );
  }
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
    final prayerTimingsProvider =
        Provider.of<PrayerTimingsProvider>(context, listen: false);
    prayerTimingsProvider.fetchPrayerTimings('Warsaw', 'Poland', 3, '1');
    getNames();
    getJawshan();
  }

  final _controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: navBarScreens(),
      items: navBarsItems(),
      backgroundColor: CupertinoColors.systemBackground,
      decoration: NavBarDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        colorBehindNavBar: color,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      navBarStyle: NavBarStyle.style13,
      floatingActionButton: FloatingActionButton(
        backgroundColor: color,
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const TasbihCounter())),
        child: Icon(Icons.add, color: white),
      ),
    );
  }
}

List<PersistentBottomNavBarItem> navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home_filled),
      title: ('Home'),
      activeColorPrimary: colorBg,
      inactiveColorPrimary: CupertinoColors.inactiveGray,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(FontAwesomeIcons.bookQuran),
      title: ('Quran'),
      activeColorPrimary: colorBg,
      inactiveColorPrimary: CupertinoColors.inactiveGray,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Ionicons.time_sharp),
      title: ('Timings'),
      activeColorPrimary: colorBg,
      inactiveColorPrimary: CupertinoColors.inactiveGray,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Ionicons.menu, size: 30),
      title: ('Menu'),
      activeColorPrimary: colorBg,
      inactiveColorPrimary: CupertinoColors.inactiveGray,
    ),
  ];
}

List<Widget> navBarScreens() {
  return [
    const HomePage(),
    const QuranPage(),
    const PrayTimes(),
    const Settings(),
  ];
}

mixin CustomColor {
  static Color buttonColor = const Color(0xFF97BA85);
  static Color darkBackColor = const Color(0xFF516746);
  static Color lightBackColor = const Color(0xFFDEEAD8);
  static Color veryLightBackColor = const Color(0xFFF4F8F2);
}

class Jawshan {
  final List<String> tr;
  final List<String> ar;
  final List<String> eng;

  Jawshan({required this.tr, required this.ar, required this.eng});
}

Future<List<Jawshan>> getJawshan() async {
  final String res = await rootBundle.loadString('assets/jawshan.txt');
  final List<String> bapp = res.split('(');
  final List<Jawshan> jawshans = [];

  for (int i = 1; i < bapp.length; i++) {
    final lines = bapp[i].split('\n');

    final tr = <String>[];
    final ar = <String>[];
    final eng = <String>[];

    for (int j = 1; j < lines.length; j++) {
      final line = lines[j].trim();
      if (line.isNotEmpty) {
        if ((j + 3) % 4 == 0) {
          ar.add(line);
        } else if ((j + j) % 4 == 0) {
          eng.add(line);
        } else {
          tr.add(line);
        }
      }
    }

    jawshans.add(Jawshan(tr: tr, ar: ar, eng: eng));
  }

  return jawshans;
}

class AlHusna {
  final String tr;
  final String ar;
  final String eng;

  AlHusna({required this.tr, required this.ar, required this.eng});
}

Future<List<AlHusna>> getNames() async {
  final String res = await rootBundle.loadString('assets/names.txt');
  final List<String> lines = res.split('.');
  final List<AlHusna> names = [];

  for (int i = 0; i < lines.length; i++) {
    final fields = lines[i].split('	');
    final tr = fields[3];
    final eng = fields[2];
    final ar = fields[1];

    names.add(AlHusna(tr: tr, ar: ar, eng: eng));
  }

  return names;
}
