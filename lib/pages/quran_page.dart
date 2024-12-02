import 'package:muslim_today/components/properties.dart';
import 'package:muslim_today/widgets/calligraphy.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/appbar.dart';

class QuranPage extends StatefulWidget {
  const QuranPage({
    Key? key,
  }) : super(key: key);
  @override
  _QuranPageState createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
  }

  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: "Mi'raj", elevation: 0),
      backgroundColor: colorBg,
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          return const MainScreen();
        },
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Calligraphy(),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CoolButton(title: "Surah", route: '/surahIndex'),
                  CoolButton(title: "Juz", route: '/juzIndex'),
                  CoolButton(title: "Sajda", route: '/sajdaIndex'),
                ],
              ),
            ),
          ),
          AyahBottom(),
        ],
      ),
    );
  }
}

class CoolButtonIcon extends StatelessWidget {
  final String image;
  final String title;
  final String route;
  const CoolButtonIcon(
      {Key? key, required this.image, required this.title, required this.route})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.resolveWith((states) => 3),
            shadowColor:
                MaterialStateColor.resolveWith((states) => Colors.black),
            minimumSize: MaterialStateProperty.resolveWith(
                (states) => const Size(100, 60)),
            backgroundColor: MaterialStateColor.resolveWith((states) => color)),
        onPressed: () => Navigator.pushNamed(context, route),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/img/$image',
              height: 50,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Icon(CupertinoIcons.right_chevron, color: white)
          ],
        ),
      ),
    );
  }
}

class CoolButton extends StatelessWidget {
  const CoolButton({Key? key, required this.title, required this.route})
      : super(key: key);
  final String title;
  final String route;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.resolveWith((states) => 3),
            shadowColor:
                MaterialStateColor.resolveWith((states) => Colors.black),
            minimumSize: MaterialStateProperty.resolveWith(
                (states) => const Size(100, 60)),
            backgroundColor: MaterialStateColor.resolveWith((states) => color)),
        onPressed: () => Navigator.pushNamed(context, route),
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class AyahBottom extends StatelessWidget {
  const AyahBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            "\"Indeed, It is We who sent down the Qur'an\nand indeed, We will be its Guardian\"\n",
            textAlign: TextAlign.center,
            style: TextStyle(color: white),
          ),
          Text(
            "Surah Al-Hijr\n",
            style: TextStyle(color: white),
          ),
        ],
      ),
    );
  }
}
