import 'dart:async';

import 'package:flutter/services.dart';

class FlutterKount {
  static const MethodChannel _channel = const MethodChannel('flutter_kount');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String?> get sessionId async {
    final String? version =
        await _channel.invokeMethod('getSessionId', {"test_mode": true});
    return version;
  }
}
