import 'package:shared_preferences/shared_preferences.dart';

class AllUserData {
  // ignore: unused_field
  static late SharedPreferences _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setPrayers(String name, int value) async =>
      await _preferences.setInt(name, value);

  static int getPrayers(String name) {
    return _preferences.getInt(name) ?? 0;
  }

  static void addPrayer(String name) async {
    setPrayers(name, getPrayers(name) + 1);
  }

  static void subtractPrayer(String name) async {
    setPrayers(name, getPrayers(name) - 1);
  }

  static String getLatitude() {
    return _preferences.getString("latitude") ?? "";
  }

  static String getLongitude() {
    return _preferences.getString("longitude") ?? "";
  }

  static Future setLongitude(String value) async =>
      await _preferences.setString("longitude", value);

  static Future setLatitude(String value) async =>
      await _preferences.setString("latitude", value);

  static Future setLocationData(String value, String key) async =>
      await _preferences.setString(key, value);

  static String getLocationData(String key) {
    return _preferences.getString(key) ?? '';
  }
}
