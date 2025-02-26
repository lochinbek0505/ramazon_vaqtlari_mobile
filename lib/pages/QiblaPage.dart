import 'dart:math';

import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';

class QiblaPage extends StatefulWidget {
  const QiblaPage({super.key});

  @override
  State<QiblaPage> createState() => _QiblaPageState();
}

class _QiblaPageState extends State<QiblaPage> {
  Position? _position;
  double? _direction;
  double _qiblaDirection = 0;

  @override
  void initState() {
    super.initState();
    _initLocationAndCompass();
  }

  Future<void> _initLocationAndCompass() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return;
    }

    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition();
    Coordinates coordinates = Coordinates(
        position.latitude, position.longitude);
    double qiblaDirection = Qibla.qibla(coordinates);

    setState(() {
      _position = position;
      _qiblaDirection = qiblaDirection;
    });

    FlutterCompass.events!.listen((CompassEvent event) {
      if (mounted) {
        setState(() {
          _direction = event.heading;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text("Qibla Kompas", style: TextStyle(
            color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
      ),
      body: _position == null || _direction == null
          ? const Center(child: CircularProgressIndicator(color: Colors.blue))
          : Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                textAlign: TextAlign.center,
                "Agar kompas harakatlanmasa qurilmada kerakli funksiyalar mavjud bo'lmasligi mumkin",
                style: TextStyle(fontSize: 16, color: Colors.black87),),
            ),
            SizedBox(height: 20,),
            Transform.rotate(
              angle: (-_direction! + _qiblaDirection) * (pi / 180),
              alignment: Alignment.center,
              child: Image.asset('assets/images/direction.png', width: 250),
            ),
            SizedBox(height: 15,),
            Text(
              showHeading(_direction!, _qiblaDirection),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String showHeading(double direction, double qiblaDirection) {
  double difference = (qiblaDirection - direction).abs();
  return difference < 3 ? "Siz Makkaga qarab turibsiz!" : '${direction
      .toStringAsFixed(0)}°';
}