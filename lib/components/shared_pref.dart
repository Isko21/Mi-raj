import 'package:shared_preferences/shared_preferences.dart';

class AllUserData {
  static late SharedPreferences _preferences;

  static Future<void> init() async =>
      _preferences = await SharedPreferences.getInstance();

  static void setPrayers(String name, int value) =>
      _preferences.setInt(name, value);

  static int getPrayers(String name) => _preferences.getInt(name) ?? 0;

  static void setBool(String key, bool value) =>
      _preferences.setBool(key, value);

  static bool getBool(String key) => _preferences.getBool(key) ?? false;

  static void addPrayer(String name, int count) =>
      setPrayers(name, getPrayers(name) + count);

  static void subtractPrayer(String name, int count) =>
      setPrayers(name, getPrayers(name) - count);

  static void setLocationData(String value, String key) =>
      _preferences.setString(key, value);

  static String getLocationData(String key) =>
      _preferences.getString(key) ?? '';

  static void setVerse(String value, String key) =>
      _preferences.setString(key, value);

  static String getVerse(String key) => _preferences.getString(key) ?? '';

  static void setVerseDate(int value) => _preferences.setInt('date', value);

  static int getVerseDate() => _preferences.getInt('date') ?? 0;

  static void setSurahName(String value) =>
      _preferences.setString('surah', value);

  static String getSurahName() => _preferences.getString('surah') ?? '';

  static void setVerseAudio(String value) =>
      _preferences.setString('audio', value);

  static String getVerseAudio() => _preferences.getString('audio') ?? '';

  static void setInstallDate(String value) =>
      _preferences.setString('data', value);

  static String getInstallDate() => _preferences.getString('data') ?? '';

  static void setLang(bool lang) => _preferences.setBool('lang', lang);

  static bool getLang() => _preferences.getBool('lang') ?? true;

  static void setInteget(String key, int value) =>
      _preferences.setInt(key, value);

  static int getInteger(String key) => _preferences.getInt(key) ?? 0;
}
