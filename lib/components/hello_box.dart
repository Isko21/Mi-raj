import 'package:flutter/material.dart';
import 'package:muslim_today/components/properties.dart';

class HelloBox extends StatelessWidget {
  const HelloBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                "Assalamu alaikum",
                style: TextStyle(
                  color: white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Column(
                children: [
                  Text(
                    'Pray every day, even a little bit.',
                    style: TextStyle(color: white, fontSize: 21),
                  ),
                  Text(
                    "You'll see the difference it makes.",
                    style: TextStyle(color: white, fontSize: 21),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, left: 8, right: 8, bottom: 4),
              child: Text(
                "Indeed, prayer prohibits immorality and wrongdoing, and the remembrance of Allah is greater.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: white,
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Text(
              " - The Holy Quran",
              style: TextStyle(
                color: white,
                fontSize: 15.5,
                fontStyle: FontStyle.italic,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Surah 29 Verse 45",
                style: TextStyle(
                  color: white,
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
