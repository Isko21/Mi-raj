import 'package:muslim_today/pages/sub_pages/qibla_compass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';

class QiblaDirection extends StatelessWidget {
  QiblaDirection({Key? key}) : super(key: key);
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _deviceSupport,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(
              strokeWidth: 2,
            ),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error.toString()}'),
          );
        }
        if (snapshot.hasData) {
          return const QiblaCompass();
        } else {
          return const Text('Error');
        }
      },
    );
  }
}
