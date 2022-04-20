import 'dart:async';
import 'dart:math' show pi;
import 'package:daily_muslim/components/appbar.dart';
import 'package:daily_muslim/components/properties.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';

import '../../components/location_error.dart';

class QiblaCompass extends StatefulWidget {
  @override
  _QiblaCompassState createState() => _QiblaCompassState();
}

class _QiblaCompassState extends State<QiblaCompass> {
  final _locationStreamController =
      StreamController<LocationStatus>.broadcast();

  get stream => _locationStreamController.stream;

  @override
  void initState() {
    _checkLocationStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: 'Qibla', elevation: 1),
      backgroundColor: black.withAlpha(50),
      body: Container(
        color: color.withAlpha(50),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: stream,
          builder: (context, AsyncSnapshot<LocationStatus> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return CircularProgressIndicator.adaptive();
            if (snapshot.data?.enabled == true) {
              switch (snapshot.data?.status) {
                case LocationPermission.always:
                case LocationPermission.whileInUse:
                  return QiblahCompassWidget();

                case LocationPermission.denied:
                  return LocationErrorWidget(
                    error: "Location service permission denied",
                    callback: _checkLocationStatus,
                  );
                case LocationPermission.deniedForever:
                  return LocationErrorWidget(
                    error: "Location service Denied Forever !",
                    callback: _checkLocationStatus,
                  );
                // case GeolocationStatus.unknown:
                //   return LocationErrorWidget(
                //     error: "Unknown Location service error",
                //     callback: _checkLocationStatus,
                //   );
                default:
                  return Container();
              }
            } else {
              return LocationErrorWidget(
                error: "Please enable Location service",
                callback: _checkLocationStatus,
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> _checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled &&
        locationStatus.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      _locationStreamController.sink.add(s);
    } else
      _locationStreamController.sink.add(locationStatus);
  }

  @override
  void dispose() {
    super.dispose();
    _locationStreamController.close();
    FlutterQiblah().dispose();
  }
}

class QiblahCompassWidget extends StatelessWidget {
  final _kaabaSvg = SvgPicture.asset('assets/img/kaaba_qibla.svg');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FlutterQiblah.qiblahStream,
      builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return CircularProgressIndicator.adaptive();

        final qiblahDirection = snapshot.data;
        var _angle = ((qiblahDirection!.qiblah) * (pi / 180) * -1);
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Transform.rotate(
              angle: _angle,
              child: SvgPicture.asset('assets/img/circle.svg', // compass
                  color: color),
            ),
            _kaabaSvg,
            SvgPicture.asset('assets/img/pointer.svg', //needle
                color: color),
          ],
        );
      },
    );
  }
}
