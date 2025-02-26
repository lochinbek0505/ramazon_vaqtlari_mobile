import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:namoz_time_mobile/pages/DuoPage.dart';

import 'HomePage.dart';
import 'QiblaPage.dart';
import 'TasbehPage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectIndex = 0;

  final List<Widget> pages = [
    HomePage(),
    Duopage(),
    TasbehPage(),
    QiblaPage(),
  ];

  void onTap(int index) {
    setState(() {
      selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color dayOrNightColor = Colors.black;

    int hour = DateTime.now().hour;

    return Scaffold(
      body: pages[selectIndex],
      bottomNavigationBar: CurvedNavigationBar(
        items: [
          Image.asset("assets/icon/home.png",width: 35,),
          Image.asset("assets/icon/duo.png",width: 30,),
          Image.asset("assets/icon/tasbih.png", width: 30,),
          Image.asset("assets/icon/qibla.png",width: 30,),
        ],
        onTap: onTap,
        backgroundColor: Colors.grey.shade100,
        color: Colors.grey.shade300,
        index: selectIndex,
        height: 60,
        animationDuration: Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
      ),
    );
  }
}
