import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PrayerTimes extends StatelessWidget {
  final String _count;
  final String _times;
  final String _value;
  PrayerTimes(
    this._count,
    this._times,
    this._value,
  );
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(_count, style: TextStyle(fontSize: 30)),
      title: Text(
        _times,
        style: TextStyle(fontSize: 30),
      ),
      // ignore: unnecessary_null_comparison
      trailing: _value != ''
          ? Text(
              _value.toString(),
              style: TextStyle(fontSize: 30),
            )
          : Icon(FontAwesomeIcons.circle),
    );
  }
}
