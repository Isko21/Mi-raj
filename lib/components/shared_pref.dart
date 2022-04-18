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

  static void addPrayer(String name, int count) async {
    setPrayers(name, getPrayers(name) + count);
  }

  static void subtractPrayer(String name, int count) async {
    setPrayers(name, getPrayers(name) - count);
  }

  static double getLatitude() {
    return _preferences.getDouble("lat") ?? 0.0;
  }

  static double getLongitude() {
    return _preferences.getDouble("long") ?? 0.0;
  }

  static Future setLongitude(double value) async =>
      await _preferences.setDouble("long", value);

  static Future setLatitude(double value) async =>
      await _preferences.setDouble("lat", value);

  static Future setLocationData(String value, String key) async =>
      await _preferences.setString(key, value);

  static String getLocationData(String key) {
    return _preferences.getString(key) ?? '';
  }

  static Future setVerse(String value, String key) async =>
      await _preferences.setString(key, value);

  static String getVerse(String key) {
    return _preferences.getString(key) ?? '';
  }

  static Future setVerseDate(int value) async =>
      await _preferences.setInt('date', value);

  static int getVerseDate() {
    return _preferences.getInt('date') ?? 0;
  }

  static Future setSurahName(String value) async =>
      await _preferences.setString('surah', value);

  static String getSurahName() {
    return _preferences.getString('surah') ?? '';
  }

  static Future setVerseAudio(String value) async =>
      await _preferences.setString('audio', value);

  static String getVerseAudio() {
    return _preferences.getString('audio') ?? '';
  }

  static Future setInstallDate(String value) async =>
      await _preferences.setString('data', value);

  static String getInstallDate() {
    return _preferences.getString('data') ?? '';
  }
}
