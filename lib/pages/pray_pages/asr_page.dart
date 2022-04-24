import 'package:muslim_today/pages/pray_pages/fajr_page.dart';
import 'package:flutter/material.dart';
import 'package:muslim_today/components/appbar.dart';
import 'package:muslim_today/components/properties.dart';
import 'package:flutter/services.dart';

import '../../components/shared_pref.dart';
import '../../components/tasbih.dart';
import '../../tasbihs/duas.dart';

class Asr extends StatefulWidget {
  @override
  State<Asr> createState() => _AsrState();
}

class _AsrState extends State<Asr> {
  @override
  void initState() {
    super.initState();
    getName();
    isArabic = AllUserData.getLang();
  }

  List<String> list = <String>[];
  void getName() async {
    String res;
    res = await rootBundle.loadString('assets/subhanaka.txt');
    var line = res.split('\n');
    for (int i = 0; i < line.length; i++) {
      list.add(line[i]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBarWithSetState(
        title: "Asr",
        change: (int a) => setState(
          () {
            if (a == 1) {
              isArabic = true;
            } else
              isArabic = false;
            AllUserData.setLang(isArabic);
          },
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            Description(
              text: 'Аср',
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
            Container(
              padding: isArabic
                  ? EdgeInsets.fromLTRB(5, 0, 10, 10)
                  : EdgeInsets.fromLTRB(5, 5, 5, 10),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: isArabic
                        ? EdgeInsets.all(0)
                        : EdgeInsets.symmetric(vertical: 15),
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
                                fontFamily: 'Comfortaa')),
                  ),
                  isArabic
                      ? Text(
                          subhanakaYaaAllahAR,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.03,
                              color: black,
                              fontFamily: 'Noore'),
                        )
                      : Subhanaka(list: list),
                ],
              ),
            ),
            Nav(
                textRu: beforebiawFikaRU,
                isArabic: isArabic,
                textAr: beforebiawFikaAR),
            Solatan(
                bis: false, isArab: isArabic, arab: aahiyanAR, rus: aahiyanRU),
            Nav(textRu: subhanakaRU, isArabic: isArabic, textAr: subhanakaAR),
            Solatan(
                bis: false,
                isArab: isArabic,
                arab: uaminKulliAR,
                rus: uaminKulliRU),
            Nav(textRu: subhanakaRU, isArabic: isArabic, textAr: palmUpAR),
            Solatan(bis: false, isArab: isArabic, arab: lastAR, rus: lastRU),
            Nav(textRu: nabaDeskRU, isArabic: isArabic, textAr: nabaDeskAR),
            Solatan(bis: true, isArab: isArabic, arab: nabaAR, rus: nabaRU),
          ],
        ),
      ),
    );
  }
}
