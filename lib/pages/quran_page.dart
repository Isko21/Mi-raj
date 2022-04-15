import 'package:daily_muslim/animations/bottom_animation.dart';
import 'package:daily_muslim/components/properties.dart';
import 'package:daily_muslim/widgets/calligraphy.dart';
import 'package:flutter/material.dart';

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
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: color.withAlpha(50),
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, _) {
          return Container(
            child: MainScreen(),
          );
        },
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Calligraphy(),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CoolButton(title: "Surah", route: '/surahIndex'),
                  CoolButton(title: "Juz", route: '/juzIndex'),
                  CoolButton(title: "Sajda", route: '/sajdaIndex'),
                ],
              ),
            ),
          ),
          const AyahBottom(),
        ],
      ),
    );
  }
}

class CoolButton extends StatelessWidget {
  CoolButton({Key? key, required this.title, required this.route})
      : super(key: key);
  final String title;
  final String route;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: ElevatedButton(
        style: ButtonStyle(
            elevation: MaterialStateProperty.resolveWith((states) => 3),
            shadowColor:
                MaterialStateColor.resolveWith((states) => Colors.black),
            minimumSize:
                MaterialStateProperty.resolveWith((states) => Size(100, 60)),
            backgroundColor: MaterialStateColor.resolveWith((states) => color)),
        onPressed: () => Navigator.pushNamed(context, route),
        child: WidgetAnimator(
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
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
