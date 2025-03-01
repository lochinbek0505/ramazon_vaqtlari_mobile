import 'package:flutter/material.dart';
import 'package:namoz_time_mobile/pages/LocatePage.dart';
import 'package:namoz_time_mobile/pages/SplashPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ramazon taqvimi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xffffffff)),
        useMaterial3: true,
      ),
      home: Splashpage(),
    );
  }
}
