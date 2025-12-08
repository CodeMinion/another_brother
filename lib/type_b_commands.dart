import 'package:flutter/foundation.dart';

abstract class ITbCommand {
  String getCommand();

  /// The Brother printers expect the file to be in upper case.
  /// This method will take a path extract the filename
  /// and make it upper case.
  static String pathToBrotherFileName(String filePath) {
    String brotherFileName = filePath.split("/").last.toUpperCase().trim();
    print ("Brother File Name: $brotherFileName");
    return brotherFileName;
  }
}


class TbCommandPutPcx implements ITbCommand {

  String outCommand = "";

  TbCommandPutPcx(int x, int y, String filePath) {
    //outCommand = "PUTPCX 145,15,\"UL.PCX\"\r\n";
    outCommand = "PUTPCX $x,$y,\"${ITbCommand.pathToBrotherFileName(filePath)}\"\r\n";
  }

  @override
  String getCommand() {
    return outCommand;
  }

}

class TbCommandPutBmp implements ITbCommand {

  String outCommand = "";

  TbCommandPutBmp(int x, int y, String filePath) {
    outCommand = "PUTBMP $x,$y,\"${ITbCommand.pathToBrotherFileName(filePath)}\"\r\n";
  }

  @override
  String getCommand() {
    return outCommand;
  }

}

class TbCommandSendBitmap implements ITbCommand {

  String outCommand = "";

  TbCommandSendBitmap(int x, int y, int width, int height, Uint8List imageData, {TbBitmapMode mode = TbBitmapMode.OVERWRITE}) {
    String bytesStr = "${String.fromCharCodes(imageData)}";
    //outCommand = "BITMAP $x,$y,$width,$height,${mode.getValue()},${String.fromCharCodes(imageData)}\"\r\n";
    //outCommand = "BITMAP $x,$y,$width,$height,${mode.getValue()},${String.fromCharCodes(imageData)}";
    outCommand = "BITMAP $x,$y,$width,$height,${mode.getValue()},";

    print ("Out Command - $outCommand");
    print ( "- Image Size ${bytesStr.length}");
  }

  @override
  String getCommand() {
    return outCommand;
  }

}

class TbBitmapMode {
  final int _value;
  const TbBitmapMode._internal(this._value);

  static const OVERWRITE = TbBitmapMode._internal(0);
  static const OR = TbBitmapMode._internal(1);
  static const XOR = TbBitmapMode._internal(2);

  int getValue() => _value;

}

class TbCommandSetWlanSsid implements ITbCommand {

  String outCommand = "";

  TbCommandSetWlanSsid(String? ssid) {
    if (ssid == null) {
      outCommand = "WLAN OFF\r\n";
    }
    else {
      outCommand = "WLAN SSID \"${ssid}\"\r\n";
    }
  }

  @override
  String getCommand() {
    return outCommand;
  }

}

class TbCommandSetWlanWpa implements ITbCommand {

  String outCommand = "";

  TbCommandSetWlanWpa({String? passKey}) {
    if (passKey != null) {
      outCommand = "WLAN WPA \"${passKey}\"\r\n";
    }
    else {
      outCommand = "WLAN WPA OFF\r\n";
    }
  }
  @override
  String getCommand() {
    return outCommand;
  }

}

class TbCommandSetWlanIp implements ITbCommand {

  String outCommand = "";

  TbCommandSetWlanIp({required String ipAddress, String maskAddress = "255.255.255.0", required String gatewayAddress}) {
      outCommand = "WLAN IP \"${ipAddress}\",\"${maskAddress}\",\"${gatewayAddress}\"\r\n";
  }
  @override
  String getCommand() {
    return outCommand;
  }

}

class TbCommandSetWlanDhcp implements ITbCommand {

  String outCommand = "";

  TbCommandSetWlanDhcp() {
      outCommand = "WLAN DHCP\r\n";

  }
  @override
  String getCommand() {
    return outCommand;
  }

}

class TbCommandSelfTest implements ITbCommand {

  String outCommand = "";

  TbCommandSelfTest({TbSelfTestPage page = TbSelfTestPage.NONE}) {
    if (page == TbSelfTestPage.NONE) {
      outCommand = "SELFTEST\r\n";
    }
    else {
      outCommand = "SELFTEST ${page.getValue()}\r\n";
    }

  }
  @override
  String getCommand() {
    return outCommand;
  }
}

class TbSelfTestPage {
  final String _value;
  const TbSelfTestPage._internal(this._value);

  static const TbSelfTestPage NONE = TbSelfTestPage._internal("");
  static const TbSelfTestPage PATTERN = TbSelfTestPage._internal("PATTERN");
  static const TbSelfTestPage ETHERNET = TbSelfTestPage._internal("ETHERNET");
  static const TbSelfTestPage WLAN = TbSelfTestPage._internal("WLAN");
  static const TbSelfTestPage RS232 = TbSelfTestPage._internal("RS232");
  static const TbSelfTestPage SYSTEM = TbSelfTestPage._internal("SYSTEM");
  static const TbSelfTestPage Z = TbSelfTestPage._internal("Z");
  static const TbSelfTestPage BT = TbSelfTestPage._internal("BT");

  String getValue() => _value;

}

/// Command to delete a file
/// Passing null will delete all files.
class TbCommandDeleteFile implements ITbCommand {

  String outCommand = "";


  TbCommandDeleteFile({String? filePath, bool fromFlash = true}) {
    if (filePath == null) {
      if (fromFlash) {
        outCommand = "KILL F, \"* \"\r\n";
      }
      else {
        outCommand = "KILL \"* \"\r\n";
      }

    }
    else {
      if (fromFlash) {
        outCommand =
        "KILL F, \"${ITbCommand.pathToBrotherFileName(filePath)}\"\r\n";
      }
      else {
        outCommand =
        "KILL \"${ITbCommand.pathToBrotherFileName(filePath)}\"\r\n";
      }
    }

  }
  @override
  String getCommand() {
    return outCommand;
  }

}

/// Command to run a file
class TbCommandRunFile implements ITbCommand {

  String outCommand = "";


  TbCommandRunFile(String filePath) {
    outCommand = "RUN \"${ITbCommand.pathToBrotherFileName(filePath)}\"\r\n";


  }
  @override
  String getCommand() {
    return outCommand;
  }

}

