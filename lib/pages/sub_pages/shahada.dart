import 'package:flutter/material.dart';
import 'package:muslim_today/components/appbar.dart';
import 'package:muslim_today/components/properties.dart';

class Shahada extends StatelessWidget {
  const Shahada({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      appBar: AppBarCustom(
        elevation: 1,
        title: 'Shahada',
      ),
      body: Container(
          color: color.withAlpha(50),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 300,
                  child: Image.asset('assets/img/shahada.png'),
                ),
                Text(
                  'أَشْهَدُ أَنْ لَا إِلَٰهَ إِلَّا ٱللَّٰهُ وَأَشْهَدُ أَنَّ مُحَمَّدًا رَسُولُ ٱللَّٰهِ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: white, fontFamily: 'Noore', fontSize: 26),
                ),
                Text(
                    'Ashadu an la ilaha illa illa-ilah, wa ashadu anna muhammadan rasul ullah.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: white, fontSize: 20))
              ],
            ),
          )),
    );
  }
}
