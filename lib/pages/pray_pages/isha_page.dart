import 'package:flutter/material.dart';
import 'package:daily_muslim/components/appbar.dart';
import '../../components/properties.dart';
import '../../components/tasbih.dart';
import '../../tasbihs/duas.dart';

class Isha extends StatefulWidget {
  @override
  State<Isha> createState() => _IshaState();
}

class _IshaState extends State<Isha> {
  bool isArabic = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarCustom(
            title: "Isha",
            page: Pages.prayer,
            change: (int a) {
              setState(() {
                if (a == 1) {
                  isArabic = true;
                } else {
                  isArabic = false;
                }
              });
            }),
        body: Container(
          color: color.withAlpha(50),
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
              Solatan(
                  bis: false,
                  isArab: isArabic,
                  arab: yaaRohmanAR,
                  rus: yaaRohmanRU),
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
