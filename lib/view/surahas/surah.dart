import 'package:muslim_today/components/appbar.dart';
import 'package:muslim_today/components/properties.dart';
import 'package:muslim_today/model/ayat/ayat.dart';
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
      backgroundColor: white,
      appBar: AppBarCustom(title: surahEnglishName!, elevation: 1),
      body: Container(
        color: Colors.white70.withAlpha(50),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => line(height, index, width),
                  childCount: ayatsList!.length),
            ),
          ],
        ),
      ),
    );
  }

  Widget line(double height, int index, double width) {
    return Padding(
      padding: EdgeInsets.fromLTRB(width * 0.015, 0, 0, 0),
      child: Column(
        children: [
          if (index == 0 &&
              surahEnglishName! != 'Al-Faatiha' &&
              surahEnglishName! != 'At-Tawba')
            Image.asset('assets/img/bismi.png', height: 120),
          ListTile(
            trailing: CircleAvatar(
              radius: height * 0.013,
              backgroundColor: const Color(0xff04364f),
              child: CircleAvatar(
                  radius: height * 0.012,
                  backgroundColor: Colors.white,
                  child: Text(
                    ayatsList![index].number.toString(),
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: height * 0.015),
                  )),
            ),
            title: Text(
                surahEnglishName! != 'Al-Faatiha' &&
                        surahEnglishName! != 'At-Tawba'
                    ? index == 0
                        ? ayatsList![index].text!.substring(38).trim()
                        : ayatsList![index].text!
                    : ayatsList![index].text!,
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: height * 0.033,
                    color: black,
                    fontFamily: 'Noore')),
          ),
        ],
      ),
    );
  }
}
