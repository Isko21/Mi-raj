import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class PrayerTimingsProvider with ChangeNotifier {
  String? _fajr;
  String? _sunrise;
  String? _dhuhr;
  String? _asr;
  String? _sunset;
  String? _maghrib;
  String? _isha;
  String? _imsak;
  String? _midnight;
  PrayerTimings? _prayerTimings;
  PrayerDate? _prayerDate;

  String? get fajr => _fajr;
  String? get sunrise => _sunrise;
  String? get dhuhr => _dhuhr;
  String? get asr => _asr;
  String? get sunset => _sunset;
  String? get maghrib => _maghrib;
  String? get isha => _isha;
  String? get imsak => _imsak;
  String? get midnight => _midnight;
  PrayerTimings? get prayerTimings => _prayerTimings;

  Future<void> fetchPrayerTimings(
      String city, String country, int method, String school) async {
    try {
      final formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
      final response = await http.get(Uri.parse(
          'https://api.aladhan.com/v1/timingsByCity/$formattedDate?city=$city&country=$country&method=$method&school=$school'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final prayerTimings = PrayerTimings.fromJson(data['data']);

        // Store the fetched prayer timings and date
        _prayerTimings = prayerTimings;
        _prayerDate = prayerTimings.data!.date;

        notifyListeners();
      } else {
        // Handle API error
        print('Failed to fetch prayer timings: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network or decoding errors
      print('Failed to fetch prayer timings: $error');
    }
  }

  String getCurrentPrayerTime() {
    final now = DateTime.now();

    // Get the current prayer timings
    final timings = _prayerTimings?.data?.timings;

    if (timings != null) {
      // Convert the prayer timings to DateTime objects
      final fajrTime =
          DateTime.parse('${_prayerDate?.gregorian.date} ${timings.fajr}');
      final sunriseTime =
          DateTime.parse('${_prayerDate?.gregorian.date} ${timings.sunrise}');
      final dhuhrTime =
          DateTime.parse('${_prayerDate?.gregorian.date} ${timings.dhuhr}');
      final asrTime =
          DateTime.parse('${_prayerDate?.gregorian.date} ${timings.asr}');
      final maghribTime =
          DateTime.parse('${_prayerDate?.gregorian.date} ${timings.maghrib}');
      final ishaTime =
          DateTime.parse('${_prayerDate?.gregorian.date} ${timings.isha}');

      // Determine the current prayer
      if (now.isBefore(fajrTime)) {
        return 'Fajr';
      } else if (now.isBefore(sunriseTime)) {
        return 'Sunrise';
      } else if (now.isBefore(dhuhrTime)) {
        return 'Dhuhr';
      } else if (now.isBefore(asrTime)) {
        return 'Asr';
      } else if (now.isBefore(maghribTime)) {
        return 'Maghrib';
      } else if (now.isBefore(ishaTime)) {
        return 'Isha';
      } else {
        return 'Midnight';
      }
    }

    return 'Unknown';
  }
}

class PrayerTimings {
  final int code;
  final String status;
  final PrayerTimingsData? data;

  PrayerTimings({
    required this.code,
    required this.status,
    this.data,
  });

  factory PrayerTimings.fromJson(Map<String, dynamic> json) {
    return PrayerTimings(
      code: json['code'],
      status: json['status'],
      data: json['data'] != null
          ? PrayerTimingsData.fromJson(json['data'])
          : null,
    );
  }
}

class PrayerTimingsData {
  final Timings timings;
  final PrayerDate date;

  PrayerTimingsData({
    required this.timings,
    required this.date,
  });

  factory PrayerTimingsData.fromJson(Map<String, dynamic> json) {
    return PrayerTimingsData(
      timings: Timings.fromJson(json['timings']),
      date: PrayerDate.fromJson(json['date']),
    );
  }
}

class Timings {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String sunset;
  final String maghrib;
  final String isha;
  final String imsak;
  final String midnight;
  final String firstThird;
  final String lastThird;

  Timings({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.sunset,
    required this.maghrib,
    required this.isha,
    required this.imsak,
    required this.midnight,
    required this.firstThird,
    required this.lastThird,
  });

  factory Timings.fromJson(Map<String, dynamic> json) {
    return Timings(
      fajr: json['Fajr'],
      sunrise: json['Sunrise'],
      dhuhr: json['Dhuhr'],
      asr: json['Asr'],
      sunset: json['Sunset'],
      maghrib: json['Maghrib'],
      isha: json['Isha'],
      imsak: json['Imsak'],
      midnight: json['Midnight'],
      firstThird: json['Firstthird'],
      lastThird: json['Lastthird'],
    );
  }
}

class PrayerDate {
  final String readable;
  final String timestamp;
  final HijriDate hijri;
  final GregorianDate gregorian;

  PrayerDate({
    required this.readable,
    required this.timestamp,
    required this.hijri,
    required this.gregorian,
  });

  factory PrayerDate.fromJson(Map<String, dynamic> json) {
    return PrayerDate(
      readable: json['readable'],
      timestamp: json['timestamp'],
      hijri: HijriDate.fromJson(json['hijri']),
      gregorian: GregorianDate.fromJson(json['gregorian']),
    );
  }
}

class HijriDate {
  final String date;
  final String format;
  final String day;
  final Weekday weekday;
  final Month month;
  final String year;
  final Designation designation;
  final List<String> holidays;

  HijriDate({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
    required this.holidays,
  });

  factory HijriDate.fromJson(Map<String, dynamic> json) {
    return HijriDate(
      date: json['date'],
      format: json['format'],
      day: json['day'],
      weekday: Weekday.fromJson(json['weekday']),
      month: Month.fromJson(json['month']),
      year: json['year'],
      designation: Designation.fromJson(json['designation']),
      holidays: List<String>.from(json['holidays']),
    );
  }
}

class Weekday {
  final String en;
  final String ar;

  Weekday({
    required this.en,
    required this.ar,
  });

  factory Weekday.fromJson(Map<String, dynamic> json) {
    return Weekday(
      en: json['en'],
      ar: json['ar'],
    );
  }
}

class Month {
  final int number;
  final String en;
  final String ar;

  Month({
    required this.number,
    required this.en,
    required this.ar,
  });

  factory Month.fromJson(Map<String, dynamic> json) {
    return Month(
      number: json['number'],
      en: json['en'],
      ar: json['ar'],
    );
  }
}

class Designation {
  final String abbreviated;
  final String expanded;

  Designation({
    required this.abbreviated,
    required this.expanded,
  });

  factory Designation.fromJson(Map<String, dynamic> json) {
    return Designation(
      abbreviated: json['abbreviated'],
      expanded: json['expanded'],
    );
  }
}

class GregorianDate {
  final String date;
  final String format;
  final String day;
  final Weekday weekday;
  final Month month;
  final String year;
  final Designation designation;

  GregorianDate({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
  });

  factory GregorianDate.fromJson(Map<String, dynamic> json) {
    return GregorianDate(
      date: json['date'],
      format: json['format'],
      day: json['day'],
      weekday: Weekday.fromJson(json['weekday']),
      month: Month.fromJson(json['month']),
      year: json['year'],
      designation: Designation.fromJson(json['designation']),
    );
  }
}
