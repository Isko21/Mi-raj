import 'package:daily_muslim/components/properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import '../../components/appbar.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class TasbihCounter extends StatefulWidget {
  TasbihCounter({Key? key}) : super(key: key);

  @override
  State<TasbihCounter> createState() => TasbihCounterState();
}

class TasbihCounterState extends State<TasbihCounter> {
  double pointer = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black.withAlpha(50),
        appBar: AppBarCustom(title: 'Tasbih Counter', elevation: 1),
        body: Container(
            color: color.withAlpha(50),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Субханаллох'),
                Center(
                  child: InkWell(
                    onTap: () {
                      pointer++;
                      if (pointer == 33 || pointer == 66) {
                        Vibrate.feedback(FeedbackType.heavy);
                      } else if (pointer == 99) {
                        Vibrate.feedback(FeedbackType.heavy);
                        pointer = 1;
                      }
                      setState(() {});
                    },
                    child: SfRadialGauge(axes: <RadialAxis>[
                      RadialAxis(
                        minimum: 0,
                        maximum: 99,
                        annotations: [
                          GaugeAnnotation(
                              positionFactor: 0.1,
                              angle: 90,
                              widget: Text(
                                '${pointer.round().toInt()}',
                                style: TextStyle(fontSize: 40, color: white),
                              ))
                        ],
                        pointers: [
                          RangePointer(
                            value: pointer,
                            cornerStyle: CornerStyle.bothCurve,
                            width: 0.2,
                            color: white,
                            sizeUnit: GaugeSizeUnit.factor,
                          )
                        ],
                        showLabels: false,
                        showTicks: false,
                        axisLineStyle: AxisLineStyle(
                          thickness: 0.2,
                          cornerStyle: CornerStyle.bothCurve,
                          color: color,
                          thicknessUnit: GaugeSizeUnit.factor,
                        ),
                      )
                    ]),
                  ),
                ),
              ],
            )));
  }
}
