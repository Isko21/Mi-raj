import 'package:muslim_today/components/appbar.dart';
import 'package:muslim_today/components/properties.dart';
import 'package:muslim_today/controller/quran_controller.dart';
import 'package:muslim_today/widgets/loading_shimmer.dart';
import 'package:muslim_today/model/sajda/sajda.dart';
import 'package:muslim_today/model/sajda/sajda_list.dart';
import 'package:muslim_today/view/sajda/sajda.dart';
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
      backgroundColor: black.withAlpha(50),
      appBar: AppBarCustom(title: "Sajda", elevation: 1),
      body: Container(
        color: color.withAlpha(50),
        child: SafeArea(
          child: Stack(
            children: <Widget>[
              _sajdas!.isEmpty
                  ? const LoadingShimmer(
                      text: "Sajdas",
                    )
                  : ListView.separated(
                      itemCount: _sajdas!.length,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 0);
                      },
                      itemBuilder: (context, index) {
                        return InkWell(
                          onLongPress: () => _sajdaInfoBox(index),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SajdaAyah(
                                surahName: _sajdas![index].surahName,
                                surahEnglishName:
                                    _sajdas![index].surahEnglishName,
                                englishNameTranslation:
                                    _sajdas![index].englishNameTranslation,
                                juz: _sajdas![index].juzNumber,
                                manzil: _sajdas![index].manzilNumber,
                                ruku: _sajdas![index].rukuNumber,
                                sajdaAyahs: _sajdas![index].text,
                                sajdaNumber: _sajdas![index].sajdaNumber,
                                revelationType: _sajdas![index].revelationType,
                              ),
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            decoration: BoxDecoration(
                                border: Border.all(color: black),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 20.0,
                                      offset: Offset(5, 5)),
                                  BoxShadow(color: Colors.white)
                                ],
                                color: white,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                              color: black,
                                              image: const DecorationImage(
                                                fit: BoxFit.cover,
                                                opacity: 0.5,
                                                image: AssetImage(
                                                    'assets/img/quran_page.jpg'),
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20))),
                                          child: Center(
                                              child: Text(
                                            "${_sajdas![index].sajdaNumber}",
                                            style: getStyle(
                                                21, Colors.white54, true),
                                          ))),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${_sajdas![index].surahEnglishName}",
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                          Text(
                                            "${_sajdas![index].englishNameTranslation}",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    _sajdas![index]
                                        .surahName!
                                        .substring(7)
                                        .trim(),
                                    style: const TextStyle(
                                        fontSize: 19, fontFamily: 'Noore'),
                                  ),
                                ]),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  // gettin data
  Future<void> _getSajdaData() async {
    SajdaList? cacheSajdaList = await _hive.get('sajdaList');

    if (cacheSajdaList == null || cacheSajdaList.sajdaAyahs!.isEmpty) {
      SajdaList newSajdaList = await QuranAPI.getSajda();

      if (mounted) {
        setState(() {
          _sajdas = newSajdaList.sajdaAyahs;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _sajdas = cacheSajdaList.sajdaAyahs;
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
                Text("Sajda Information",
                    style: Theme.of(context).textTheme.headlineSmall),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.surahEnglishName!,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      widget.surahName!,
                      style: Theme.of(context).textTheme.bodyLarge,
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
