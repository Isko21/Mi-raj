import 'package:daily_muslim/components/appbar.dart';
import 'package:flutter/material.dart';

import '../../components/location.dart';
import '../../components/properties.dart';

class ComingSoon extends StatefulWidget {
  final String title;
  ComingSoon({required this.title});

  @override
  State<ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom(
            change: () {}, page: Pages.jawshan, title: 'Coming Soon'),
        body: Container(color: color.withAlpha(50), child: Text("Hello")));
  }

  String name = 'Warsawa';

  void getLocation() async {
    final service = UsersLocation();
    final locationData = await service.getLocation();
    if (locationData != null) {
      final placeMark = await service.getPlaceMark(locationData: locationData);
      try {
        setState(() {
          name = placeMark!.subLocality!;
        });
      } catch (e) {
        print(e);
      }
    }
  }
}
