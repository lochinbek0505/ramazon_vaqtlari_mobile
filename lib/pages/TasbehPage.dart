import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class TasbehPage extends StatefulWidget {
  @override
  _TasbehPageState createState() => _TasbehPageState();
}

class _TasbehPageState extends State<TasbehPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double _currentAngle = 0.0;
  int _counter = 0;
  bool _vibrateMode = true;
  bool _mode = true; // true= 33 , false =99
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 0).animate(_controller);
  }

  void _rotateCompass() async {
    //vibratsiya uchun kod
    if (_vibrateMode) {
      if (await Vibration.hasCustomVibrationsSupport()) {
        Vibration.vibrate(duration: 100);
      } else {
        Vibration.vibrate();
        await Future.delayed(Duration(milliseconds: 100));
        Vibration.vibrate();
      }
    }
    double newAngle = _currentAngle + (360 / 33);
    _animation = Tween<double>(
      begin: _currentAngle,
      end: newAngle,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    if (_mode) {
      if (_counter < 33) {
        setState(() {
          _counter++;
        });
      } else {
        setState(() {
          _counter = 0;
        });
      }
    } else {
      if (_counter < 99) {
        setState(() {
          _counter++;
        });
      } else {
        setState(() {
          _counter = 0;
        });
      }
    }

    _controller.forward(from: 0);
    setState(() {
      _currentAngle = newAngle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        centerTitle: true,
        title: const Text("Tasbeh", style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Text(
              "$_counter",
              style: TextStyle(
                fontSize: 35,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          GestureDetector(
            onTap: _rotateCompass,
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.rotate(
                  alignment: Alignment.center,
                  angle: _animation.value * (pi / 180),
                  child: child,
                );
              },
              child: Image.asset("assets/images/tasbih.png", width: 250),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      _counter = 0;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: 50,
                    height: 50,
                    child: Icon(Icons.refresh, color: Colors.white),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _mode = !_mode;
                      _counter = 0;
                    });
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        _mode ? "33" : "99",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _vibrateMode = !_vibrateMode;
                    });
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.indigoAccent,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Icon(Icons.vibration, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
