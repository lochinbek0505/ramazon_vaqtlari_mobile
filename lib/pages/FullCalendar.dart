import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/namoz_model.dart';
import '../widgets/RamadanTimeCard.dart';

class Fullcalendar extends StatefulWidget {
  const Fullcalendar({super.key});

  @override
  State<Fullcalendar> createState() => _FullcalendarState();
}

class _FullcalendarState extends State<Fullcalendar> {
  late NamozTimeModel model;
  late DateTime date;
  var check = false;
  Future<void> getDataFromJson() async {
    String data = await rootBundle.loadString(
      'assets/json/samarqand.json',
    );
    setState(() {
      var list = jsonDecode(data);
      model = NamozTimeModel.fromJson(list);
    });
  }


  @override
  void initState() {
    super.initState();
    //hozirgi sanani olyabman
    date = DateTime.now();
    //bu yerda json file dan o'girilgan data ni aniqlab olyabmiz
    getDataFromJson().then((_) {
      setState(() {
        print(model.timesList![0].xufton);
        //bugungi kundagi namoz vaqtlarini aniqlashtirib olish

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        backgroundColor: Colors.indigoAccent,
        title: Text(
          "To'liq ramazon taqvimi", style: TextStyle(color: Colors.white),),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return RamadanTimeCard(time: model.timesList![index]);
      }, itemCount: model.timesList!.length,),
    );
  }
}
