import 'package:flutter/material.dart';
import 'package:daily_muslim/components/appbar.dart';
import 'package:daily_muslim/components/properties.dart';
import 'package:flutter/services.dart';

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
      backgroundColor: Colors.green.withAlpha(100),
      appBar: AppBarWithSetState(
        title: "Asr",
        change: (int a) => setState(
          () {
            if (a == 1)
              isArabic = true;
            else
              isArabic = false;
          },
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: white.withAlpha(100),
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
                  if (true)
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
                                  color: white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 21,
                                  fontFamily: 'Comfortaa')),
                    ),
                  if (isArabic)
                    Text(
                      subhanakaYaaAllahAR,
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.03,
                          color: white,
                          fontFamily: 'Noore'),
                    )
                  else
                    for (String i in list)
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: '❁ Субхаанака йаа ',
                          style: TextStyle(
                              fontSize: 18, color: white, fontFamily: 'Roboto'),
                          children: <TextSpan>[
                            TextSpan(
                              text: '«${i.split(' ').first.trim()}»',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'Comfortaa',
                                  color: red),
                            ),
                            TextSpan(
                              text: " та'аалайта йаа ",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Robot',
                                  color: white),
                            ),
                            TextSpan(
                              text: '«${i.split(' ').last.trim()}»',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  fontFamily: 'Comfortaa',
                                  color: red),
                            ),
                            TextSpan(
                              text:
                                  " ажирнаа минан наар би 'афвика йаа Рохмаан.\n",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Roboto',
                                  color: white),
                            ),
                          ],
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
