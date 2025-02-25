import 'package:flutter/material.dart';
import 'package:namoz_time_mobile/widgets/duo_card.dart';

class Duopage extends StatefulWidget {
  const Duopage({super.key});

  @override
  State<Duopage> createState() => _DuopageState();
}

class _DuopageState extends State<Duopage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        title: Text(
          "Duolar",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 21,
          ),
        ),
      ),
      body: DuaCard(),
    );
  }
}
