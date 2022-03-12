import 'package:flutter/material.dart';

class PrayerList extends StatelessWidget {
  const PrayerList(this.num, this.time);
  final int num;
  final String time;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 20,
      contentPadding: EdgeInsets.only(left: 70, right: 18),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        size: 22,
        color: Colors.cyan,
      ),
      leading: Text(
        num.toString() + '.',
        style: TextStyle(
            fontWeight: FontWeight.w300, fontSize: 20, color: Colors.white),
      ),
      title: Text(
        time,
        style: TextStyle(
            fontWeight: FontWeight.w300, fontSize: 20, color: Colors.white),
      ),
    );
  }
}
