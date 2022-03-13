import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../components/appbar.dart';
import '../../components/properties.dart';

class ComingSoon extends StatelessWidget {
  final String title;
  const ComingSoon({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: white,
        //appBar: AppBarCustom(change: () {}, title: title, page: Pages.settings),
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                snap: false,
                floating: false,
                iconTheme: IconThemeData(color: colorStr),
                expandedHeight: height * 0.4,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    'Coming Soon',
                    style: TextStyle(color: colorStr),
                  ),
                  background: Image.asset('assets/img/read_quran.jpg',
                      fit: BoxFit.cover),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((_, int index) {
                  return ListTile(
                    leading: Icon(FontAwesomeIcons.quran),
                    title: Text(
                      "Surah ${index + 1}",
                    ),
                  );
                }, childCount: 20),
              ),
            ],
          ),
        ));
  }
}
