import 'package:flutter/material.dart';

import '../../components/location.dart';
import '../../components/properties.dart';

class ComingSoon extends StatefulWidget {
  final String title;
  ComingSoon({required this.title});

  @override
  State<ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // ignore: unused_local_variable
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        //appBar: AppBarCustom(change: () {}, title: title, page: Pages.settings),
        body: Container(
      color: color.withAlpha(50),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            iconTheme: IconThemeData(color: colorStr),
            expandedHeight: height * 0.4,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Coming Soon',
                style: TextStyle(color: colorStr),
              ),
              background:
                  Image.asset('assets/img/read_quran.jpg', fit: BoxFit.cover),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((_, int index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: GestureDetector(
                  onDoubleTap: () => getLocation(),
                  child: Container(
                      padding: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Row(children: [
                        Container(
                            margin: EdgeInsets.all(10),
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                color: black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                image: DecorationImage(
                                    opacity: 0.5,
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                        'https://wallpapercave.com/wp/WpDop9T.jpg'))),
                            child: Center(
                              child: Text(
                                "Surah\n${index + 1}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 17,
                                    color: white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: TextStyle(
                                  fontSize: 19, fontWeight: FontWeight.bold),
                            ),
                            Text('The Opening', style: TextStyle(fontSize: 16))
                          ],
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'surotul al-fatihaa',
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                        Icon(Icons.abc),
                      ])),
                ),
              );
            }, childCount: 2),
          ),
        ],
      ),
    ));
  }

  String name = 'Warsawa';

  void getLocation() async {
    final service = UsersLocation();
    final locationData = await service.getLocation();
    if (locationData != null) {
      final placeMark = await service.getPlaceMark(locationData: locationData);
      try {
        setState(() {
          name = placeMark!.subLocality!;
        });
      } catch (e) {
        print(e);
      }
    }
  }
}
