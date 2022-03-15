import 'package:daily_muslim/animations/bottom_animation.dart';
import 'package:daily_muslim/components/appbar.dart';
import 'package:daily_muslim/components/properties.dart';
import 'package:daily_muslim/controller/quran_controller.dart';
import 'package:daily_muslim/widgets/loading_shimmer.dart';
import 'package:daily_muslim/model/sajda/sajda.dart';
import 'package:daily_muslim/model/sajda/sajda_list.dart';
import 'package:daily_muslim/view/sajda/sajda.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SajdaIndex extends StatefulWidget {
  const SajdaIndex({Key? key}) : super(key: key);

  @override
  State<SajdaIndex> createState() => _SajdaIndexState();
}

class _SajdaIndexState extends State<SajdaIndex> {
  final _hive = Hive.box('data');
  List<SajdaAyat>? _sajdas = [];

  @override
  void initState() {
    _getSajdaData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBarCustom(change: () {}, title: "Sajda", page: Pages.home),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              _sajdas!.isEmpty
                  ? const LoadingShimmer(
                      text: "Sajdas",
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.separated(
                        itemCount: _sajdas!.length,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemBuilder: (context, index) {
                          return WidgetAnimator(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: color),
                                  color: color.withAlpha(50),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: ListTile(
                                onLongPress: () => _sajdaInfoBox(index),
                                leading: Text(
                                  "${_sajdas![index].sajdaNumber}",
                                  style: TextStyle(fontSize: 17),
                                ),
                                title: Text(
                                  "${_sajdas![index].surahEnglishName}",
                                  style: TextStyle(fontSize: 18),
                                ),
                                subtitle: Text(
                                  "${_sajdas![index].englishNameTranslation}",
                                ),
                                trailing: Text(
                                  "${_sajdas![index].surahName}",
                                  style: TextStyle(fontSize: 19),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SajdaAyah(
                                        surahName: _sajdas![index].surahName,
                                        surahEnglishName:
                                            _sajdas![index].surahEnglishName,
                                        englishNameTranslation: _sajdas![index]
                                            .englishNameTranslation,
                                        juz: _sajdas![index].juzNumber,
                                        manzil: _sajdas![index].manzilNumber,
                                        ruku: _sajdas![index].rukuNumber,
                                        sajdaAyahs: _sajdas![index].text,
                                        sajdaNumber:
                                            _sajdas![index].sajdaNumber,
                                        revelationType:
                                            _sajdas![index].revelationType,
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

  // gettin data
  Future<void> _getSajdaData() async {
    SajdaList? _cacheSajdaList = await _hive.get('sajdaList');

    if (_cacheSajdaList == null || _cacheSajdaList.sajdaAyahs!.isEmpty) {
      SajdaList _newSajdaList = await QuranAPI.getSajda();

      if (mounted) {
        setState(() {
          _sajdas = _newSajdaList.sajdaAyahs;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _sajdas = _cacheSajdaList.sajdaAyahs;
        });
      }
    }
  }

  void _sajdaInfoBox(int index) {
    showDialog(
      context: context,
      builder: (_) => SajdaInformation(
        juzNumber: _sajdas![index].juzNumber,
        rukuNumber: _sajdas![index].rukuNumber,
        sajdaNumber: _sajdas![index].sajdaNumber,
        surahName: _sajdas![index].surahName,
        surahEnglishName: _sajdas![index].surahEnglishName,
        englishNameTranslation: _sajdas![index].englishNameTranslation,
        revelationType: _sajdas![index].revelationType,
      ),
    );
  }
}

class SajdaInformation extends StatefulWidget {
  final int? sajdaNumber;
  final String? surahName;
  final String? surahEnglishName;
  final String? englishNameTranslation;
  final int? juzNumber;
  final int? rukuNumber;
  final String? revelationType;

  const SajdaInformation(
      {Key? key,
      this.surahName,
      this.sajdaNumber,
      this.juzNumber,
      this.rukuNumber,
      this.surahEnglishName,
      this.englishNameTranslation,
      this.revelationType})
      : super(key: key);

  @override
  _SajdaInformationState createState() => _SajdaInformationState();
}

class _SajdaInformationState extends State<SajdaInformation>
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
            height: height * 0.39,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  "Sajda Information",
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.surahEnglishName!,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      widget.surahName!,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                Text("Sajda Number: ${widget.sajdaNumber}"),
                Text("Juz Number: ${widget.juzNumber}"),
                Text("Ruku Number: ${widget.rukuNumber}"),
                Text("Meaning: ${widget.englishNameTranslation}"),
                Text("Chapter Type: ${widget.revelationType}"),
                SizedBox(
                  height: height * 0.025,
                ),
                SizedBox(
                  height: height * 0.05,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(color)),
                    onPressed: () => Navigator.pop(context),
                    child: const Text("OK"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
