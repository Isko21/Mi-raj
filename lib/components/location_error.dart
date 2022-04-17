// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class LocationErrorWidget extends StatelessWidget {
  final String error;
  final Function callback;

  const LocationErrorWidget(
      {Key? key, required this.error, required this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = SizedBox(height: 32);
    final errorColor = Color(0xffb00020);

    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.location_off,
              size: 150,
              color: errorColor,
            ),
            box,
            Text(
              error,
              style: TextStyle(color: errorColor, fontWeight: FontWeight.bold),
            ),
            box,
            RaisedButton(
              child: Text("Retry"),
              onPressed: () => callback(),
            )
          ],
        ),
      ),
    );
  }
}
