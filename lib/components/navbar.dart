import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/properties.dart';

// ignore: must_be_immutable
class NavBar extends StatefulWidget {
  final email;
  final fullname;
  final url;
  final Function state;
  NavBar(
      {Key? key,
      required this.state,
      required this.fullname,
      required this.email,
      required this.url});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: colorStr,
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: color,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/img/head_drawer.jpg'),
              ),
            ),
            accountName: Text(
              widget.fullname,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: widget.url != null
                  ? NetworkImage(widget.url)
                  : AssetImage('assets/img/muus.png') as ImageProvider,
            ),
            accountEmail: Text(
              widget.email,
              style: TextStyle(fontSize: 15, color: Colors.white60),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: white),
            title: Text('Home', style: TextStyle(color: white)),
            onTap: () {
              index = 0;
              widget.state();
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.bookQuran, color: white),
            title: Text('Quran', style: TextStyle(color: white)),
            onTap: () {
              index = 1;
              widget.state();
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(CupertinoIcons.clock_fill, color: white),
            title: Text('Prayer Times', style: TextStyle(color: white)),
            onTap: () {
              index = 2;
              widget.state();
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.one_k_plus, color: white),
            title: Text('Tasbihs', style: TextStyle(color: white)),
            onTap: () {
              index = 3;
              widget.state();
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.shieldHalved, color: white),
            title: Text('Jawshan', style: TextStyle(color: white)),
            onTap: () {
              index = 4;
              widget.state();
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(FontAwesomeIcons.screwdriverWrench, color: white),
            title: Text('Tools', style: TextStyle(color: white)),
            onTap: () {
              index = 5;
              widget.state();
              Navigator.pop(context);
            },
          ),
          Divider(color: white.withAlpha(200)),
          ListTile(
            leading: Icon(Icons.settings, color: white),
            title: Text('Settings', style: TextStyle(color: white)),
            onTap: () {
              index = 6;
              widget.state();
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Exit', style: TextStyle(color: white)),
            leading: Icon(Icons.close, color: white),
            onTap: () => exit(0),
          ),
        ],
      ),
    );
  }
}
