import 'package:card_swiper/card_swiper.dart';
import 'package:daily_muslim/animations/bottom_animation.dart';
import 'package:flutter/material.dart';
import 'package:daily_muslim/components/properties.dart';

class JawshanPage extends StatefulWidget {
  @override
  State<JawshanPage> createState() => _JawshanPageState();
}

class _JawshanPageState extends State<JawshanPage> {
  double currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color.withAlpha(50),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(children: <Widget>[
        Expanded(
          child: Swiper(
            scrollDirection: Axis.horizontal,
            curve: Curves.ease,
            layout: SwiperLayout.DEFAULT,
            controller: SwiperController(),
            loop: false,
            onIndexChanged: (i) =>
                setState(() => currentIndex = (i).toDouble()),
            itemCount: jawshans.length - 1,
            itemBuilder: (context, i) => ListView.builder(
                itemCount: jawshans[currentIndex.toInt()].eng.length,
                itemBuilder: (context, index) {
                  return WidgetAnimator(
                    child: Text(
                      jawshans[currentIndex.toInt()].eng[index],
                      style: TextStyle(fontSize: 18, color: white),
                    ),
                  );
                }),
          ),
        ),
        Container(
          height: 70,
          child: Column(
            children: [
              Text(
                '${(currentIndex + 1).round()}',
                style: TextStyle(color: white),
              ),
              Slider(
                max: 100,
                divisions: 20,
                min: 1,
                label: currentIndex.round().toString(),
                value: currentIndex + 1,
                onChanged: (val) {
                  setState(() {
                    currentIndex = val;
                  });
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

String bap = '';

class Jawshan {
  final List<String> eng;
  final List<String> tr;
  final List<String> ar;
  int bap = 0;

  Jawshan({required this.tr, required this.ar, required this.eng}) {
    bap++;
  }
}

List<Jawshan> jawshans = <Jawshan>[];
