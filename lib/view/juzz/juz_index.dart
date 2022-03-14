import 'package:daily_muslim/animations/bottom_animation.dart';
import 'package:daily_muslim/components/appbar.dart';
import 'package:daily_muslim/components/properties.dart';
import 'package:daily_muslim/controller/quran_controller.dart';
import 'package:daily_muslim/view/juzz/juz.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class JuzIndex extends StatefulWidget {
  const JuzIndex({Key? key}) : super(key: key);

  @override
  State<JuzIndex> createState() => _JuzIndexState();
}

class _JuzIndexState extends State<JuzIndex> {
  // hive main box
  final _hive = Hive.box('data');

  // getting all Juz once!
  Future<void> _getAllJuzHiveBox() async {
    bool? _check = await _hive.get('isJuzIndexed');

    // putting values
    if (_check == null || !_check) {
      for (int i = 1; i <= 30; i++) {
        // create box
        await QuranAPI.getJuzz(i);
      }
      await _hive.put('isJuzIndexed', true);
    }
  }

  @override
  void initState() {
    _getAllJuzHiveBox();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBarCustom(change: () {}, title: "Juzz", page: Pages.home),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: colorStr),
        child: SafeArea(
            child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: GridView.builder(
                itemCount: 30,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) {
                  return WidgetAnimator(
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Juz(juzIndex: index + 1),
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: white.withAlpha(200),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(fontSize: 21),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        )),
      ),
    );
  }
}
