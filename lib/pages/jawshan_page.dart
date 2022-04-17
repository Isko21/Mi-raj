import 'package:flutter/material.dart';
import 'package:daily_muslim/components/properties.dart';

class JawshanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: color.withAlpha(50),
      child: ListView.builder(
          itemCount: jawshans[0].eng.length,
          itemBuilder: (context, index) {
            return Text(
              jawshans[0].eng[index],
              style: TextStyle(fontSize: 20, color: white),
            );
          }),
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
