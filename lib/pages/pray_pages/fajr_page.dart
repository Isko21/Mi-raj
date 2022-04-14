import 'package:flutter/material.dart';
import 'package:daily_muslim/components/appbar.dart';
import '/components/tasbih.dart';
import '/tasbihs/duas.dart';
import '../../components/properties.dart';

class Fajr extends StatefulWidget {
  @override
  _FajrState createState() => _FajrState();
}

class _FajrState extends State<Fajr> {
  bool isArabic = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithSetState(
        title: "Fajr",
        change: (int a) {
          setState(() {
            if (a == 1) {
              isArabic = true;
            } else {
              isArabic = false;
            }
          });
        },
      ),
      body: Container(
        color: color.withAlpha(50),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Description(
              text: 'Багымдат',
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
                bis: false,
                arab: nukaddimuAR,
                rus: nukaddimuRU,
                isArab: isArabic),
            Counter(
                max: 10, ar: shahaadaAR, isArabic: isArabic, ru: shahaadaRU),
            Solatan(
                bis: false,
                arab: uaIlayhilAR,
                rus: uaIlayhilRU,
                isArab: isArabic),
            Nav(
                isArabic: isArabic,
                textAr: uaIlayhilDeskAR,
                textRu: uaIlayhilDeskRU),
            Counter(max: 7, ar: azhirnaAR, isArabic: isArabic, ru: azhirnaRU),
            Nav(
                textRu: azhirnaDeskRU,
                isArabic: isArabic,
                textAr: azhirnaDeskAR),
            Solatan(
                bis: false,
                arab: azhirnaLongAR,
                rus: azhirnaLongRU,
                isArab: isArabic),
            Nav(
                textRu: beforebiawFikaRU,
                isArabic: isArabic,
                textAr: beforebiawFikaAR),
            Solatan(
                bis: false,
                isArab: isArabic,
                arab: biawfikaAR,
                rus: biawfikaRU),
            Counter(
                max: 3, ar: maalAbrorAR, isArabic: isArabic, ru: maalAbrorRU),
            Solatan(
                bis: false, arab: adhilnaAR, rus: adhilnaRU, isArab: isArabic),
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
            Counter(
                max: 10,
                isArabic: isArabic,
                ar: afterMuhammadAR,
                ru: afterMuhammadRU),
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
            Solatan(
                bis: true,
                isArab: isArabic,
                arab: subhanakaYaaAllahAR,
                rus: subhanakaYaaAllahRU),
            divider(),
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
            Nav(textRu: khashrDeskRU, isArabic: isArabic, textAr: khashrDeskAR),
            Solatan(bis: true, isArab: isArabic, arab: khashrAR, rus: khashrRU),
          ],
        ),
      ),
    );
  }
}
