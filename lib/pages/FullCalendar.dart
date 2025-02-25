import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'PageForDay.dart';
import '../model/namoz_model.dart';

class Fullcalendar extends StatefulWidget {
  const Fullcalendar({
    super.key,
  });

  @override
  State<Fullcalendar> createState() => _FullcalendarState();
}

class _FullcalendarState extends State<Fullcalendar> {
  late NamozModel model;
  var check = false;

  Future<void> getDataFromJson() async {
    String data =
        await rootBundle.loadString('assets/json/namoz_vaqtlari.json');
    setState(() {
      var list = jsonDecode(data);
      model = NamozModel.fromJson(list);
    });
  }

  @override
  void initState() {
    super.initState();
    getDataFromJson().then((_) {
      setState(() {
        check = !check;
      });
    });
  }

  @override
  Widget build(BuildContext context) {



    Color backgroundColor;

    int hour = DateTime.now().hour;

    if (hour >= 6 && hour < 12) {
      backgroundColor = Color(0xff97E2Fd);
    } else if (hour >= 12 && hour < 17) {
      backgroundColor = Color(0xffE1EBDA);
    } else if (hour >= 17 && hour < 20) {
      backgroundColor = Color(0xffCC7E3B);
    } else {
      backgroundColor = Color(0xff1E1A43);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: const Text(
          "Fevral - Sha'bon",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: !check
          ? SizedBox()
          : ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: model.dataListList?.length ?? 0,
              itemBuilder: (context, index) {
                DataList data = model.dataListList![index];

                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PageForDay(
                          date: DateTime.tryParse(data.date!) ?? DateTime.now(),
                          time: data.times!,
                          model: model,
                          data: data,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "${data.day} - Fevral",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
