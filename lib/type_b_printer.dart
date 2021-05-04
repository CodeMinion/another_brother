import 'package:another_brother/printer_info.dart';
import 'package:flutter/foundation.dart';

import 'label_info.dart';


class TbPrinterInfo {
  String ipAddress;
  String portNumber;
  String btAddress;
  Port port;
  //ALabelName? labelName;

  TbPrinterInfo(
      {String ipAddress = "",
      String portNumber = "9100",
      String btAddress = "",
        this.port = Port.NET
      })
      : this.ipAddress = ipAddress,
        this.portNumber = portNumber,
        this.btAddress = btAddress;
}

class TbPrinter {
  static final double _MM_IN_INCHE = 25.4;

  TbPrinterInfo printerInfo = TbPrinterInfo();

  static double millimeterToDots(double resolution, double millimeters) {
    return millimeters /(resolution * _MM_IN_INCHE);
  }
  static double inchesToDot(double resolution, double inches) {
    return inches / resolution;
  }
  static dotsToMillimeters(double resolution, double dots) {
    return resolution / dots * _MM_IN_INCHE;
  }

  TbPrinter({TbPrinterInfo? printerInfo}){
    if (printerInfo != null) {
      this.printerInfo = printerInfo;
    }
  }

  /// Sets the printer info for this printer.
  /// @param printerInfo TbPrinterInfo with some initial information about the printer.
  Future<bool> setPrinterInfo(TbPrinterInfo printerInfo) async {
    this.printerInfo = printerInfo;
    return true;
  }

  /// Open the communication to the printer.
  /// returns true on success, false on failure.
  Future<bool> startCommunication() async {
    // TODO Call open port on the native side.
    return true;
  }

  /// Close the communication to the printer.
  /// @param timeout in milliseconds.
  /// returns true on success, false on failure
  Future<bool> endCommunication(int timeoutMillis) async {
    // TODO Call close port on the native side.
    return true;
  }

  /// Set up the label width, label height, print speed, print density, media sensor type, gap/black
  /// mark vertical distance, gap/black mark shift distance.
  /// @param width Width of the label in mm
  /// @param height Height of the label in mm
  /// @param speed Print Speed in inches/second
  ///   1.0 : 1.0 inch/second
  ///   1.5: 1.5 inches/second
  ///   2.0: 2.0 inches/second
  ///   3.0: 3.0 inches/second
  ///   4.0: 4.0 inches/second
  ///   6.0: 6.0 inches/second
  ///   8.0: 8.0 inches/second
  ///   10.0: 10.0 inches/second
  ///   13.0: 13.0 inches/second
  ///   14.0: 14.0 inches/second
  /// @param density Print Density in the range from 0 to 15
  /// @sensor Media Sensor Type
  ///   0 - Gap Sensor
  ///   1 - Black Mark
  /// @sensorDistance Sensor Distance - Vertical gap height of the gap/black mark in mm
  /// @sensorOffset Sensor Offset - Shift distance of the gap/black mark in mm.
  Future<bool> setup({int width = 50, int height = 50,
    double speed = 1, int density = 15,  int sensor = 0,
    int sensorDistance = 0, int sensorOffset = 0}) async {
    // TODO Connect to native size.
    return true;
  }

  /// Clears the printer image buffer.
  Future<bool> clearBuffer() async {
    // TODO Call the native side.
    return true;
  }

  /// Defines a barcode.
  /// @param content Barcode content.
  /// @param x Starting point in the x direction defined in dots.
  /// @param y Starting point in the y direction defined in dots.
  /// @param type Type of barcode to make.
  /// @param humanReadable Alingment of the human readable text.
  /// @param rotation degrees of rotation.
  /// @param narrowBarRatio narrow bar ratio.
  /// @param wideBarRatio wide bar ratio.
  Future<bool> barcode(String content, {int x = 0, int y = 0, BarcodeType type = BarcodeType.Bc_128, int height = 40, HumanReadableAlignment humanReadable = HumanReadableAlignment.Center, TbRotation rotation = TbRotation.None, int narrowBarRatio = 2, int wideBarRatio = 2}) async{
    return true;
  }


  /// Defines a font data string.
  /// @param x x-coordinate of the text in dots
  /// @param y y-coordinate of the text in dots.
  /// @param size predefined font size to use
  /// @param rotation rotation of the text.
  /// @param xMultiplication horizontal multiplication ranged 1~10
  /// @param yMultiplication vertical multiplication ranged 1~10
  Future<bool> printerFont(int x, int y, TbFontSize size, TbRotation rotation, int xMultiplication, int yMultiplication, String content) async {
    // TODO Integrate with native side
    return true;
  }

