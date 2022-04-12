import 'package:daily_muslim/pages/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
import '../components/navbar.dart';
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
            '/surahIndex': (context) => const SurahIndex(),
            '/sajdaIndex': (context) => const SajdaIndex(),
            '/juzIndex': (context) => const JuzIndex(),
            '/settings': (context) => new Settings()
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
      extendBodyBehindAppBar: true,
      appBar: AppBarCustom(title: appBar, page: Pages.home, change: () {}),
      drawer: NavBar(
        state: state,
        fullname: user.displayName,
        email: user.email,
        url: user.photoURL,
      ),
      body: pages[index],
      // bottomNavigationBar: BottomNavigationBar(items: [BottomNavigationBarItem(icon: Icon)]),)
    );
  }
}
