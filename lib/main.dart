import 'package:flutter/material.dart';

import 'services/flash_light_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isFlashlightOn = false;

  Future<void> _toggleFlashlight() async {
    if (_isFlashlightOn) {
      await FlashLightService.turnOffFlashlight();
    } else {
      await FlashLightService.turnOnFlashlight();
    }
    setState(() {
      _isFlashlightOn = !_isFlashlightOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Indicator light
          Expanded(
            child: Container(
              width: 33,
              height: 33,
              decoration: BoxDecoration(
                color: _isFlashlightOn ? Colors.green : Colors.redAccent,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: _isFlashlightOn ? Colors.green : Colors.redAccent,
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
            ),
          ),

          /// Power button
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: _toggleFlashlight,
                child: Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _isFlashlightOn
                          ? const Color(0xffFDD017)
                          : Colors.white,
                      width: 2,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.power_settings_new,
                    color: _isFlashlightOn
                        ? const Color(0xffFDD017)
                        : Colors.white,
                    size: 60,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
