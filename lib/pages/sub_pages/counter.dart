import 'package:muslim_today/components/properties.dart';
import 'package:muslim_today/components/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../animations/bottom_animation.dart';
import '../../tasbihs/duas.dart';

class TasbihCounter extends StatefulWidget {
  TasbihCounter({Key? key}) : super(key: key);

  @override
  State<TasbihCounter> createState() => TasbihCounterState();
}

class TasbihCounterState extends State<TasbihCounter>
    with SingleTickerProviderStateMixin {
  double pointer = 0;
  double slider = 0;
  @override
  void initState() {
    super.initState();
    loop = AllUserData.getInteger('loop');
    tabController = new TabController(length: 2, vsync: this);
  }

  late TabController tabController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black.withAlpha(50),
      appBar: AppBar(
          centerTitle: true,
          elevation: 1,
          backgroundColor: colorStr,
          bottom: TabBar(
            controller: tabController,
            tabs: [
              WidgetAnimator(child: Tab(text: 'Classic')),
              WidgetAnimator(
                child: Tab(
                  text: 'Infinity',
                  icon: Icon(FontAwesomeIcons.infinity),
                ),
              )
            ],
          ),
          title: WidgetAnimator(
            child: Text('Tasbih Counter',
                style: TextStyle(
                    color: white, fontWeight: FontWeight.bold, fontSize: 31)),
          )),
      body: TabBarView(
        controller: tabController,
        children: [
          Container(
            color: color.withAlpha(50),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (pointer <= 32)
                  Column(
                    children: [
                      WidgetAnimator(
                        child: Text(
                          subhanaAllohAR,
                          style: TextStyle(
                              color: white, fontSize: 28, fontFamily: 'Noore'),
                        ),
                      ),
                      WidgetAnimator(
                        child: Text(
                          subhanaAllohRU,
                          style: TextStyle(color: white, fontSize: 21),
                        ),
                      ),
                    ],
                  )
                else if (pointer >= 33 && pointer <= 65)
                  Column(
                    children: [
                      WidgetAnimator(
                        child: Text(
                          alhamdulillahAR,
                          style: TextStyle(
                              color: white, fontSize: 28, fontFamily: 'Noore'),
                        ),
                      ),
                      WidgetAnimator(
                        child: Text(
                          alhamdulillahRU,
                          style: TextStyle(color: white, fontSize: 21),
                        ),
                      ),
                    ],
                  )
                else if (pointer >= 66 && pointer <= 98)
                  Column(
                    children: [
                      WidgetAnimator(
                        child: Text(
                          AllohuAkbarAR,
                          style: TextStyle(
                              color: white, fontSize: 28, fontFamily: 'Noore'),
                        ),
                      ),
                      WidgetAnimator(
                        child: Text(
                          AllohuAkbarRU,
                          style: TextStyle(color: white, fontSize: 21),
                        ),
                      )
                    ],
                  )
                else if (pointer > 98)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: WidgetAnimator(
                          child: Text(
                            'آَاِلٰهَ اِلاَّاللّٰهُ وَحْدَهُ لاَشَرِ يكَ لَهُ لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ وَهُوَ عَلٰى كُلِّ شَىْءٍقَدِيرٌ',
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: white,
                                fontSize: 25,
                                fontFamily: 'Noore'),
                          ),
                        ),
                      ),
                      WidgetAnimator(
                        child: Text(
                          "Лаа илааха иллаллооху вахдахуу лаа шарийка лах, ва хува 'алаа кулли  шай-ин кодиир.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: white, fontSize: 17),
                        ),
                      )
                    ],
                  ),
                Center(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        pointer++;
                        if (pointer == 33 || pointer == 66 || pointer == 99) {
                          Vibrate.feedback(FeedbackType.heavy);
                        } else if (pointer == 101) {
                          Vibrate.feedback(FeedbackType.heavy);
                          pointer = 1;
                          loop++;
                          AllUserData.setInteget('loop', loop);
                          loop = AllUserData.getInteger('loop');
                        }
                      });
                    },
                    child: SfRadialGauge(axes: <RadialAxis>[
                      RadialAxis(
                        minimum: 0,
                        maximum: 100,
                        annotations: [
                          GaugeAnnotation(
                              positionFactor: 0.1,
                              angle: 90,
                              widget: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  WidgetAnimator(
                                    child: Text(
                                      '${pointer.round().toInt()}',
                                      style:
                                          TextStyle(fontSize: 40, color: white),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  WidgetAnimator(
                                    child: Text(
                                      'loop: $loop',
                                      textAlign: TextAlign.center,
                                      style:
                                          TextStyle(fontSize: 25, color: white),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                        pointers: [
                          RangePointer(
                            value: pointer,
                            cornerStyle: CornerStyle.bothFlat,
                            width: 0.2,
                            color: white,
                            sizeUnit: GaugeSizeUnit.factor,
                          )
                        ],
                        showLabels: false,
                        showTicks: false,
                        axisLineStyle: AxisLineStyle(
                          thickness: 0.2,
                          cornerStyle: CornerStyle.bothFlat,
                          color: color,
                          thicknessUnit: GaugeSizeUnit.factor,
                        ),
                      )
                    ]),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              slider++;
              if (slider == 33) {
                Vibrate.feedback(FeedbackType.heavy);
                slider = 1;
                AllUserData.setInteget('loop', ++loop);
                loop = AllUserData.getInteger('loop');
              }

              setState(() {});
            },
            child: Container(
              color: color.withAlpha(50),
              child: Center(
                child: Container(
                  height: 350,
                  child: SfRadialGauge(
                    axes: <RadialAxis>[
                      RadialAxis(
                        minimum: 0,
                        maximum: 33,
                        labelsPosition: ElementsPosition.inside,
                        labelFormat: '$slider',
                        showLabels: false,
                        showTicks: false,
                        startAngle: 270,
                        endAngle: 270,
                        axisLineStyle: AxisLineStyle(
                          thickness: 0.15,
                          color: color,
                          thicknessUnit: GaugeSizeUnit.factor,
                        ),
                        annotations: [
                          GaugeAnnotation(
                              positionFactor: 0.1,
                              angle: 90,
                              widget: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  WidgetAnimator(
                                    child: Text(
                                      '${slider.round().toInt()}',
                                      style:
                                          TextStyle(fontSize: 50, color: white),
                                    ),
                                  ),
                                ],
                              ))
                        ],
                        pointers: <GaugePointer>[
                          RangePointer(
                            value: slider,
                            width: 0.15,
                            color: white,
                            sizeUnit: GaugeSizeUnit.factor,
                            cornerStyle: CornerStyle.bothCurve,
                          ),
                          MarkerPointer(
                            value: slider,
                            color: black,
                            markerType: MarkerType.circle,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
