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
      backgroundColor: white,
      appBar: AppBarCustom(change: () {}, title: "Juzs", page: Pages.home),
      body: Container(
        child: SafeArea(
            child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          border: Border.all(color: color),
                          color: color.withAlpha(50),
                          borderRadius: BorderRadius.circular(10.0),
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
