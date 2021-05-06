import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:another_brother/printer_info.dart';
import 'package:another_brother/type_b_commands.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import 'label_info.dart';

class TbPrinterInfo {
  String ipAddress;
  String portNumber;
  String btAddress;
  String localName; // For BLE
  Port port;
  String _btIOsPath = "com.issc.datapath";
  TbModel printerModel;

  //ALabelName? labelName;

  TbPrinterInfo(
      {String ipAddress = "",
      String portNumber = "9100",
      String btAddress = "",
        String localName = "",
        TbModel printerModel = TbModel.RJ_2055WB,
      this.port = Port.NET})
      : this.ipAddress = ipAddress,
        this.portNumber = portNumber,
        this.btAddress = btAddress,
        this.localName = localName,
        this.printerModel = printerModel;

  Map<String, dynamic> toMap() {
    return {
      "ipAddress": ipAddress,
      "portNumber": portNumber,
      "btAddress": btAddress,
      "iOSBtPath": _btIOsPath,
      "localName": localName,
      "port": port.toMap()
    };
  }
}

class TbPrinter {
  static const MethodChannel _channel = const MethodChannel('another_brother');

  static final double _MM_IN_INCHE = 25.4;

  String _printerId = ""; // Used to link to the printer in the native side.

  TbPrinterInfo _printerInfo = TbPrinterInfo();

  static double millimeterToDots(double resolution, double millimeters) {
    return millimeters / (resolution * _MM_IN_INCHE);
  }

  static double inchesToDot(double resolution, double inches) {
    return inches / resolution;
  }

  static dotsToMillimeters(double resolution, double dots) {
    return resolution / dots * _MM_IN_INCHE;
  }

