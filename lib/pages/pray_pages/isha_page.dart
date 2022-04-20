import 'package:daily_muslim/pages/pray_pages/dhuhr_page.dart';
import 'package:flutter/material.dart';
import 'package:daily_muslim/components/appbar.dart';
import 'package:flutter/services.dart';
import '../../components/properties.dart';
import '../../components/shared_pref.dart';
import '../../components/tasbih.dart';
import '../../tasbihs/duas.dart';

class Isha extends StatefulWidget {
  @override
  State<Isha> createState() => _IshaState();
}

class _IshaState extends State<Isha> {
  @override
  void initState() {
    super.initState();
    getName();
    isArabic = AllUserData.getLang();
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
        appBar: AppBarWithSetState(
            title: "Isha",
            change: (int a) {
              setState(() {
                if (a == 1) {
                  isArabic = true;
                } else {
                  isArabic = false;
                }
                AllUserData.setLang(isArabic);
              });
            }),
        body: Container(
          color: white.withAlpha(100),
          child: ListView(
            children: <Widget>[
              Description(
                text: 'Куптан',
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
                  bis: false,
                  arab: solatanAR,
                  rus: solatanRU,
                  isArab: isArabic),
              divider(),
              Solatan(
                  bis: false,
                  isArab: isArabic,
                  arab: salavatAR,
                  rus: salavarRU),
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
                  bis: false,
                  arab: uahdahuAR,
                  rus: uahdahuRU,
                  isArab: isArabic),
              divider(),
              Solatan(
                  bis: false, arab: falamAR, isArab: isArabic, rus: falamRU),
              Counter(
                  max: 33, ar: lailahaAR, isArabic: isArabic, ru: lailahaRU),
              Solatan(
                  bis: false,
                  arab: MuhammadAR,
                  rus: MuhammadRU,
                  isArab: isArabic),
              Solatan(
                  bis: true,
                  arab: innAllohAR,
                  isArab: isArabic,
                  rus: innAllohRU),
              divider(),
              Solatan(
                  bis: false,
                  isArab: isArabic,
                  arab: solliAlAR,
                  rus: solliAlRU),
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
                                    color: black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 21,
                                    fontFamily: 'Comfortaa')),
                      ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
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
              Nav(
                  textRu: bakaraDeskRU,
                  isArabic: isArabic,
                  textAr: bakaraDeskAR),
              Solatan(
                  bis: true, isArab: isArabic, arab: bakaraAR, rus: bakaraRU)
            ],
          ),
        ));
  }
}
