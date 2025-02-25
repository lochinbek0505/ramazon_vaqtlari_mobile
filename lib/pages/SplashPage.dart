import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'OnboardPage.dart';

class Splashpage extends StatelessWidget {
  const Splashpage({super.key});

  // Flexible , Expanded
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Pageviewpage()),
      );
    });
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
