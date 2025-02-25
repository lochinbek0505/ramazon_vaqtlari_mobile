import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class QiblaCompassPage extends StatefulWidget {
  @override
  _QiblaCompassPageState createState() => _QiblaCompassPageState();
}

class _QiblaCompassPageState extends State<QiblaCompassPage> {
  Future<void> requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print("Location permission granted!");
    } else {
      print("Location permission denied!");
    }
  }

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Qibla Compass")),
      body: FutureBuilder(
        future: Geolocator.getCurrentPosition(),
        builder: (context, AsyncSnapshot<Position> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          return StreamBuilder(
            stream: FlutterQiblah.qiblahStream,
            builder: (context, AsyncSnapshot<QiblahDirection> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              }

              final qiblaDirection = snapshot.data;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Qibla yo'nalishi: ${qiblaDirection!.qiblah.toStringAsFixed(2)}°",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    Transform.rotate(
                      angle: qiblaDirection.qiblah * (3.1415927 / 180),
                      // Radianlarga o'tkazish
                      child: Image.asset("assets/images/direction.png")
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
