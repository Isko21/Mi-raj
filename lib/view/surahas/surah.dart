import 'package:daily_muslim/animations/bottom_animation.dart';
import 'package:daily_muslim/components/appbar.dart';
import 'package:daily_muslim/components/properties.dart';
import 'package:daily_muslim/model/ayat/ayat.dart';
import 'package:flutter/material.dart';

class SurahAyats extends StatelessWidget {
  final List<Ayat>? ayatsList;
  final String? surahName;
  final String? surahEnglishName;
  final String? englishMeaning;
  const SurahAyats(
      {Key? key,
      this.ayatsList,
      this.englishMeaning,
      this.surahEnglishName,
      this.surahName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBarCustom(
            change: () {},
            title: surahEnglishName.toString(),
            page: Pages.home),
        backgroundColor: white,
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(),
          child: SafeArea(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index) => line(height, index, width),
                      childCount: ayatsList!.length),
                )
              ],
            ),
          ),
        ));
  }

  Widget line(double height, int index, double width) {
    return Padding(
      padding: EdgeInsets.fromLTRB(width * 0.015, 0, 0, 0),
      child: WidgetAnimator(
        child: ListTile(
          trailing: CircleAvatar(
            radius: height * 0.013,
            backgroundColor: const Color(0xff04364f),
            child: CircleAvatar(
                radius: height * 0.012,
                backgroundColor: Colors.white,
                child: Text(
                  ayatsList![index].number.toString(),
                  style: TextStyle(fontSize: height * 0.015),
                )),
          ),
          title: Text(ayatsList![index].text!,
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: height * 0.033, color: black, fontFamily: 'Noore')),
        ),
      ),
    );
  }
}
