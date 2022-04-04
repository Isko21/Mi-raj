import 'package:daily_muslim/animations/bottom_animation.dart';
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
      backgroundColor: white,
      body: Container(
        child: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                iconTheme: IconThemeData(color: colorStr),
                expandedHeight: height * 0.3,
                backgroundColor: white,
                pinned: true,
                floating: false,
                flexibleSpace: FlexibleSpaceBar(
                  title: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      surahEnglishName!,
                      style: TextStyle(color: colorStr),
                    ),
                  ),
                  centerTitle: true,
                  background: ClipRRect(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(20)),
                    child: Image.asset(
                      'assets/img/reading.jpg',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                    (context, index) => line(height, index, width),
                    childCount: ayatsList!.length),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget line(double height, int index, double width) {
    return Padding(
      padding: EdgeInsets.fromLTRB(width * 0.015, 0, 0, 0),
      child: WidgetAnimator(
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
      ),
    );
  }
}
