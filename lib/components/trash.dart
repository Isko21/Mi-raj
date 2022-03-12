// ListTile(
//               leading: Icon(
//                 Icons.time_to_leave,
//                 color: white,
//               ),
//               title: Theme(
//                 data: Theme.of(context).copyWith(
//                   dividerColor: Colors.transparent,
//                 ),
//                 child: ExpansionTile(
//                   collapsedTextColor: Colors.white,
//                   collapsedIconColor: Colors.white,
//                   iconColor: Colors.white,
//                   textColor: Colors.white,
//                   expandedAlignment: Alignment.center,
//                   expandedCrossAxisAlignment: CrossAxisAlignment.end,
//                   title: Text(
//                     'Prayer Times',
//                   ),
//                   children: <Widget>[
//                     ListTile(
//                       leading: Text('1', style: TextStyle(color: white)),
//                       title: Text('Fajr', style: TextStyle(color: white)),
//                       trailing: Icon(Icons.arrow_right, color: white),
//                       onTap: () {
//                         Navigator.pop(context);

//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => new Fajr()));
//                       },
//                     ),
//                     ListTile(
//                       leading: Text('2', style: TextStyle(color: white)),
//                       title: Text('Dhuhr', style: TextStyle(color: white)),
//                       trailing: Icon(Icons.arrow_right, color: white),
//                       onTap: () {
//                         Navigator.pop(context);

//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => new Dhuhr()));
//                       },
//                     ),
//                     ListTile(
//                       leading: Text('3', style: TextStyle(color: white)),
//                       title: Text('Asr', style: TextStyle(color: white)),
//                       trailing: Icon(Icons.arrow_right, color: white),
//                       onTap: () {
//                         Navigator.pop(context);

//                         Navigator.of(context).push(
//                             MaterialPageRoute(builder: (context) => new Asr()));
//                       },
//                     ),
//                     ListTile(
//                       leading: Text('4', style: TextStyle(color: white)),
//                       title: Text('Maghrib', style: TextStyle(color: white)),
//                       trailing: Icon(Icons.arrow_right, color: white),
//                       onTap: () {
//                         Navigator.pop(context);

//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => new Maghrib()));
//                       },
//                     ),
//                     ListTile(
//                       leading: Text('5', style: TextStyle(color: white)),
//                       title: Text('Isha', style: TextStyle(color: white)),
//                       trailing: Icon(Icons.arrow_right, color: white),
//                       onTap: () {
//                         Navigator.pop(context);
//                         Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => new Isha()));
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               onTap: () => Navigator.pop(context),
//             ),





/*
onTap: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.logOut();
              },
*/