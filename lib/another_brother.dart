
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:another_brother/label_info.dart';
import 'package:another_brother/printer_info.dart';

class AnotherBrother {
  static const MethodChannel _channel =
      const MethodChannel('another_brother');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
