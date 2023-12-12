import 'package:muslim_today/components/appbar.dart';
import 'package:muslim_today/components/properties.dart';
import 'package:muslim_today/controller/quran_controller.dart';
import 'package:muslim_today/view/juzz/juz.dart';
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
    bool? check = await _hive.get('isJuzIndexed');

    // putting values
    if (check == null || !check) {
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
      backgroundColor: black.withAlpha(50),
      appBar: AppBarCustom(title: "Juzs", elevation: 1),
      body: Container(
        color: color.withAlpha(50),
        child: SafeArea(
            child: Stack(
          children: <Widget>[
            GridView.builder(
              itemCount: 30,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Juz(juzIndex: index + 1),
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: black),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black,
                              blurRadius: 20.0,
                              offset: Offset(5, 5)),
                          BoxShadow(color: Colors.white)
                        ],
                        color: black,
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          opacity: 0.5,
                          image: AssetImage('assets/img/quran_page.jpg'),
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "${index + 1}",
                        style: const TextStyle(
                            fontSize: 21,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        )),
      ),
    );
  }
}
