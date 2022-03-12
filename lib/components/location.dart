import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;

class UsersLocation {
  late Location _location;
  bool isEnabled = false;
  PermissionStatus? _status;
  UsersLocation() {
    _location = Location();
  }

  Future<bool> checkPermission() async {
    if (await checkService()) {
      _status = await _location.hasPermission();
      if (_status == PermissionStatus.denied) {
        _status = await _location.requestPermission();
      }
    }
    return _status == PermissionStatus.granted;
  }

  Future<bool> checkService() async {
    try {
      isEnabled = await _location.serviceEnabled();
      if (!isEnabled) {
        isEnabled = await _location.requestService();
      }
    } on PlatformException catch (err) {
      print(err.message);
      isEnabled = false;
      await checkService();
    }
    return isEnabled;
  }

  Future<LocationData?> getLocation() async {
    if (await checkPermission()) {
      final locationData = _location.getLocation();
      return locationData;
    }
    return null;
  }

  Future<geo.Placemark?> getPlaceMark(
      {required LocationData locationData}) async {
    final List<geo.Placemark> placeMarks = await geo.placemarkFromCoordinates(
      locationData.latitude!,
      locationData.longitude!,
    );
    // ignore: unnecessary_null_comparison
    if (placeMarks != null && placeMarks.isNotEmpty) {
      return placeMarks[0];
    }
    return null;
  }
}
