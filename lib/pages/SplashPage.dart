import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namoz_time_mobile/pages/HomePage.dart';
import 'package:namoz_time_mobile/pages/MainPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'OnboardPage.dart';

class Splashpage extends StatefulWidget {
  const Splashpage({super.key});

  @override
  State<Splashpage> createState() => _SplashpageState();
}

class _SplashpageState extends State<Splashpage> {
  Future<String?> _loadSelection() async {
    final prefs = await SharedPreferences.getInstance();
    String? district = prefs.getString('selected_district');
    return district;
  }

  void _navigateToNextPage() async {
    String? selectedDistrict = await _loadSelection();
    bool hasSelection = selectedDistrict != null && selectedDistrict.isNotEmpty;

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return; // context validligini tekshiramiz
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => hasSelection ? MainPage() : Pageviewpage(),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  // Flexible , Expanded
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg_image_splash.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Centered text
            Spacer(),
            Center(
              child: Text(
                "RAMAZON TAQVIMI",
                style: GoogleFonts.poppins(
                  color: Colors.black87,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(),
            Text(
              "Development by Lochinbek 2025",
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
