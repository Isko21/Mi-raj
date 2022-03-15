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
        color: white,
        child: SafeArea(
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
                  isArab: isArabic,
                  desk: afterSalamDesk),
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
                  isArab: isArabic),
              /*Nav(
                text: navAferSolatan,
                isArabic: isArabic,
              ),*/
              Solatan(
                  bis: false,
                  arab: nukaddimuAR,
                  rus: nukaddimuRU,
                  isArab: isArabic,
                  desk: nukaddimuDesk),
              Counter(
                  max: 10, ar: shahaadaAR, isArabic: isArabic, ru: shahaadaRU),
              Solatan(
                  bis: false,
                  arab: uaIlayhilAR,
                  rus: uaIlayhilRU,
                  isArab: isArabic,
                  desk: uaIlayhilDesk),
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
                  desk: azhirnaLongDesk),
              Counter(
                  max: 3, ar: biawfikaAR, isArabic: isArabic, ru: biawfikaRU),
              Solatan(
                  bis: false,
                  arab: adhilnaAR,
                  rus: adhilnaRU,
                  isArab: isArabic,
                  desk: adhilnaDesk),
              /* Nav(
                text: navAferAdhilna,
                isArabic: isArabic,
              ),*/
              Solatan(
                  bis: false,
                  arab: subhanAllohiAR,
                  rus: subhanAllohiRU,
                  isArab: isArabic,
                  desk: subhanAllohiDesk),
              Solatan(
                  bis: true,
                  arab: ayatulKursiAR,
                  rus: ayatulKursiRU,
                  isArab: isArabic,
                  desk: ayatulKursiDesk),
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
                  desk: uahdahuDesk),
              Solatan(
                  bis: false,
                  arab: falamAR,
                  isArab: isArabic,
                  rus: falamRU,
                  desk: falamDesk),
              Counter(
                  max: 33, ar: lailahaAR, isArabic: isArabic, ru: lailahaRU),
              Solatan(
                  bis: false,
                  arab: MuhammadAR,
                  rus: MuhammadRU,
                  desk: MuhammadDesk,
                  isArab: isArabic),
              Solatan(
                  bis: false,
                  isArab: isArabic,
                  arab: afterMuhammadAR,
                  rus: afterMuhammadRU,
                  desk: afterMuhammadDesk),
              Solatan(
                  bis: true,
                  arab: innAllohAR,
                  isArab: isArabic,
                  rus: innAllohRU,
                  desk: innAllohDesk),
              Solatan(
                  bis: true,
                  isArab: isArabic,
                  arab: subhanakaYaaAllahAR,
                  rus: subhanakaYaaAllahRU,
                  desk: '')
            ],
          ),
        ),
      ),
    );
  }
}
