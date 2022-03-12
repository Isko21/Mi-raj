import 'package:flutter/material.dart';
import 'package:daily_muslim/components/properties.dart';

import '../animations/bottom_animation.dart';

class HelloBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: WidgetAnimator(
              child: Text(
                "Assalamu alaikum, " + firstName.toString(),
                style: TextStyle(
                    color: white, fontSize: 23, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            child: Column(children: [
              WidgetAnimator(
                child: Text(
                  'Pray every day, even a little bit.',
                  style: TextStyle(color: white, fontSize: 21),
                ),
              ),
              WidgetAnimator(
                child: Text(
                  "You'll see the difference it makes.",
                  style: TextStyle(color: white, fontSize: 21),
                ),
              ),
            ]),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 10.0, left: 8, right: 8, bottom: 4),
            child: WidgetAnimator(
              child: Text(
                "Indeed, prayer prohibits immorality and wrongdoing, and the remembrance of Allah is greater.",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: white, fontSize: 15, fontStyle: FontStyle.italic),
              ),
            ),
          ),
          WidgetAnimator(
            child: Text(
              " - The Holy Quran",
              style: TextStyle(
                  color: white, fontSize: 15.5, fontStyle: FontStyle.italic),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: WidgetAnimator(
              child: Text(
                "Surah 29 Verse 45",
                style: TextStyle(
                    color: white, fontSize: 14, fontStyle: FontStyle.italic),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
