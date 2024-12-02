import 'package:muslim_today/components/appbar.dart';
import 'package:muslim_today/components/properties.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SajdaAyah extends StatelessWidget {
  final String? sajdaAyahs;
  final int? juz;
  final int? ruku;
  final int? manzil;
  final int? sajdaNumber;
  final String? surahName;
  final String? surahEnglishName;
  final String? englishNameTranslation;
  final String? revelationType;

  const SajdaAyah(
      {Key? key,
      this.sajdaAyahs,
      this.revelationType,
      this.juz,
      this.ruku,
      this.manzil,
      this.sajdaNumber,
      this.surahEnglishName,
      this.englishNameTranslation,
      this.surahName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBarCustom(title: surahEnglishName!, elevation: 1),
      backgroundColor: white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white70.withAlpha(50),
        child: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => <Widget>[],
          body: SafeArea(
            child: Container(
              padding: const EdgeInsets.all(5.0),
              width: width,
              height: height * 0.692,
              child: Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(height: height * 0.02),
                      Text(
                        "Sajda Ayah",
                        style: TextStyle(
                          color: black,
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      Sajda(
                        ayah: sajdaAyahs,
                        index: sajdaNumber,
                      ),
                      SizedBox(height: height * 0.03),
                      SajdaInformation(
                        juz: juz,
                        ruku: ruku,
                        revelationType: revelationType,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InfoAppBar extends StatelessWidget {
  final String? englishNameTranslation;
  final String? surahName;
  const InfoAppBar({
    Key? key,
    required this.englishNameTranslation,
    required this.surahName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(englishNameTranslation!),
          Text(
            surahName!,
            style: Theme.of(context).textTheme.displayLarge,
          )
        ],
      ),
    );
  }
}

class Sajda extends StatelessWidget {
  final int? index;
  final String? ayah;
  const Sajda({
    Key? key,
    required this.ayah,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: CircleAvatar(
        radius: MediaQuery.of(context).size.height * 0.013,
        backgroundColor: const Color(0xff04364f),
        child: CircleAvatar(
            radius: MediaQuery.of(context).size.height * 0.012,
            backgroundColor: Colors.white,
            child: Text(
              index.toString(),
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.height * 0.015,
              ),
            )),
      ),
      title: Text(
        ayah!,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.03,
            color: black,
            fontFamily: 'Noore'),
      ),
    );
  }
}

class SajdaInformation extends StatelessWidget {
  final int? juz;
  final int? ruku;
  final String? revelationType;
  const SajdaInformation({
    Key? key,
    required this.juz,
    required this.ruku,
    required this.revelationType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: colorStr,
      highlightColor: color,
      enabled: true,
      child: Column(
        children: <Widget>[
          const Text(
            "--- Sajda Info ---\n",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          InfoText(leading: 'Juz', info: juz.toString()),
          InfoText(leading: 'Ruku', info: ruku.toString()),
          InfoText(leading: 'Chapter', info: revelationType)
        ],
      ),
    );
  }
}

class InfoText extends StatelessWidget {
  final String? leading;
  final String? info;
  const InfoText({
    Key? key,
    required this.leading,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          "${leading!}: ",
          style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.of(context).size.height * 0.025,
          ),
        ),
        Text(
          info!,
          style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.height * 0.025,
              fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
