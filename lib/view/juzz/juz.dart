import 'package:daily_muslim/animations/bottom_animation.dart';
import 'package:daily_muslim/components/appbar.dart';
import 'package:daily_muslim/components/properties.dart';
import 'package:daily_muslim/controller/quran_controller.dart';
import 'package:daily_muslim/widgets/loading_shimmer.dart';
import 'package:daily_muslim/model/juzz/juz.dart';
import 'package:daily_muslim/model/juzz/juz_list.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class Juz extends StatefulWidget {
  final int? juzIndex;
  const Juz({Key? key, this.juzIndex}) : super(key: key);

  @override
  State<Juz> createState() => _JuzState();
}

class _JuzState extends State<Juz> {
  final _hive = Hive.box('data');
  List<JuzAyahs>? _juzAyahs = [];

  @override
  void initState() {
    _getJuzData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(title: widget.juzIndex.toString(), elevation: 1),
      backgroundColor: white,
      body: Container(
        color: Colors.white70.withAlpha(50),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: NestedScrollView(
          headerSliverBuilder:
              (BuildContext context, bool innerBoxIsScrolled) => <Widget>[],
          body: _juzAyahs!.isEmpty
              ? const Center(
                  child: LoadingShimmer(
                    text: 'Juz ayahs...',
                  ),
                )
              : JuzAyahsBuilder(
                  juzAyahs: _juzAyahs,
                  juzIndex: widget.juzIndex,
                ),
        ),
      ),
    );
  }

  // getting data
  Future<void> _getJuzData() async {
    JuzList? _cacheJuzList = await _hive.get('juzList${widget.juzIndex}');

    if (_cacheJuzList == null || _cacheJuzList.juzAyahs!.isEmpty) {
      JuzList _newJuzList = await QuranAPI.getJuzz(widget.juzIndex);

      if (mounted) {
        setState(() {
          _juzAyahs = _newJuzList.juzAyahs;
        });
      }
    } else {
      if (mounted) {
        setState(() {
          _juzAyahs = _cacheJuzList.juzAyahs;
        });
      }
    }
  }
}

class JuzAyahsBuilder extends StatelessWidget {
  final List<JuzAyahs>? juzAyahs;
  final int? juzIndex;
  const JuzAyahsBuilder({
    Key? key,
    required this.juzAyahs,
    required this.juzIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: juzAyahs!.length,
      itemBuilder: (context, index) {
        return WidgetAnimator(
          child: ListTile(
            title: Text(juzAyahs![index].ayahsText ?? '',
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    color: black,
                    fontFamily: 'Noore')),
            trailing: CircleAvatar(
              radius: MediaQuery.of(context).size.height * 0.018,
              backgroundColor: const Color(0xff04364f),
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.height * 0.017,
                backgroundColor: Colors.white,
                child: Text(
                  juzAyahs![index].ayahNumber.toString(),
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.0135),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CustomFlexibleAppBar extends StatelessWidget {
  final List<JuzAyahs>? juzAyahs;
  final int? juzIndex;
  const CustomFlexibleAppBar({
    Key? key,
    required this.juzAyahs,
    required this.juzIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlexibleSpaceBar(
      centerTitle: true,
      title: Text(
        "Juzz No. $juzIndex",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: MediaQuery.of(context).size.height * 0.03,
        ),
      ),
      background: Stack(
        children: <Widget>[
          const QuranImage(),
          InforAppBar(
            juzAyahs: juzAyahs,
            juzIndex: juzIndex,
          )
        ],
      ),
    );
  }
}

class InforAppBar extends StatelessWidget {
  final List<JuzAyahs>? juzAyahs;
  final int? juzIndex;
  const InforAppBar({
    Key? key,
    required this.juzAyahs,
    required this.juzIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("Starting Surah"),
          juzAyahs!.isEmpty
              ? const Text('')
              : Text(
                  juzAyahs![juzIndex!].surahName ?? '',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.045),
                ),
        ],
      ),
    );
  }
}

class QuranImage extends StatelessWidget {
  const QuranImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Opacity(
        opacity: 0.3,
        child: Image.asset(
          'assets/quranRail.png',
          height: MediaQuery.of(context).size.height * 0.4,
        ),
      ),
    );
  }
}