  /// Sends the given commend to the printer.
  /// @param message command to send.
  Future<bool> sendCommand(String message) async {
    // TODO integrate with the native side.
    return true;
  }

  /// Prints the configure label.
  Future<bool> printLabel(int quantity, int copy) async {
    // TODO Link to native side.
    return true;
  }

  /// Sends a file to the printer.
  Future<bool> sendFile(String filename) async {
    // TODO link with the native side.
    return true;
  }

  Future<TbPrinterStatus> printerStatus(int timeout) async {
    // TODO Link with the native side.
    return TbPrinterStatus._internal(0);
  }

}

class BarcodeType {
  final String _name;
  const BarcodeType._internal(this._name);

  static const Bc_128 = const BarcodeType._internal("128");
  static const Bc_128M = const BarcodeType._internal("128M");
  static const Bc_EAN128 = const BarcodeType._internal("EAN128");
  static const Bc_25 = const BarcodeType._internal("25");
  static const Bc_25C = const BarcodeType._internal("25C");
  static const Bc_39 = const BarcodeType._internal("39");
  static const Bc_39C = const BarcodeType._internal("39C");
  static const Bc_EAN13 = const BarcodeType._internal("EAN13");
  static const Bc_EAN13Plus2 = const BarcodeType._internal("EAN13+2");
  static const Bc_EAN13Plus5 = const BarcodeType._internal("EAN13+5");
  static const Bc_EAN8 = const BarcodeType._internal("EAN8");
  static const Bc_EAN8Plus2 = const BarcodeType._internal("EAN8+2");
  static const Bc_EAN8Plus5 = const BarcodeType._internal("EAN8+5");
  static const Bc_CODA = const BarcodeType._internal("CODA");
  static const Bc_POST = const BarcodeType._internal("POST");
  static const Bc_UPCA = const BarcodeType._internal("UPCA");
  static const Bc_UPCAPlus2 = const BarcodeType._internal("UPCA+2");
  static const Bc_UPCAPlus5 = const BarcodeType._internal("UPCA+5");
  static const Bc_UPCE = const BarcodeType._internal("UPCE");
  static const Bc_UPCEPlus2 = const BarcodeType._internal("UPCE+2");
  static const Bc_UPCEPlus5 = const BarcodeType._internal("UPCE+5");

  static final _values = [
  Bc_128,
  Bc_128M,
  Bc_EAN128,
  Bc_25,
  Bc_25C,
  Bc_39,
  Bc_39C,
  Bc_EAN13,
  Bc_EAN13Plus2,
  Bc_EAN13Plus5,
  Bc_EAN8,
  Bc_EAN8Plus2,
  Bc_EAN8Plus5,
  Bc_CODA,
  Bc_POST,
  Bc_UPCA,
  Bc_UPCAPlus2,
  Bc_UPCAPlus5,
  Bc_UPCE,
  Bc_UPCEPlus2,
  Bc_UPCEPlus5,
  ];

  String getName() {
    return _name;
  }

  List<BarcodeType> getValues() => _values;

}

class HumanReadableAlignment {
  final String _name;
  final int _value;
  const HumanReadableAlignment._internal(this._name, this._value);

  static const None = const HumanReadableAlignment._internal("None", 0);
  static const Left = const HumanReadableAlignment._internal("Left", 1);
  static const Center = const HumanReadableAlignment._internal("Center", 2);
  static const Right = const HumanReadableAlignment._internal("Right", 3);

  static final _values = [
    None,
    Left,
    Center,
    Right
  ];

  String getName() {
    return _name;
  }

  String getValue() {
    return _name;
  }

  List<HumanReadableAlignment> getValues() => _values;

}

class TbRotation {
  final String _name;
  final int _value;

  const TbRotation._internal(this._name, this._value);

  static const None = const TbRotation._internal("None", 0);
  static const CW90 = const TbRotation._internal("90", 1);
  static const CW180 = const TbRotation._internal("180", 2);
  static const CW270 = const TbRotation._internal("270", 3);

  static final _values = [
    None,
    CW90,
    CW180,
    CW270
  ];

  String getName() {
    return _name;
  }

  int getValue() {
    return _value;
  }

}

class TbFontSize {
  final String _name;
  final String _value;
  const TbFontSize._internal(this._name, this._value);