  static Future<Image> loadImage(String assetPath) async {
    final ByteData img = await rootBundle.load(assetPath);
    final Completer<Image> completer = new Completer();
    decodeImageFromList(new Uint8List.view(img.buffer), (Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  TbPrinter({TbPrinterInfo? printerInfo}) {
    if (printerInfo != null) {
      this._printerInfo = printerInfo;
    }
  }

  /// Sets the printer info for this printer.
  /// @param printerInfo TbPrinterInfo with some initial information about the printer.
  Future<bool> setPrinterInfo(TbPrinterInfo printerInfo) async {
    this._printerInfo = printerInfo;
    return true;
  }

  /// Open the communication to the printer.
  /// returns true on success, false on failure.
  Future<bool> startCommunication() async {
    var params = {
      "printerId": _printerId,
      "printInfo": _printerInfo.toMap(),
    };

    final String printerId =
        await _channel.invokeMethod("typeB-startCommunication", params);
    _printerId = printerId;
    return _printerId.isNotEmpty;
  }

  /// Close the communication to the printer.
  /// @param timeout in milliseconds.
  /// returns true on success, false on failure
  Future<bool> endCommunication({int timeoutMillis = 1000}) async {
    var params = {
      "printerId": _printerId,
      "printInfo": _printerInfo.toMap(),
      "timeout": timeoutMillis
    };

    final String result =
        await _channel.invokeMethod("typeB-endCommunication", params);
    _printerId = result;

    return _printerId.isEmpty;

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
  /// @sensorDistance Sensor Distance - Vertical gap height of the gap/black mark in mm
  /// @sensorOffset Sensor Offset - Shift distance of the gap/black mark in mm.
  Future<bool> setup(
      {int width = 50,
      int height = 50,
      double speed = 1,
      int density = 15,
      TbSensor sensor = TbSensor.GAP,
      int sensorDistance = 0,
      int sensorOffset = 0}) async {
    var params = {
      "printerId": _printerId,
      "printInfo": _printerInfo.toMap(),
      "width": width,
      "height": height,
      "speed": speed,
      "density": density,
      "sensor": sensor.getValue(),
      "sensorDistance": sensorDistance,
      "sensorOffset": sensorOffset
    };

    final bool success = await _channel.invokeMethod("typeB-setup", params);

    return success;
  }

  /// Clears the printer image buffer.
  Future<bool> clearBuffer() async {
    var params = {
      "printerId": _printerId,
      "printInfo": _printerInfo.toMap(),
    };

    final bool success =
        await _channel.invokeMethod("typeB-clearBuffer", params);
    return success;
  }

  /// Clears the printer image buffer.
  Future<bool> noBackFeed() async {
    var params = {
      "printerId": _printerId,
      "printInfo": _printerInfo.toMap(),
    };

    final bool success =
        await _channel.invokeMethod("typeB-noBackFeed", params);
    return success;
  }

  /// Skip to next of of the form
  Future<bool> formFeed() async {
    var params = {
      "printerId": _printerId,
      "printInfo": _printerInfo.toMap(),
    };

    final bool success = await _channel.invokeMethod("typeB-formFeed", params);
    return success;
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
  Future<bool> barcode(String content,
      {int x = 0,
      int y = 0,
      BarcodeType type = BarcodeType.Bc_128,
      int height = 40,
      HumanReadableAlignment humanReadable = HumanReadableAlignment.Center,
      TbRotation rotation = TbRotation.None,
      int narrowBarRatio = 2,
      int wideBarRatio = 2}) async {
    var params = {
      "printerId": _printerId,
      "printInfo": _printerInfo.toMap(),
      "content": content,
      "x": x,
      "y": y,
      "type": type.getValue(),
      "height": height,
      "humanReadable": humanReadable.getValue(),
      "rotation": rotation.getValue(),
      "narrowBarRatio": narrowBarRatio,
      "wideBarRatio": wideBarRatio
    };

    final bool success = await _channel.invokeMethod("typeB-barcode", params);

    return success;
  }

  /// Defines a font data string.
  /// @param x x-coordinate of the text in dots
  /// @param y y-coordinate of the text in dots.
  /// @param size predefined font size to use
  /// @param rotation rotation of the text.
  /// @param xMultiplication horizontal multiplication ranged 1~10
  /// @param yMultiplication vertical multiplication ranged 1~10
  Future<bool> printerFont(String content,
      {int x = 0,
      int y = 0,
      TbFontSize size = TbFontSize.MonoType,
      TbRotation rotation = TbRotation.None,
      int xMultiplication = 10,
      int yMultiplication = 10}) async {
    var params = {
      "printerId": _printerId,
      "printInfo": _printerInfo.toMap(),
      "content": content,
      "x": x,
      "y": y,
      "size": size.getValue(),
      "rotation": rotation.getValue(),
      "xMultiplication": xMultiplication,
      "yMultiplication": yMultiplication
    };

    final bool success =
        await _channel.invokeMethod("typeB-printerFont", params);
    return success;
  }

  /// Sends the given commend to the printer.
  /// @param message command to send.
  Future<bool> sendCommand(String message) async {
    var params = {
      "printerId": _printerId,
      "printInfo": _printerInfo.toMap(),
      "command": message
    };

    final bool success =
        await _channel.invokeMethod("typeB-sendCommand", params);
    return success;
  }

  /// Sends the given commend to the printer.
  /// @param message command to send.
  Future<bool> sendCommandBin(Uint8List data) async {
    var params = {
      "printerId": _printerId,
      "printInfo": _printerInfo.toMap(),
      "data": data
    };

    final bool success =
        await _channel.invokeMethod("typeB-sendCommandBin", params);
    return success;
  }

  /// Sends a command to the printer.
  Future<bool> sendTbCommand(ITbCommand command) async {
    return sendCommand(command.getCommand());
  }


  /// Downloads the image from the Flutter assets into the printer
  /// under the specified file name,
  Future<bool> downloadImageAsset(String assetKey, {int x = 0, int y = 0, double scale = 1, int printerDpi = 203}) async {
    Image image = await TbPrinter.loadImage(assetKey);
    return downloadImage(image, x:x, y:y, scale: scale, printerDpi: printerDpi);
  }

  /// Converts an image to gray scanle and sends it to the printer?
  Future<bool> downloadImage(Image image,
      {int x = 0, int y = 0, double scale = 1, int printerDpi = 203}) async {

    double ratio = image.width / image.height;
    double desiredImageWidth =
        image.width * scale; //image.height * printerDpi / 72 * scale;
    double desiredImageHeight =
        image.height * scale; //image.height * printerDpi / 72 * scale;

    // Ensure the that the sizes are a multiple of 8 because we track the widths in bytes.
    if (desiredImageWidth % 8 != 0) {
      desiredImageWidth = (desiredImageWidth~/8 + 1) * 8;
      desiredImageHeight = desiredImageWidth * ratio;
    }

    print(
        "Desired Width: ${desiredImageWidth} - Desired Height ${desiredImageHeight}");

    //Draw the image to gray scale
    PictureRecorder recorder = PictureRecorder();
    Canvas canvas = Canvas(recorder);
    Paint paint = new Paint()
      ..colorFilter = ColorFilter.mode(Color(0xFF000000), BlendMode.color);
    Rect scrRect =
        Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble());
    Rect destRect = Rect.fromLTWH(0, 0, desiredImageWidth, desiredImageHeight);
    canvas.drawImageRect(image, scrRect, destRect, paint);

    //Save canvas to new image
    var grayPicture = await recorder
        .endRecording()
        .toImage((desiredImageWidth).toInt(), (desiredImageHeight).toInt());

    // Get new image bytes.
    ByteData? imageByteData =
        await grayPicture.toByteData(format: ImageByteFormat.rawRgba);
    print("Rgb Size ${imageByteData?.lengthInBytes}");

    imageByteData =
        await grayPicture.toByteData(format: ImageByteFormat.rawUnmodified);
    print("Raw Unmodified Size ${imageByteData?.lengthInBytes}");

    if (imageByteData == null) {
      return false;
      //return image;
    }

    int pictureWidthBytes = (grayPicture.width + 7) ~/ 8;
    int pictureHeight = grayPicture.height;
    Uint8List outImageBytes = Uint8List(pictureWidthBytes * pictureHeight);

    for (int y = 0; y < pictureHeight * pictureWidthBytes; ++y) {
      outImageBytes[y] = -1.toUnsigned(8);
    }

    Uint8List inputImageBytes = imageByteData.buffer.asUint8List();
    for (int colorByte = 0;
        colorByte < inputImageBytes.length;
        colorByte += 4) {
      int colorR = _clampColor(inputImageBytes[colorByte]);
      int colorG = _clampColor(inputImageBytes[colorByte + 1]);
      int colorB = _clampColor(inputImageBytes[colorByte + 2]);
      int colorAa = _clampColor(inputImageBytes[colorByte + 3]);
      //print ("R:${colorR} - G:${colorG} - B:${colorB} ");
      int total = (colorR + colorG + colorB) ~/ 3;
      if (total == 0) {
        outImageBytes[(colorByte / 4) ~/ 8] ^=
            (128 >> (colorByte ~/ 4) % 8).toUnsigned(8);
      }
    }

    String binLine = "";
    for (int i = 0; i < outImageBytes.length; i++) {
      if (i % pictureWidthBytes == 0) {
        print(binLine + " -- $i");
        binLine = "";
      }

      binLine =
          binLine + " " + (outImageBytes[i].toRadixString(2).padLeft(8, '0'));
    }

    TbCommandSendBitmap sendBitmapCmd = TbCommandSendBitmap(
        x, y, pictureWidthBytes, pictureHeight,
        Uint8List(outImageBytes.buffer.asUint8List().length));
    bool result = await sendTbCommand(sendBitmapCmd);
    result = result &&
        await sendCommandBin(
            outImageBytes); //sendCommand(String.fromCharCodes(outImageBytes));
    result = result && await sendCommand("\"\r\n");

    return result;

    //return grayPicture;
  }

  /// Clams the colors to either 0 or 1
  int _clampColor(int color) {
    if (color < 255 / 2) {
      return 0;
    } else
      return 1;
  }
  
  /// Call to enable disable BLE
  Future<bool> toggleBle(bool enable) async {
    bool success = true;
    if (_printerInfo.printerModel == TbModel.RJ_2035B 
    || _printerInfo.printerModel == TbModel.RJ_3035B) {
      if (enable) {
        success = success && await sendCommand("BT MODE \"BT4.0\"\r\n");
        success = success && await sendCommand("SET BTLINKBACK OFF\r\n");
      }
      else {
        success = success && await sendCommand("BT MODE \"BT2.1\"\r\n");
        success = success && await sendCommand("SET BTLINKBACK ON\r\n");
      }
    }
    else {
      if (enable) {
        success = success && await sendCommand("BT MODE \"BT4.0\"\r\n");
      }
      else {
        success = success && await sendCommand("BT MODE \"BT2.1\"\r\n");
      }
      success = success && await sendCommand("WLAN MODULE SAVECFG\r\n");
      success = success && await sendCommand("INITIALPRINTER\r\n");
    }
    return success;
  }
  /// Prints the configure label.
  Future<bool> printLabel({int quantity = 1, int copy = 1}) async {
    var params = {
      "printerId": _printerId,
      "printInfo": _printerInfo.toMap(),
      "quantity": quantity,
      "copy": copy
    };

    final bool success =
        await _channel.invokeMethod("typeB-printLabel", params);
    return success;
  }

  /*
   // TODO
  /// Sends a file to the printer.
  Future<bool> sendFile(String filePath) async {
    var params = {
      "printerId": _printerId,
      "printInfo": _printerInfo.toMap(),
      "filePath": filePath
    };

    final bool success = await _channel.invokeMethod("typeB-sendFile", params);

    return success;
  }

   */

  /// Returns the status of the printer.
  Future<TbPrinterStatus> printerStatus({int delayMillis = 1000}) async {
    var params = {
      "printerId": _printerId,
      "printInfo": _printerInfo.toMap(),
      "delayMillis": delayMillis
    };

    final Map<dynamic, dynamic> dartStatus =
        await _channel.invokeMethod("typeB-printerStatus", params);
    print("Dart Status ${dartStatus}");

    return TbPrinterStatus.fromMap(dartStatus);
  }

  /// Downloads the BMP file from the Flutter assets into the printer
  /// under the specified file name,
  Future<bool> downloadPcxAsset(String assetKey) async {
    String filePath = await _assetFileToPath(assetKey);
    return downloadPcx(filePath);
  }

  /// Downloads a PCX file to the printer.
  Future<bool> downloadPcx(String filePath) async {
    var params = {
      "printerId": _printerId,
      "printInfo": _printerInfo.toMap(),
      "filePath": filePath,
      "brotherFileName": ITbCommand.pathToBrotherFileName(filePath)
    };

    final bool success =
        await _channel.invokeMethod("typeB-downloadPcx", params);

    return success;
  }

  /// Downloads the BMP file from the Flutter assets into the printer
  /// under the specified file name,
  Future<bool> downloadBmpAsset(String assetKey) async {
    String filePath = await _assetFileToPath(assetKey);
    return downloadBmp(filePath);
  }

  /// Downloads a BMP File to the printer.
  Future<bool> downloadBmp(String filePath) async {
    var params = {
      "printerId": _printerId,
      "printInfo": _printerInfo.toMap(),
      "filePath": filePath,
      "brotherFileName": ITbCommand.pathToBrotherFileName(filePath)
    };

    print(
        "Downloaded File Name: ${ITbCommand.pathToBrotherFileName(filePath)}");
    final bool success =
        await _channel.invokeMethod("typeB-downloadBmp", params);
    return success;
  }

  Future<String> _assetFileToPath(String assetKey) async {
    String fileName = assetKey.split("/").last;
    // Load byte date from file.
    ByteData fileData = await PlatformAssetBundle().load(assetKey);
    // Save to a file.
    Directory directory = await getTemporaryDirectory();
    String dirPath = directory.path;
    File destFile = File('$dirPath/$fileName');
    destFile.writeAsBytesSync(fileData.buffer.asUint8List());
    return destFile.path;
  }

  /// Returns the paried printers matching the model name specified.
  Future<List<BluetoothPrinter>> getBluetoothPrinters(List<String> modelName) async {

    var params = {
      "printerId": _printerId,
      "printInfo": _printerInfo.toMap(),
      "models" : modelName,
    };

    final List<dynamic> resultList = await _channel.invokeMethod("typeB-getBluetoothPrinters", params);

    final List<BluetoothPrinter> outList = resultList.map( (bluetoothPrinter) => BluetoothPrinter.fromMap(bluetoothPrinter)).toList();
    return outList;
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

  String getValue() {
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

  static final _values = [None, Left, Center, Right];

  String getName() {
    return _name;
  }

  int getValue() {
    return _value;
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

  static final _values = [None, CW90, CW180, CW270];

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

  String getName() => _name;

  String getValue() => _value;
}

class TbSensor {
  final String _name;
  final int _value;

  const TbSensor._internal(this._name, this._value);

  static const GAP = TbSensor._internal("GAP", 0);
  static const BLINE = TbSensor._internal("BLINE", 1);

  static final _values = [GAP, BLINE];

  String getName() => _name;

  int getValue() => _value;
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
    return {"value": _value};
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
    return FLAG_OUT_OF_RIBBON & _value != 0;
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

class TbModel {
  final String _displayName;
  final String _name;

  const TbModel(this._displayName, this._name);

  static const TD_4650TNWB = const TbModel("TD-4650TNWB", "PS-");
  static const TD_4750TNWB = const TbModel("TD_4750TNWB", "PS-");
  static const TD_4650TNWBR = const TbModel("TD-4650TNWBR", "PS-");
  static const TD_4750TNWBR = const TbModel("TD-4750TNWBR", "PS-");
  static const RJ_2055WB = const TbModel("RJ-2055WB", "PS-");
  static const RJ_3055WB = const TbModel("RJ-3055WB", "PS-");
  static const TJ_4420TN = const TbModel("TJ-4420TN", "PS-");
  static const TJ_4520TN = const TbModel("TJ-4520TN", "PS-");
  static const TJ_4620TN = const TbModel("TJ-4620TN", "PS-");
  static const TJ_4422TN = const TbModel("TJ-4422TN", "PS-");
  static const TJ_4522TN = const TbModel("TJ-4522TN", "PS-");
  static const RJ_2035B = const TbModel("RJ-2035B", "PS-");
  static const RJ_3035B = const TbModel("RJ-3035B", "PS-");

  static final _values = [
    TD_4650TNWB,
    TD_4650TNWB,
    TD_4650TNWBR,
    TD_4750TNWBR,
    RJ_2035B,
    RJ_2055WB,
    RJ_3035B,
    RJ_3055WB,
    TJ_4420TN,
    TJ_4520TN,
    TJ_4620TN,
    TJ_4422TN,
    TJ_4522TN,
  ];

  List<TbModel> getValues() => _values;

  String getDisplayName() => _displayName;

  /// Used for searching during things like bt.
  String getName() => _name;

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
