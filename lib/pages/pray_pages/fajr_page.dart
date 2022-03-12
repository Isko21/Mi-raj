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
      extendBodyBehindAppBar: true,
      appBar: AppBarCustom(
        title: "Fajr",
        page: Pages.prayer,
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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: colorStr,
        child: SafeArea(
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(right: 15, left: 15),
            children: <Widget>[
              Description(
                text: 'Багымдат',
                isArab: isArabic,
              ),
              Solatan(
                  bis: false,
                  arab: afterSalamAR,
                  rus: afterSalamRU,
                  isArab: isArabic,
                  desk: afterSalamDesk,
                  align: TextAlign.center),
              Nav(
                  textAr:
                      "After saying that, the Solatan Tunjina prayer below is read by raising the hands up.",
                  textRu: afterSalamDesk,
                  isArabic: isArabic),
              Solatan(
                  bis: false,
                  arab: solatanAR,
                  rus: solatanRU,
                  desk: solatanDesk,
                  isArab: isArabic,
                  align: TextAlign.center),
              /*Nav(
                text: navAferSolatan,
                isArabic: isArabic,
              ),*/
              Solatan(
                  bis: false,
                  arab: nukaddimuAR,
                  rus: nukaddimuRU,
                  isArab: isArabic,
                  desk: nukaddimuDesk,
                  align: TextAlign.center),
              Counter(
                  max: 10, ar: shahaadaAR, isArabic: isArabic, ru: shahaadaRU),
              Solatan(
                  bis: false,
                  arab: uaIlayhilAR,
                  rus: uaIlayhilRU,
                  isArab: isArabic,
                  desk: uaIlayhilDesk,
                  align: TextAlign.center),
              /*Nav(
                text: navAfteruaIlayhil,
                isArabic: isArabic,
              ),*/
              Counter(max: 7, ar: azhirnaAR, isArabic: isArabic, ru: azhirnaRU),
              Solatan(
                  bis: false,
                  arab: azhirnaLongAR,
                  rus: azhirnaLongRU,
                  isArab: isArabic,
                  desk: azhirnaLongDesk,
                  align: TextAlign.start),
              Counter(
                  max: 3, ar: biawfikaAR, isArabic: isArabic, ru: biawfikaRU),
              Solatan(
                  bis: false,
                  arab: adhilnaAR,
                  rus: adhilnaRU,
                  isArab: isArabic,
                  desk: adhilnaDesk,
                  align: TextAlign.center),
              /* Nav(
                text: navAferAdhilna,
                isArabic: isArabic,
              ),*/
              Solatan(
                  bis: false,
                  arab: subhanAllohiAR,
                  rus: subhanAllohiRU,
                  isArab: isArabic,
                  desk: subhanAllohiDesk,
                  align: TextAlign.center),
              Solatan(
                  bis: true,
                  arab: ayatulKursiAR,
                  rus: ayatulKursiRU,
                  isArab: isArabic,
                  desk: ayatulKursiDesk,
                  align: TextAlign.center),
              /* Nav(
                text: navAfterAyatulKursi,
                isArabic: isArabic,
              ),*/
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
                  isArab: isArabic,
                  desk: uahdahuDesk,
                  align: TextAlign.center),
              Solatan(
                  bis: false,
                  arab: falamAR,
                  isArab: isArabic,
                  rus: falamRU,
                  desk: falamDesk,
                  align: TextAlign.center),
              Solatan(
                  bis: false,
                  arab: lailahaAR,
                  isArab: isArabic,
                  rus: lailahaRU,
                  desk: lailahaDesk,
                  align: TextAlign.center),
              Solatan(
                  bis: false,
                  arab: MuhammadAR,
                  rus: MuhammadRU,
                  desk: MuhammadDesk,
                  isArab: isArabic,
                  align: TextAlign.center),
              Solatan(
                  bis: true,
                  arab: innAllohAR,
                  isArab: isArabic,
                  rus: innAllohRU,
                  desk: innAllohDesk,
                  align: TextAlign.center),
              Solatan(
                  bis: true,
                  isArab: isArabic,
                  arab: subhanakaYaaAllah,
                  rus: "",
                  desk: "dsa",
                  align: TextAlign.center)
            ],
          ),
        ),
      ),
    );
  }
}
