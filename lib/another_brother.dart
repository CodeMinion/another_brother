
import 'dart:async';

import 'package:flutter/services.dart';
class AnotherBrother {
  static const MethodChannel _channel =
      const MethodChannel('another_brother');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
