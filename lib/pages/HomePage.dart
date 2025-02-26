import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/namoz_model.dart';
import 'FullCalendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //bu json dan o'qilgan to'liq ma'lumotni o'zida saqlaydi
  late NamozModel model;

  // ayni damdagi vaqtni o'zida saqlaydi
  late DateTime date;

  //bugungi kungi namoz vaqtlarini o'zida saqlaydi
  late Times time;
  static const platform = MethodChannel('alarm_channel');

  //bu funksiya json file dagi ma'lumotni NamozModel ga o'girib beryabdi
  Future<void> getDataFromJson() async {
    String data = await rootBundle.loadString(
      'assets/json/namoz_vaqtlari.json',
    );
    setState(() {
      var list = jsonDecode(data);
      model = NamozModel.fromJson(list);
    });
  }

  //ayni damdagi namoz vaqtini aniqlab beryabdi
  Times? getCurrentTimes(int day) {
    for (DataList data in model.dataListList!) {
      if (day == data.day) {
        var times = data.times!;
        return times;
      }
    }
    return null;
  }

  //ayni damdagi kun yordamida bizga Hafta kunini qaytaryabdi
  String getWeekdays(int id) {
    switch (id) {
      case 1:
        {
          return "Dushanba";
        }
      case 2:
        {
          return "Seshanba";
        }
      case 3:
        {
          return "Chorshanba";
        }
      case 4:
        {
          return "Payshanba";
        }
      case 5:
        {
          return "Juma";
        }
      case 6:
        {
          return "Shanba";
        }
      case 7:
        {
          return "Yakshanba";
        }
    }
    return "";
  }

  //ayni damdagi kun yordamida oyni qaytaryabdi
  String getMonth(int id) {
    switch (id) {
      case 1:
        {
          return "Yanvar";
        }
      case 2:
        {
          return "Fevral";
        }
      case 3:
        {
          return "Mart";
        }
      case 4:
        {
          return "Aprel";
        }
      case 5:
        {
          return "May";
        }
      case 6:
        {
          return "Iyun";
        }
      case 7:
        {
          return "Iyul";
        }
      case 8:
        {
          return "Avgust";
        }
      case 9:
        {
          return "Sentabr";
        }
      case 10:
        {
          return "Oktabr";
        }

      case 11:
        {
          return "Noyabr";
        }
      case 12:
        {
          return "Dekabr";
        }
    }
    return "";
  }

  var check = false;

  //bu yerda boshlag'ich qiymatlar berilyabdi va model initsilizatsiya qilinyabdi
  @override
  void initState() {
    super.initState();
    //hozirgi sanani olyabman
    date = DateTime.now();

    //bu yerda json file dan o'girilgan data ni aniqlab olyabmiz
    getDataFromJson().then((_) {
      setState(() {
        //bugungi kundagi namoz vaqtlarini aniqlashtirib olish
        time = getCurrentTimes(date.day)!;
        check = !check;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color dayOrNightColor = Colors.black;
    String imageAsset;
    Size size = MediaQuery
        .of(context)
        .size;
    int hour = DateTime.now().hour;

    if (hour >= 6 && hour < 12) {
      imageAsset = "assets/images/sahar_time_image.png";
      backgroundColor = Color(0xff97E2Fd);
    } else if (hour >= 12 && hour < 17) {
      imageAsset = "assets/images/sunrise_time_image.png";
      backgroundColor = Color(0xffE1EBDA);
    } else if (hour >= 17 && hour < 20) {
      imageAsset = "assets/images/afternoon_time_image.png";
      backgroundColor = Color(0xffCC7E3B);
    } else {
      imageAsset = "assets/images/night_time_image.png";
      backgroundColor = Color(0xff1E1A43);
      dayOrNightColor = Colors.white;
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
          backgroundColor: Colors.grey.shade100,
          title: Container(
          padding: EdgeInsets.only(top: 0, left: 10, right: 5),
          width: double.infinity,
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${date.day} ${getMonth(date.month)}, ${date.year} ${getWeekdays(date.weekday)} ",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Samarqand",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (builder) => Fullcalendar(),
                        ),
                      );
                    },

                    icon: Icon(Icons.calendar_month, size: 24,color: Colors.blue,),
                  ),
                ],
              ),
            ],
          ),
        )
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey.shade100,
        child: ListView(
          children: [
            SizedBox(height: 150),
            Column(
              children: [
                check
                    ? Column(
                  children: [
                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: size.width * 0.38,
                          height: 130,
                          decoration: BoxDecoration(
                            color: Color(0xffccaefb),
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(height: 10,),
                              Container(
                                  width: double.infinity,
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Text(
                                      "Bomdod ('saharlik')", maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),),
                                  )),
                              Container(
                                  width: double.infinity,
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: Text(
                                      time.tongSaharlik.toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.indigo),),
                                  )),

                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Image.asset(
                                  "assets/icon/moon.png", width: 70,
                                  height: 50,),
                              )
                            ],
                          ),
                        ),
                        Container(
                            width: size.width * 0.38,
                            height: 130,
                            decoration: BoxDecoration(
                              color: Color(0xfffbdb7b),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(height: 10,),
                                Container(
                                    width: double.infinity,
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0),
                                      child: Text("Quyosh", style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),),
                                    )),
                                Container(
                                    width: double.infinity,
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0),
                                      child: Text(
                                        time.quyosh.toString(),
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black45),),
                                    )),

                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.asset(
                                    "assets/icon/sun.png", width: 60,
                                    height: 50,),
                                )
                              ],
                            )
                        ),

                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            width: size.width * 0.38,
                            height: 130,
                            decoration: BoxDecoration(
                              color: Color(0xffdfc065),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(height: 10,),
                                Container(
                                    width: double.infinity,
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0),
                                      child: Text("Peshin", style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),),
                                    )),
                                Container(
                                    width: double.infinity,
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0),
                                      child: Text(
                                        time.peshin.toString(),
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),),
                                    )),

                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.asset(
                                    "assets/icon/cloud.png", width: 60,
                                    height: 50,),
                                )
                              ],
                            )
                        ),
                        Container(
                            width: size.width * 0.38,
                            height: 130,
                            decoration: BoxDecoration(
                              color: Color(0xffA7A9F5),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(height: 10,),
                                Container(
                                    width: double.infinity,
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0),
                                      child: Text("Asr", style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),),
                                    )),
                                Container(
                                    width: double.infinity,
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0),
                                      child: Text(
                                        time.asr.toString(), style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black45),),
                                    )),

                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.asset(
                                    "assets/icon/day_night.png", width: 60,
                                    height: 50,),
                                )
                              ],
                            )
                        ),

                      ],
                    ),

                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            width: size.width * 0.38,
                            height: 130,
                            decoration: BoxDecoration(
                              color: Color(0xff6457FA),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(height: 10,),
                                Container(
                                    width: double.infinity,
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0),
                                      child: Text(
                                        "Shom ('ifrorlik')", maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),),
                                    )),
                                Container(
                                    width: double.infinity,
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0),
                                      child: Text(
                                        time.shomIftor.toString(), style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.amber),),
                                    )),

                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.asset(
                                    "assets/icon/cloud_night.png", width: 60,
                                    height: 50,),
                                )
                              ],
                            )
                        ),
                        Container(
                            width: size.width * 0.38,
                            height: 130,
                            decoration: BoxDecoration(
                              color: Color(0xff7D5B8A),
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(height: 10,),
                                Container(
                                    width: double.infinity,
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0),
                                      child: Text("Xufton", style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),),
                                    )),
                                Container(
                                    width: double.infinity,
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 12.0),
                                      child: Text(
                                        time.hufton.toString(), style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.yellowAccent),),
                                    )),

                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.asset(
                                    "assets/icon/night.png", width: 60,
                                    height: 50,),
                                )
                              ],
                            )
                        ),

                      ],
                    ),

                    SizedBox(height: 20),
                  ],
                )
                    : SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget time_card(String name, String time) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        width: double.infinity,
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                name,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text(
                    //time null bo'lish qolishidan saqlash uchun
                    time,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setAlarm("message", 16, 30);
                  },
                  icon: Icon(Icons.alarm),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> setAlarm(String message, int hour, int minute) async {
    try {
      final String result = await platform.invokeMethod('setAlarm', {
        'message': message,
        'hour': hour,
        'minute': minute,
      });
      print("✅ $result");
    } on PlatformException catch (e) {
      print("❌ Budilnikni o‘rnatishda xatolik: '${e.message}'");
    }
  }
}
