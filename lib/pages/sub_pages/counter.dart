import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import '../../components/appbar.dart';

class TasbihCounter extends StatefulWidget {
  TasbihCounter({Key? key}) : super(key: key);

  @override
  State<TasbihCounter> createState() => TasbihCounterState();
}

class TasbihCounterState extends State<TasbihCounter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom(title: 'Tasbih Counter'),
        body: Container(
            child: Center(
                child: SleekCircularSlider(
          min: 0,
          max: 33,
          onChange: (val) => print(val),
        ))));
  }
}
