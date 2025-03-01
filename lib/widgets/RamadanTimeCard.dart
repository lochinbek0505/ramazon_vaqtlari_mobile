import 'package:flutter/material.dart';

import '../model/namoz_model.dart';

class RamadanTimeCard extends StatelessWidget {
  Times time;

  RamadanTimeCard({super.key, required this.time});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25),
      child:
          size.width < 600
              ? Container(
                width: size.width * 0.95,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.indigoAccent, // Qora fon
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sana",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${time.kun} Ramazon 1446",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          "${int.parse(time.kun!) > 10 ? time.kun : "0${time.kun}"} / 03 / 2025",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 0.8,
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TimeColumn(
                          icon: Icons.wb_sunny_outlined,
                          title: "Saharlik",
                          time: time.quyosh.toString(),
                        ),
                        VerticalDivider(color: Colors.white, width: 2),
                        TimeColumn(
                          icon: Icons.nights_stay_outlined,
                          title: "Iftorlik",
                          time: time.xufton.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              )
              : Container(
                width: size.width * 0.8,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.indigoAccent, // Qora fon
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Sana",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${time.kun} Ramazon 1446",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          "${int.parse(time.kun!) > 10 ? time.kun : "0${time.kun}"} / 03 / 2025",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 0.8,
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TimeColumn(
                          icon: Icons.wb_sunny_outlined,
                          title: "Saharlik",
                          time: time.quyosh.toString(),
                        ),
                        VerticalDivider(color: Colors.white, width: 2),
                        TimeColumn(
                          icon: Icons.nights_stay_outlined,
                          title: "Iftorlik",
                          time: time.xufton.toString(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
    );
  }
}

class TimeColumn extends StatelessWidget {
  final IconData icon;
  final String title;
  final String time;

  TimeColumn({required this.icon, required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.3,
      child:
          size.width < 600
              ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(icon, color: Colors.white, size: 25),
                      SizedBox(width: 15),
                      Column(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            time,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(icon, color: Colors.grey[400], size: 25),
                      SizedBox(width: 15),
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                    ],
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
    );
  }
}