  static const MonoType = TbFontSize._internal("Monotype", "0");
  static const FD_8x12 = TbFontSize._internal("8x12 Fixed Dot", "1");
  static const FD_12x20 = TbFontSize._internal("12x20 Fixed Dot", "2");
  static const FD_16x24 = TbFontSize._internal("16x24 Fixed Dot", "3");
  static const FD_24x32 = TbFontSize._internal("24x32 Fixed Dot", "4");
  static const FD_32x48 = TbFontSize._internal("32x48 Fixed Dot", "5");
  static const FD_14x19 = TbFontSize._internal("14x19 Fixed Dot OCR-B", "6");
  static const FD_21x27 = TbFontSize._internal("21x27 Fixed Dot OCR-B", "7");
  static const FD_14x25 = TbFontSize._internal("14x25 Fixed Dot OCR-A", "8");
  static const Roman = TbFontSize._internal("Roman.ttf", "9");
  static const EFT_1 = TbFontSize._internal("EPL2 Font 1", "1.EFT");
  static const EFT_2 = TbFontSize._internal("EPL2 Font 2", "2.EFT");
  static const EFT_3 = TbFontSize._internal("EPL2 Font 3", "3.EFT");
  static const EFT_4 = TbFontSize._internal("EPL2 Font 4", "4.EFT");
  static const EFT_5 = TbFontSize._internal("EPL2 Font 5", "5.EFT");
  static const FNT_A = TbFontSize._internal("ZPL2 Font A", "A.FNT");
  static const FNT_B = TbFontSize._internal("ZPL2 Font B", "B.FNT");
  static const FNT_D = TbFontSize._internal("ZPL2 Font D", "D.FNT");
  static const FNT_E8 = TbFontSize._internal("ZPL2 Font E8", "E8.FNT");
  static const FNT_F = TbFontSize._internal("ZPL2 Font F", "F.FNT");
  static const FNT_G = TbFontSize._internal("ZPL2 Font G", "G.FNT");
  static const FNT_H8 = TbFontSize._internal("ZPL2 Font H8", "H8.FNT");
  static const FNT_GS = TbFontSize._internal("ZPL2 Font GS", "GS.FNT");
}

class TbPrinterStatus {
  final int _value;

  static const int FLAG_NORMAL = 0x0;
  static const int FLAG_HEAD_OPENED = 0x1;
  static const int FLAG_PAPER_JAM = 0x2;
  static const int FLAG_OUT_OF_PAPER = 0x4;
  static const int FLAG_OUT_OF_RIBBON = 0x8;
  static const int FLAG_PAUSED = 0x10;
  static const int FLAG_PRINTING = 0x20;
  static const int FLAG_OTHER_ERROR = 0x80;

  const TbPrinterStatus._internal(this._value);

  Map<String, dynamic> toMap() {
    return {
      "value":_value
    };
  }

  int getStatusValue() => _value;

  static TbPrinterStatus fromMap(Map<dynamic, dynamic> map) {
    String hexValue = map["value"];
    return TbPrinterStatus._internal(int.parse(hexValue, radix: 16));
  }

  bool isHeadOpened() {
    return FLAG_HEAD_OPENED & _value != 0;
  }

  bool isPaperJam() {
    return FLAG_PAPER_JAM & _value != 0;
  }

  bool isOutOfPaper() {
    return FLAG_OUT_OF_PAPER & _value != 0;
  }

  bool isOutOfRibbon() {
    return FLAG_OUT_OF_RIBBON & _value !=0;
  }

  bool isOk() {
    return FLAG_NORMAL == _value;
  }

  bool isPaused() {
    return FLAG_PAUSED & _value != 0;
  }

  bool isPrinting() {
    return FLAG_PRINTING & _value != 0;
  }

  bool isOtherError() {
    return FLAG_OTHER_ERROR & _value != 0;
  }
}
/*
class RJ2055WB implements ALabelName {
  final String _name;
  final double _paperWidthMm;
  final double _paperHeightMm;

  const RJ2055WB._internal(this._name, this._paperWidthMm, this._paperHeightMm);

  static const W50_8 = RJ2055WB._internal("W50.8mm", 50.8, -1);
  static const UNSUPPORTED = RJ2055WB._internal("UNSUPPORTED", 0,0);

  static final _values = [
    W50_8
  ];

  String getName() {
    return _name;
  }

  static RJ2055WB valueFromName(String name) {
    for (int i = 0; i < _values.length; ++i) {
      RJ2055WB num = _values[i];
      if (num.getName() == name) {
        return num;
      }
    }
    return UNSUPPORTED;
  }

  static RJ2055WB fromMap(Map<dynamic, dynamic> map) {
    String name = map["name"];
    return RJ2055WB.valueFromName(name);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "name": _name,
      "widthMm":_paperWidthMm,
      "heightMm": _paperHeightMm
    };
  }

}
 */

/*
abstract class TbPrinter {

}

class TbBluetoothPrinter extends TbPrinter {

}
*/