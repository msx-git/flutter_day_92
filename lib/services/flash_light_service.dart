import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class FlashLightService {
  static const platform = MethodChannel('flashLightChannel');

  static Future<void> turnOnFlashlight() async {
    try {
      await platform.invokeMethod('turnOn');
    } on PlatformException catch (e) {
      debugPrint("Failed to turn on flashlight: '${e.message}'.");
    }
  }

  static Future<void> turnOffFlashlight() async {
    try {
      await platform.invokeMethod('turnOff');
    } on PlatformException catch (e) {
      debugPrint("Failed to turn off flashlight: '${e.message}'.");
    }
  }
}
