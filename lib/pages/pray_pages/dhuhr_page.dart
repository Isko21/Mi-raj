import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../components/properties.dart';
import '../../components/tasbih.dart';
import '../../tasbihs/duas.dart';

// ignore: must_be_immutable
class Dhuhr extends StatefulWidget {
  const Dhuhr({Key? key}) : super(key: key);

  @override
  State<Dhuhr> createState() => _DhuhrState();
}

class _DhuhrState extends State<Dhuhr> {
  bool isArabic = false;
  @override
  void initState() {
    super.initState();
    getName();
  }

  List<String> list = <String>[];
  void getName() async {
    String res;
    res = await rootBundle.loadString('assets/yaa.txt');
    var line = res.split('\n');
    for (int i = 0; i < line.length; i++) {
      list.add(line[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Description(
              text: 'Бешим',
              isArab: isArabic,
            ),
            Solatan(
                bis: false,
                arab: afterSalamAR,
                rus: afterSalamRU,
                isArab: isArabic),
            Nav(
                textAr: afterSalamDeskAR,
                textRu: afterSalamDeskRU,
                isArabic: isArabic),
            Solatan(
                bis: false, arab: solatanAR, rus: solatanRU, isArab: isArabic),
            divider(),
            Solatan(
                bis: false, isArab: isArabic, arab: salavatAR, rus: salavarRU),
            Solatan(
                bis: false,
                arab: subhanAllohiAR,
                rus: subhanAllohiRU,
                isArab: isArabic),
            Solatan(
                bis: true,
                arab: ayatulKursiAR,
                rus: ayatulKursiRU,
                isArab: isArabic),
            Counter(
                max: 33,
                ar: subhanaAllohAR,
                isArabic: isArabic,
                ru: subhanaAllohRU),
            Counter(
                max: 33,
                ar: alhamdulillahAR,
                isArabic: isArabic,
                ru: alhamdulillahRU),
            Counter(
                max: 33,
                ar: AllohuAkbarAR,
                ru: AllohuAkbarRU,
                isArabic: isArabic),
            Solatan(
                bis: false, arab: uahdahuAR, rus: uahdahuRU, isArab: isArabic),
            divider(),
            Solatan(bis: false, arab: falamAR, isArab: isArabic, rus: falamRU),
            Counter(max: 33, ar: lailahaAR, isArabic: isArabic, ru: lailahaRU),
            Solatan(
                bis: false,
                arab: MuhammadAR,
                rus: MuhammadRU,
                isArab: isArabic),
            Solatan(
                bis: true, arab: innAllohAR, isArab: isArabic, rus: innAllohRU),
            divider(),
            Solatan(
                bis: false, isArab: isArabic, arab: solliAlAR, rus: solliAlRU),
            divider(),
            Solatan(
                bis: false,
                isArab: isArabic,
                arab: afterSolliAR,
                rus: afterSolliRU),
            divider(),
            Solatan(
                bis: false,
                isArab: isArabic,
                arab: alfuAlfiAR,
                rus: alfuAlfiRU),
            divider(),
            Solatan(
                bis: false,
                isArab: isArabic,
                arab: afterAlfiAR,
                rus: afterAlfiRU),
            divider(),
            Container(
              padding: isArabic
                  ? const EdgeInsets.fromLTRB(5, 0, 10, 10)
                  : const EdgeInsets.fromLTRB(5, 5, 5, 10),
              child: Column(
                children: <Widget>[
                  if (true)
                    Padding(
                      padding: isArabic
                          ? const EdgeInsets.all(0)
                          : const EdgeInsets.symmetric(vertical: 15),
                      child: isArabic
                          ? Image.asset(
                              'assets/img/bismi.png',
                              height: 150,
                            )
                          : Text(bismiRU,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 21,
                                  fontFamily: 'OpenSans')),
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: !isArabic
                        ? Yaa(list: list)
                        : Text(
                            yaaRohmanAR,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                                fontSize: 25,
                                color: black,
                                fontFamily: 'Noore'),
                          ),
                  ),
                ],
              ),
            ),
            Nav(
                textRu: beforebiawFikaRU,
                isArabic: isArabic,
                textAr: beforebiawFikaAR),
            Solatan(
                bis: false,
                isArab: isArabic,
                arab: yaaRobbasAR,
                rus: yaaRobbasRU),
            Nav(textRu: fathDeskRU, isArabic: isArabic, textAr: fathDeskAR),
            Solatan(bis: true, isArab: isArabic, arab: fathAR, rus: fathRU),
          ],
        ),
      ),
    );
  }
}

class Yaa extends StatelessWidget {
  final List<String> list;
  const Yaa({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (String i in list)
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: '❁ Йаа ',
              style:
                  TextStyle(fontSize: 18, color: black, fontFamily: 'OpenSans'),
              children: <TextSpan>[
                TextSpan(
                  text: i.trim(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'OpenSans',
                      color: Color.fromARGB(255, 112, 7, 0)),
                ),
                TextSpan(
                  text: " йаа ",
                  style: TextStyle(
                      fontSize: 18, fontFamily: 'OpenSans', color: black),
                ),
                const TextSpan(
                  text: 'Аллаах\n',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      fontFamily: 'OpenSans',
                      color: Color.fromARGB(255, 112, 7, 0)),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
