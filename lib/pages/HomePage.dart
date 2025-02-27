import 'dart:convert';

import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slide_countdown/slide_countdown.dart';

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

  void _setAlarm(int hour, int minute) async {
    if (hour == null && minute == null) {
      final intent = AndroidIntent(
        action: 'android.intent.action.SET_ALARM',
        arguments: <String, dynamic>{
          'android.intent.extra.alarm.HOUR': hour,
          'android.intent.extra.alarm.MINUTES': minute,
          'android.intent.extra.alarm.MESSAGE': 'Flutter budilnik ⏰',
          'android.intent.extra.alarm.SKIP_UI': false,
        },
        flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
      );

      await intent.launch();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Iltimos, vaqtni tanlang!')),
      );
    }
  }

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
  var time_vaqt = "";
  var now_time = DateTime.now();
  var hour = 0;
  var minute = 0;
  late TimeOfDay timeOfDay;
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
        countDown();
      });
    });
  }

  var time_name = "";

  void countDown() {
    var _timeSaharlik = parseTimeOfDay(
        time.tongSaharlik.toString());
    var _timeIftorlik = parseTimeOfDay(
        time.shomIftor.toString());
    print(_timeSaharlik);
    time_vaqt = "";
    now_time = DateTime.now();
    hour = 0;
    minute = 0;

    if (_timeSaharlik.hour >= now_time.hour) {
      if (_timeSaharlik.minute > now_time.minute) {
        time_name = "Saharlik vaqti";
        timeOfDay = _timeSaharlik;
        time_vaqt = time.tongSaharlik.toString();
        hour = _timeSaharlik.hour - now_time.hour;
        minute = _timeSaharlik.minute - now_time.minute;
      }
      else if (_timeSaharlik.hour == now_time.hour) {
        time_name = "Iftorlik vaqti";
        timeOfDay = _timeIftorlik;

        time_vaqt = time.shomIftor.toString();
        var sek = (_timeIftorlik.hour * 3600 +
            _timeIftorlik.minute * 60) -
            (now_time.hour * 3600 + now_time.minute * 60);
        hour = sek ~/ 3600;
        minute = (sek % 3600) ~/ 60;
        print("$hour $minute");
      }
    }
    else if (_timeIftorlik.hour < now_time.hour) {
      time_name = "Saharlik vaqti";
      time = getCurrentTimes(date.day + 1)!;

      _timeSaharlik = parseTimeOfDay(
          time.tongSaharlik.toString());
      timeOfDay = _timeSaharlik;

      time_vaqt = time.tongSaharlik.toString();
      var sek = 24 * 3600 -
          (now_time.hour * 3600 + now_time.minute * 60 +
              now_time.second);
      hour = _timeSaharlik.hour + sek ~/ 3600;
      print("${_timeIftorlik.hour} ${_timeIftorlik.minute}");
      minute = _timeSaharlik.minute + (sek % 3600) ~/ 60;
    }
    else {
      if (_timeIftorlik.hour == now_time.hour &&
          _timeIftorlik.minute <= now_time.minute) {
        time = getCurrentTimes(date.day + 1)!;

        _timeSaharlik = parseTimeOfDay(
            time.tongSaharlik.toString());
        time_name = "Saharlik vaqti";
        timeOfDay = _timeSaharlik;
        time_vaqt = time.tongSaharlik.toString();
        var sek = 24 * 3600 -
            (now_time.hour * 3600 + now_time.minute * 60 +
                now_time.second);
        hour = _timeSaharlik.hour + sek ~/ 3600;
        print("${_timeIftorlik.hour} ${_timeIftorlik.minute}");
        minute = _timeSaharlik.minute + (sek % 3600) ~/ 60;
      }
      else {
        time_name = "Iftorlik vaqti";
        timeOfDay = _timeIftorlik;

        time_vaqt = time.shomIftor.toString();
        hour = _timeIftorlik.hour - now_time.hour;
        minute = _timeIftorlik.minute - now_time.minute
        ;
        print("$hour $minute");
      }
    }
  }

  TimeOfDay parseTimeOfDay(String time) {
    final parts = time.trim().split(':'); // ["03", "58"]
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;



    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
          backgroundColor: Colors.indigoAccent,
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
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "Samarqand",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
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

                    icon: Icon(
                      Icons.calendar_month, size: 24, color: Colors.white,),
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
            SizedBox(height: 15,),
            Container(
              width: size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: 35,),

                  Text(time_name,
                    style: TextStyle(fontSize: 25,
                        color: Colors.black),),
                  IconButton(
                      onPressed: () {
                        setAlarm("$time_name keldi", timeOfDay.hour,
                            timeOfDay.minute);
                      },
                      icon: Icon(Icons.alarm, color: Colors.blue,size: 30,)),

                ],
              ),

            ),
            Center(
              child: Text(time_vaqt,
                style: TextStyle(fontSize: 30, color: Colors.black),),
            ),
            SizedBox(height: 10,),
            Center(
              child: SlideCountdown(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.indigoAccent,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2),
                      ),
                    ]
                ),

                onDone: () {
                  print("ONDONE");
                  setState(() {
                    countDown();
                  });
                },
                style: TextStyle(
                  fontSize: 21,
                  color: Colors.white,
                ),
                separatorStyle: TextStyle(
                  fontSize: 21,
                  color: Colors.white,
                ),
                duration: Duration(hours: hour, minutes: minute),
              ),),
            SizedBox(height: 20),
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
                                        "Shom ('iftorlik')", maxLines: 1,
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
