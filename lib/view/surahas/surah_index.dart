import 'package:daily_muslim/animations/bottom_animation.dart';
import 'package:daily_muslim/components/appbar.dart';
import 'package:daily_muslim/components/properties.dart';
import 'package:daily_muslim/controller/quran_controller.dart';
import 'package:daily_muslim/widgets/loading_shimmer.dart';
import 'package:daily_muslim/model/surah/surah.dart';
import 'package:daily_muslim/model/surah/surah_list.dart';
import 'package:daily_muslim/view/surahas/surah.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class SurahIndex extends StatefulWidget {
  const SurahIndex({Key? key}) : super(key: key);

  @override
  State<SurahIndex> createState() => _SurahIndexState();
}

class _SurahIndexState extends State<SurahIndex> {
  final _hiveBox = Hive.box('data');
  List<Surah>? _surahs = [];

  @override
  void initState() {
    _getSurahData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: colorStr,
      appBar: AppBarCustom(
        change: () {},
        title: "Surah",
        page: Pages.home,
      ),
      body: Container(
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              _surahs!.isEmpty
                  ? const Center(
                      child: LoadingShimmer(
                        text: "Surahs",
                      ),
                    )
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 10);
                        },
                        itemCount: _surahs!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                                color: white.withAlpha(200),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: WidgetAnimator(
                              child: ListTile(
                                onLongPress: () => _surahInforBox(index),
                                leading: Text(
                                  "${_surahs![index].number}",
                                  style: TextStyle(fontSize: 17),
                                ),
                                title: Text(
                                  "${_surahs![index].englishName}",
                                  style: TextStyle(fontSize: 18),
                                ),
                                subtitle: Text(
                                    "${_surahs![index].englishNameTranslation}"),
                                trailing: Text(
                                  "${_surahs![index].name}",
                                  style: TextStyle(fontSize: 19),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SurahAyats(
                                        ayatsList: _surahs![index].ayahs,
                                        surahName: _surahs![index].name,
                                        surahEnglishName:
                                            _surahs![index].englishName,
                                        englishMeaning: _surahs![index]
                                            .englishNameTranslation,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void _surahInforBox(int index) {
    showDialog(
      context: context,
      builder: (context) => SurahInformation(
        surahNumber: _surahs![index].number,
        arabicName: "${_surahs![index].name}",
        englishName: "${_surahs![index].englishName}",
        ayahs: _surahs![index].ayahs!.length,
        revelationType: "${_surahs![index].revelationType}",
        englishNameTranslation: "${_surahs![index].englishNameTranslation}",
      ),
    );
  }

  // getting data
  Future<void> _getSurahData() async {
    SurahsList? _cacheSurahList = await _hiveBox.get('surahList');
    if (_cacheSurahList == null || _cacheSurahList.surahs!.isEmpty) {
      SurahsList _newSurahsList = await QuranAPI.getSurahList();
      if (mounted) {
        setState(() {
          _surahs = _newSurahsList.surahs;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _surahs = _cacheSurahList.surahs;
        });
      }
    }
  }
}

class SurahInformation extends StatefulWidget {
  final int? surahNumber;
  final String? arabicName;
  final String? englishName;
  final String? englishNameTranslation;
  final int? ayahs;
  final String? revelationType;

  const SurahInformation(
      {Key? key,
      this.arabicName,
      this.surahNumber,
      this.ayahs,
      this.englishName,
      this.englishNameTranslation,
      this.revelationType})
      : super(key: key);

  @override
  _SurahInformationState createState() => _SurahInformationState();
}

class _SurahInformationState extends State<SurahInformation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ScaleTransition(
      scale: scaleAnimation,
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
            width: width * 0.75,
            height: height * 0.37,
            decoration: ShapeDecoration(
              color: Colors.grey[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Surah Information",
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.englishName!,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      widget.arabicName!,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                Text("Ayahs: ${widget.ayahs}"),
                Text("Surah Number: ${widget.surahNumber}"),
                Text("Chapter: ${widget.revelationType}"),
                Text("Meaning: ${widget.englishNameTranslation}"),
                SizedBox(
                  height: height * 0.02,
                ),
                SizedBox(
                  height: height * 0.05,
                  child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("OK")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
