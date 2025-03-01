import 'package:flutter/material.dart';
import 'package:namoz_time_mobile/pages/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/ReadJsonModel.dart';

List<ProvinceModel> provinceList = [
  ProvinceModel("Toshkent viloyati", [
    DistrictModel("Toshkent", "assets/json/toshkent.json"),
    DistrictModel("Bekobod", "assets/json/bekobod.json"),
    DistrictModel("Olmaliq", "assets/json/olmaliq.json"),
    DistrictModel("Nurafshon", "assets/json/nurafshon.json"),
    DistrictModel("Angren", "assets/json/angren.json"),
    DistrictModel("Parkent", "assets/json/parkent.json"),
    DistrictModel("Bo'ka", "assets/json/bo'ka.json"),
    DistrictModel("Piskent", "assets/json/piskent.json"),
    DistrictModel("G'azalkent ", "assets/json/go'zalkent.json"),
    DistrictModel("Yangiyo'l", "assets/json/yangiyo'l.json"),
  ]),

  ProvinceModel("Sirdaryo viloyati", [
    DistrictModel("Guliston ", "assets/json/guliston.json"),
    DistrictModel("Boyovut", "assets/json/boyovut.json"),
    DistrictModel("Sardoba", "assets/json/sardoba.json"),
    DistrictModel("Paxtaobod", "assets/json/paxtaobod.json"),
    DistrictModel("Sirdaryo", "assets/json/sirdaryo.json"),
  ]),

  ProvinceModel("Namangan viloyati", [
    DistrictModel("Namangan", "assets/json/namangan.json"),
    DistrictModel("Pop", "assets/json/pop.json"),
    DistrictModel("Chortoq", "assets/json/chortoq.json"),
    DistrictModel("Uchqo'rg'on", "assets/json/uchqo'rg'on.json"),
    DistrictModel("Chust", "assets/json/chust.json"),
    DistrictModel("Mingbuloq", "assets/json/mingbuloq.json"),
  ]),
  ProvinceModel("Surxondaryo viloyati", [
    DistrictModel("Termiz", "assets/json/termiz.json"),
    DistrictModel("Sherobod", "assets/json/sherobod.json"),
    DistrictModel("Boysun", "assets/json/boysun.json"),
    DistrictModel("Sho'rchi", "assets/json/sho'rchi.json"),
    DistrictModel("Denov", "assets/json/denov.json"),
  ]),
  ProvinceModel("Xorazm viloyati", [
    DistrictModel("Urganch", "assets/json/urganch.json"),
    DistrictModel("Yangibozor", "assets/json/yangibozor.json"),
    DistrictModel("Hozorasp", "assets/json/hazorasp.json"),
    DistrictModel("Shovot", "assets/json/shovot.json"),
    DistrictModel("Xonqa", "assets/json/xonqa.json"),
    DistrictModel("Xiva", "assets/json/xiva.json"),
  ]),
  ProvinceModel("Buxoro viloyati", [
    DistrictModel("Buxoro", "assets/json/buxoro.json"),
    DistrictModel("Qorako'l", "assets/json/qorako'l.json"),
    DistrictModel("Gazli", "assets/json/gazli.json"),
    DistrictModel("Jondor", "assets/json/jondor.json"),
    DistrictModel("G'ijduvon", "assets/json/g'ijduvon.json"),
  ]),
  ProvinceModel("Jizzax viloyati", [
    DistrictModel("Jizzax", "assets/json/jizzax.json"),
    DistrictModel("G'allaorol", "assets/json/g'allaorol.json"),
    DistrictModel("Zomin", "assets/json/zomin.json"),
    DistrictModel("Do'stlik", "assets/json/do'stlik.json"),
    DistrictModel("Forish", "assets/json/forish.json"),
  ]),
  ProvinceModel("Qoraqalpog'iston Respublikasi", [
    DistrictModel("Nukus", "assets/json/nukus.json"),
    DistrictModel("To'rtko'l", "assets/json/to'rtko'l.json"),
    DistrictModel("Mo'ynoq", "assets/json/mo'ynoq.json"),
    DistrictModel("Qo'ng'irot", "assets/json/qo'ng'irot.json"),
    DistrictModel("Taxtako'pir", "assets/json/taxtako'pir.json"),
  ]),
  ProvinceModel("Qashqadaryo viloyati", [
    DistrictModel("Qarshi", "assets/json/qarshi.json"),
    DistrictModel("Shahrisabz", "assets/json/shaxrisabz.json"),
    DistrictModel("Dehqonobod", "assets/json/dexqonobod.json"),
    DistrictModel("G'uzor", "assets/json/g'uzor.json"),
    DistrictModel("Muborak", "assets/json/muborak.json"),
  ]),
  ProvinceModel("Farg'ona viloyati", [
    DistrictModel("Farg'ona", "assets/json/farg'ona.json"),
    DistrictModel("Quva", "assets/json/quva.json"),
    DistrictModel("Oltiariq", "assets/json/oltiariq.json"),
    DistrictModel("Marg'ilon", "assets/json/marg'ilon.json"),
    DistrictModel("Rishton", "assets/json/rishton.json"),
    DistrictModel("Qo'qon", "assets/json/qo'qon.json"),
    DistrictModel("Bog'dod", "assets/json/bog'dod.json"),
  ]),
  ProvinceModel("Navoiy viloyati", [
    DistrictModel("Navoiy", "assets/json/navoiy.json"),
    DistrictModel("Nurota", "assets/json/nurota.json"),
    DistrictModel("Zarafshon", "assets/json/zarafshon.json"),
    DistrictModel("Uchquduq", "assets/json/uchquduq.json"),
    DistrictModel("Konimex", "assets/json/konimex.json"),
  ]),
  ProvinceModel("Samarqand viloyati", [
    DistrictModel("Samarqand", "assets/json/samarqand.json"),
    DistrictModel("Kattaqo'rg'on", "assets/json/kattaqo'rg'on.json"),
    DistrictModel("Ishtixon", "assets/json/ishtixon.json"),
    DistrictModel("Jomboy", "assets/json/jomboy.json"),
    DistrictModel("Urgut", "assets/json/urgut.json"),
    DistrictModel("Mirbozor", "assets/json/mirbozor.json"),
  ]),
  ProvinceModel("Andijon viloyati", [
    DistrictModel("Andijon", "assets/json/andijon.json"),
    DistrictModel("Xo'jaobod", "assets/json/xo'jaobod.json"),
    DistrictModel("Poytug'", "assets/json/poytug'.json"),
    DistrictModel("Xonobod", "assets/json/xonobod.json"),
    DistrictModel("Asaka", "assets/json/asaka.json"),
    DistrictModel("Bo'ston", "assets/json/bo'ston.json"),

    DistrictModel("Shahrixon", "assets/json/shaxrihon.json"),
    DistrictModel("Marhamat", "assets/json/marhamat.json"),
  ]),
];

class ProvincePage extends StatelessWidget {
  Future<void> _saveProvince(String province) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_province', province);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        title: Text(
          "Hududingizni tanlang",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: provinceList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.white,

              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,

                leading: Icon(Icons.location_on_sharp, color: Colors.red),
                title: Text(
                  provinceList[index].province,
                  style: TextStyle(color: Colors.black, fontSize: 19),
                ),
                onTap: () async {
                  await _saveProvince(provinceList[index].province);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DistrictPage(provinceList[index]),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class DistrictPage extends StatelessWidget {
  final ProvinceModel province;

  DistrictPage(this.province);

  Future<void> _saveDistrict(String district) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_district', district);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        title: Text(
          "Hududingizni tanlang",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.builder(
        itemCount: province.list.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(8),
            child: Card(
              color: Colors.white,
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                leading: Icon(Icons.location_on, color: Colors.red),
                title: Text(
                  province.list[index].name,
                  style: TextStyle(color: Colors.black, fontSize: 19),
                ),
                onTap: () async {
                  await _saveDistrict(province.list[index].path);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (builder) => HomePage()),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
