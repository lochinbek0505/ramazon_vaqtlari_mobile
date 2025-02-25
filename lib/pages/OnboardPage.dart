import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namoz_time_mobile/pages/MainPage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Pageviewpage extends StatefulWidget {
  const Pageviewpage({super.key});

  @override
  State<Pageviewpage> createState() => _PageviewpageState();
}

class _PageviewpageState extends State<Pageviewpage> {
  final PageController _pageController = PageController(initialPage: 0);
  var _currentIndex = 0;

  void _goToPage() {
    if (_currentIndex < 2) {
      _currentIndex++;
      _pageController.animateToPage(
        _currentIndex,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              children: [
                Container(
                  decoration: BoxDecoration(color: Color(0xffffffff)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/image1.png",
                        width: size.width * 0.6,
                      ),
                      SizedBox(height: 90),

                      SizedBox(height: 30),
                      Text(
                        "🌙 Ramazon taqvimi",
                        style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "📅 Joylashuvingiz bo‘yicha to‘g‘ri saharlik va iftorlik\nvaqtlarini bilib oling.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                      SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: _goToPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          " Oldinga ",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Color(0xffffffff)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/image2.png",
                        width: size.width * 0.6,
                      ),
                      SizedBox(height: 90),

                      SizedBox(height: 30),
                      Text(
                        textAlign: TextAlign.center,
                        "🍽 Saharlik va iftor\neslatmalari",
                        style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "⏰ Saharlik va iftor uchun eslatmalar sozlab,\nro‘za tutishni osonlashtiring.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                      SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: _goToPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          " Oldinga ",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Color(0xffffffff)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/image3.png",
                        width: size.width * 0.6,
                      ),
                      SizedBox(height: 90),

                      SizedBox(height: 30),
                      Text(
                        textAlign: TextAlign.center,
                        "🤲 Duo va ibodatlar",
                        style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "📖 Ramazon oyiga oid maxsus duo va\nibodatlarni o‘rganing.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                      SizedBox(height: 60),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (builder) => MainPage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          " Boshlash ",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: 3,
                effect: WormEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: Colors.indigo.shade900,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
