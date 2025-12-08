import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:another_brother/printer_info.dart';
import 'package:another_brother/type_b_commands.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
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
  ATbLabelName labelName = TbLabelName.Unsupported;

  //ALabelName? labelName;

  TbPrinterInfo(
      {String ipAddress = "",
      String portNumber = "9100",
      String btAddress = "",
      String localName = "",
      TbModel printerModel = TbModel.RJ_2055WB,
        ATbLabelName? labelName,
      this.port = Port.NET})
      : this.ipAddress = ipAddress,
        this.portNumber = portNumber,
        this.btAddress = btAddress,
        this.localName = localName,
        this.printerModel = printerModel,
        this.labelName = labelName ?? TbLabelName.Unsupported;

  Map<String, dynamic> toMap() {
    return {
      "ipAddress": ipAddress,
      "portNumber": portNumber,
      "btAddress": btAddress,
      "iOSBtPath": _btIOsPath,
      "localName": localName,
      "port": port.toMap(),
      "labelName": labelName.toMap()
    };
  }

  factory TbPrinterInfo.fromMap(Map<String, dynamic> map) {
    return TbPrinterInfo(
      ipAddress: map["ipAddress"],
      portNumber: map["portNumber"],
      btAddress: map["btAddress"],
        localName:map["localName"],
      port: Port.fromMap(map["port"]),
      labelName: TbLabelName.fromMap(map["labelName"])
    );
  }
}

class TbPrinter {
  static const MethodChannel _channel = const MethodChannel('another_brother');

  static final double _MM_IN_INCHE = 25.4;

  String _printerId = ""; // Used to link to the printer in the native side.

  TbPrinterInfo _printerInfo = TbPrinterInfo();

  static double millimeterToDots(double resolution, double millimeters) {
    return resolution * millimeters / (_MM_IN_INCHE);
  }

  static double inchesToDot(double resolution, double inches) {
    return inches / resolution;
  }

  static dotsToMillimeters(double resolution, double dots) {
    return resolution / dots * _MM_IN_INCHE;
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
  //Future<Image> downloadImageAsset(String assetKey,
  Future<bool> downloadImageAsset(String assetKey,
      {int x = 0, int y = 0, double scale = 1, int printerDpi = 203}) async {
    Image image = await BrotherUtils.loadImage(assetKey);
    return downloadImage(image,
        x: x, y: y, scale: scale, printerDpi: printerDpi);
  }

  /// Converts an image to gray scanle and sends it to the printer?
  //Future<Image> downloadImage(Image image,
  Future<bool> downloadImage(Image image,
      {int x = 0, int y = 0, double scale = 1, int printerDpi = 203}) async {
    double ratio = image.height / image.width ;
    double desiredImageWidth =
        image.width * scale; //image.height * printerDpi / 72 * scale;
    double desiredImageHeight =
        image.height * scale; //image.height * printerDpi / 72 * scale;

    // Ensure the that the sizes are a multiple of 8 because we track the widths in bytes.
    if (desiredImageWidth % 8 != 0) {
      desiredImageWidth = (desiredImageWidth ~/ 8 + 1) * 8;
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
      //int colorAa = _clampColor(inputImageBytes[colorByte + 3]);
      //print ("R:${colorR} - G:${colorG} - B:${colorB} ");
      int total = (colorR + colorG + colorB) ~/ 3;
      if (total == 0) {
        outImageBytes[(colorByte / 4) ~/ 8] ^=
            (128 >> (colorByte ~/ 4) % 8).toUnsigned(8);
      }
    }

    //BrotherUtils.printBytes(outImageBytes, pictureWidthBytes);

    /*
    String binLine = "";
    for (int i = 0; i < outImageBytes.length; i++) {
      if (i % pictureWidthBytes == 0) {
        print(binLine + " -- $i");
        binLine = "";
      }

      binLine =
          binLine + " " + (outImageBytes[i].toRadixString(2).padLeft(8, '0'));
    }

    print("String version: --- ");

    */

    if (Platform.isIOS) {
      // Since iOS does not have the sentCommand(byte[])
      //  exposed we instead write make the image a BMP and use the downloadBmp instead.
      // Convert image to BMP
      Uint8List bmpImageBytes = _wrapInWindowBmp(
          width: desiredImageWidth.toInt(),
          height: desiredImageHeight.toInt(),
          imageBytes: outImageBytes,
          printerDpi: printerDpi);

      //BrotherUtils.printBytes(bmpImageBytes, pictureWidthBytes);
      BrotherUtils.printBytesHex(bmpImageBytes, 16);

      //Image bmpImage = await BrotherUtils.bytesToImage(bmpImageBytes);
      // Save image to temp storage location.
      String tempBmpFilename = "temp.bmp"; //"temp_${DateTime.now().microsecondsSinceEpoch}.bmp";
      String tempBmpFilePath = await BrotherUtils.bytesToTempFile(
          bmpImageBytes, tempBmpFilename);
      // downloadBmp
      //bool downloadSuccess = await downloadBmp(tempBmpFilePath);
      // The position is set on the canvas instead of the put, so we
      // place at 0,0
      bool putSuccess = await sendTbCommand(
          TbCommandPutBmp(0, 0, tempBmpFilePath));
      // Delete bmp file
      await File(tempBmpFilePath).delete();
      // Return success value.
      return putSuccess;
    }
    else {
      TbCommandSendBitmap sendBitmapCmd = TbCommandSendBitmap(
          x,
          y,
          pictureWidthBytes,
          pictureHeight,
          Uint8List(outImageBytes.buffer.asUint8List().length));
      bool result = await sendTbCommand(sendBitmapCmd);
      result = result &&
          await sendCommandBin(
              outImageBytes); //sendCommand(String.fromCharCodes(outImageBytes));
      result = result && await sendCommand("\"\r\n");


      return result;
      //return bmpImage;
      //return grayPicture;

    }
  }

  /// Given a raw array of bytes of a 1-color image
  /// this method adds the windows BMP headers and
  /// returns the completed BMP bytes.
  /// Type B uses Windows BMP format (BM)
  /// Reference: https://en.wikipedia.org/wiki/BMP_file_format
  Uint8List _wrapInWindowBmp({required int width, required int height, required Uint8List imageBytes, required int printerDpi}) {

    // BMP Header
    int headerByteSize =  2 // header field
        + 4 // size of bmp file in bytes
        + 2 // Reserved
        + 2 // Reserved
        + 4 // The offset, starting address of the byte where the image data can be found
        ;

    // DIB Header
    int bitmapInfoHeaderByteSize =  4 // Size of this header in bytes (40)
        + 4 //bitmap width in pixels
        + 4 // bitmap height in pixels
        + 2 // number of color planes,
        + 2 // number of bit per pixel, 1, 4 ,8 24 or 32
        + 4 // compression method being used.
        + 4 // the size of the raw image bitmap data
        + 4 // horizontal resolution of the image
        + 4 // vertical resolution of the image
        + 4 // the number of colors in teh color palette, or 0 to default to 2^n
        + 4 // the number of important colors used, or 0 when every color is important, generally ignored
        + 8 // Color Table. because bpp < 8
    ;


    final BytesBuilder bytesBuilder = BytesBuilder();
    // BMP Header
    // Header Field - 2 bytes
    bytesBuilder.addByte(0x42); // B - 0X42
    bytesBuilder.addByte(0x4D); // M - 0x4D
    // Size of BMP in bytes - 4 bytes
    int sizeOfBmpFile = headerByteSize +  bitmapInfoHeaderByteSize + imageBytes.length;
    ByteData sizeData = ByteData(4);
    sizeData.setInt32(0, sizeOfBmpFile, Endian.little);
    bytesBuilder.add(sizeData.buffer.asUint8List());
    // Reserved - 2 bytes
    bytesBuilder.addByte(0);
    bytesBuilder.addByte(0);
    // Reserved - 2 bytes
    bytesBuilder.addByte(0);
    bytesBuilder.addByte(0);
    // Offset, - 4 bytes i.e. starting address of the byte where the image data can be found
    int imageDataOffset = headerByteSize +  bitmapInfoHeaderByteSize;
    ByteData imageDataOffsetData = ByteData(4);
    imageDataOffsetData.setInt32(0, imageDataOffset, Endian.little);
    bytesBuilder.add(imageDataOffsetData.buffer.asUint8List());

    // DIB BITMAPINFOHEADER - Start
    // Size of this header in bytes (40) - 4 bytes
    ByteData sizeOfInfoHeaderData = ByteData(4);
    sizeOfInfoHeaderData.setInt32(0, 40, Endian.little);
    bytesBuilder.add(sizeOfInfoHeaderData.buffer.asUint8List());
    // Width of the bitmap in pixels (signed integer) - 4 bytes.
    ByteData imgPixelWidthData = ByteData(4);
    imgPixelWidthData.setInt32(0, width, Endian.little);
    bytesBuilder.add(imgPixelWidthData.buffer.asUint8List());
    // Height of the bitmap in pixels - 4 bytes.
    ByteData imgPixelHeightData = ByteData(4);
    imgPixelHeightData.setInt32(0, height, Endian.little);
    bytesBuilder.add(imgPixelHeightData.buffer.asUint8List());
    // Number of color planes (must be 1) - 2 bytes
    ByteData colorPlaneData = ByteData(2);
    colorPlaneData.setInt16(0, 1, Endian.little);
    bytesBuilder.add(colorPlaneData.buffer.asUint8List());
    // Number of color per pixels - 2 Bytes
    // This is a 1-color data.
    ByteData colorPerPixelData = ByteData(2);
    colorPerPixelData.setInt16(0, 1, Endian.little);
    bytesBuilder.add(colorPerPixelData.buffer.asUint8List());
    // Compression method used - 4 bytes
    ByteData compressionMethodData = ByteData(4);
    compressionMethodData.setInt32(0, 0, Endian.little); // None
    bytesBuilder.add(compressionMethodData.buffer.asUint8List());
    // Raw size of the bitmap data - 4 bytes.
    ByteData rawBmpDataSizeData = ByteData(4);
    rawBmpDataSizeData.setInt32(0, imageBytes.length, Endian.little);
    bytesBuilder.add(rawBmpDataSizeData.buffer.asUint8List());
    // Horizontal resolution (pixel per meter) - 4 bytes
    // TODO Update to using dotsToMillimeters()
    int horizontalResolution = (printerDpi * 39.3701).toInt();
    ByteData horizontalResolutionData = ByteData(4);
    horizontalResolutionData.setInt32(0, horizontalResolution, Endian.little);
    bytesBuilder.add(horizontalResolutionData.buffer.asUint8List());
    // Vertical resolution (pixel per meter) - 4 bytes
    // TODO Update to using dotsToMillimeters()
    int verticalResolution = (printerDpi * 39.3701).toInt();
    ByteData verticalResolutionData = ByteData(4);
    verticalResolutionData.setInt32(0, verticalResolution, Endian.little);
    bytesBuilder.add(verticalResolutionData.buffer.asUint8List());
    // Number of colors in palette - 4 bytes
    ByteData colorsInPaletteData = ByteData(4);
    colorsInPaletteData.setInt32(0, 0, Endian.little);
    bytesBuilder.add(colorsInPaletteData.buffer.asUint8List());
    // Number of important colors - 4 bytes
    ByteData importantColorData = ByteData(4);
    importantColorData.setInt32(0, 0, Endian.little); // 0 - every color is important.
    bytesBuilder.add(importantColorData.buffer.asUint8List());
    // Color table, 2 colors (black and white) required if bpp <= 8
    bytesBuilder.add([0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0x00]);
    // Image Data - (imgBytes.length) bytes
    // Each row must be padded to be a multiple of 4 bytes (32 bits.)
    int requiredRowWidth = (width ~/ 32 + 1) * 32;

    if (requiredRowWidth == width) {
      // Just add since no padding is needed.
      // TODO: Revisit if image prints updside down Note the image is also built bottom up starting from the last row.
      for (int i = height -1; i >= 0; i--) {
        int start = i * width~/8;
        int end = start + width~/8;
        //print ("Start: $start - End: $end - Size: ${imageBytes.length}");
        bytesBuilder.add(imageBytes.getRange(start, end).toList());
      }

    }
    else {
      // Add row and pad with extra bits.
      int paddingBitCount = requiredRowWidth - width;
      // Important: This only works because the image width is a multiple of 8 as is
      ByteData paddingByteData = ByteData(paddingBitCount~/8);
      //for (int i = 0; i < height; i++) {
      for (int i = height -1; i >= 0; i--) {
        int start = i * width~/8;
        int end = start + width~/8;
        //print ("Start: $start - End: $end - Size: ${imageBytes.length}");
        bytesBuilder.add(imageBytes.getRange(start, end).toList());
        // TODO Revisit this because right now it's relying on the format from the data above.
        bytesBuilder.add(paddingByteData.buffer.asUint8List());
      }
    }
    // Build image data.
    Uint8List bmpBytes = bytesBuilder.toBytes();
    return bmpBytes;
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
    if (_printerInfo.printerModel == TbModel.RJ_2035B ||
        _printerInfo.printerModel == TbModel.RJ_3035B) {
      if (enable) {
        success = success && await sendCommand("BT MODE \"BT4.0\"\r\n");
        success = success && await sendCommand("SET BTLINKBACK OFF\r\n");
      } else {
        success = success && await sendCommand("BT MODE \"BT2.1\"\r\n");
        success = success && await sendCommand("SET BTLINKBACK ON\r\n");
      }
    } else {
      if (enable) {
        success = success && await sendCommand("BT MODE \"BT4.0\"\r\n");
      } else {
        success = success && await sendCommand("BT MODE \"BT2.1\"\r\n");
      }
      success = success && await sendCommand("WLAN MODULE SAVECFG\r\n");
      success = success && await sendCommand("DELAY 20000\r\n");
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
  /// Updates the firmware of the printer with the specified firmware file.
  /// @param Path to firmware file.
  Future<bool> updateFirmAsset(String assetKey) async {
    String filePath = await BrotherUtils.assetFileToPath(assetKey);
    return updateFirm(filePath);
  }

  /// Updates the firmware of the printer with the specified firmware file.
  /// @param Path to firmware file.
  Future<bool> updateFirm(String filePath) async {
    bool success = await _sendFile(filePath);
    success = success && await sendTbCommand(TbCommandRunFile(filePath));
    return success;
  }
  */
  /*
  /// Sends a file to the printer.
  Future<bool> sendFile(String filePath) async {
    var params = {
      "printerId": _printerId,
      "printInfo": _printerInfo.toMap(),
      "filePath": filePath,
      "brotherFileName": ITbCommand.pathToBrotherFileName(filePath)
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
    String filePath = await BrotherUtils.assetFileToPath(assetKey);
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
    String filePath = await BrotherUtils.assetFileToPath(assetKey);
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

  /// Returns the paried printers matching the model name specified.
  Future<List<BluetoothPrinter>> getBluetoothPrinters(
      List<String> modelName) async {
    var params = {
      "printerId": _printerId,
      "printInfo": _printerInfo.toMap(),
      "models": modelName,
    };

    final List<dynamic> resultList =
        await _channel.invokeMethod("typeB-getBluetoothPrinters", params);

    final List<BluetoothPrinter> outList = resultList
        .map((bluetoothPrinter) => TbBluetoothPrinter._(BluetoothPrinter.fromMap(bluetoothPrinter)))
        .toList();
    return outList;
  }

  /// Discover printers which are connectable via BLE. Available
  /// on Android 5.0 or later.
  Future<List<BLEPrinter>> getBLEPrinters({int timeout = 5000}) async {
    //BLE Scanning
    //FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

    // Start scanning
    FlutterBluePlus.startScan(
      // Note: For some reason it does not find the printer even though this is the service
      //withServices: [Guid("49535343-FE7D-4AE5-8FA9-9FAFD205E455"),
      // Guid("F0DD799C-C883-4976-96A5-8BB4907F41D6")
      //],
        timeout: Duration(seconds: timeout ~/ 1000));

    Set<BLEPrinter> foundDevices = {};
    // Listen to scan results
    FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult r in results) {
        debugPrint("Scan Result: ${r.device}");

        BLEPrinter foundSt = BLEPrinter(localName: r.device.localName);
        TbBlePrinter found = TbBlePrinter._(foundSt);

        // For now just filter by device name until we get service working.
        if (found.localName.startsWith(_printerInfo.printerModel.getName()) && !foundDevices.contains(found)) {
          foundDevices.add(found);
        }
      }
    });

    return await Future.delayed(
        Duration(seconds: timeout ~/ 1000), () => foundDevices.toList());
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

  List<TbRotation> getValues() => _values;
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

  static valueFromName(String name) {
    for (int i = 0; i < _values.length; i ++ ) {
      if (_values[i].getName() == name) {
        return _values[i];
      }
    }

    return GAP;
  }

  Map<String, dynamic> toMap() {
    return {
      "name": _name
    };
  }

  static TbSensor fromMap(Map<String, dynamic> map) {
    String name = map["name"];
    return valueFromName(name);
  }
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

abstract class ATbModel implements AModel {

}

class TbModel implements ATbModel {
  final String _displayName;
  final String _name;

  const TbModel._internal(this._displayName, this._name);

  factory TbModel({required String displayName, String discoveryName = "PS-"}){
    return TbModel._internal(displayName, discoveryName);
  }

  static const UNKNOWN = const TbModel._internal("UNKNOWN", "");
  static const TD_4650TNWB = const TbModel._internal("TD-4650TNWB", "PS-");
  static const TD_4750TNWB = const TbModel._internal("TD_4750TNWB", "PS-");
  static const TD_4650TNWBR = const TbModel._internal("TD-4650TNWBR", "PS-");
  static const TD_4750TNWBR = const TbModel._internal("TD-4750TNWBR", "PS-");
  static const RJ_2055WB = const TbModel._internal("RJ-2055WB", "PS-");
  static const RJ_3055WB = const TbModel._internal("RJ-3055WB", "PS-");
  static const TJ_4420TN = const TbModel._internal("TJ-4420TN", "PS-");
  static const TJ_4520TN = const TbModel._internal("TJ-4520TN", "PS-");
  static const TJ_4620TN = const TbModel._internal("TJ-4620TN", "PS-");
  static const TJ_4422TN = const TbModel._internal("TJ-4422TN", "PS-");
  static const TJ_4522TN = const TbModel._internal("TJ-4522TN", "PS-");
  static const RJ_2035B = const TbModel._internal("RJ-2035B", "PS-");
  static const RJ_3035B = const TbModel._internal("RJ-3035B", "PS-");

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
    UNKNOWN,
  ];

  List<TbModel> getValues() => List.of(_values);

  String getDisplayName() => _displayName;

  static TbModel valueFromName(String name) {
    for (int i =0; i < _values.length; i ++) {
      if (_values[i]._displayName == name) {
        return _values[i];
      }
    }
    return UNKNOWN;
  }

  /// Used for searching during things like bt.
  String getName() {
    if (Platform.isIOS) {
      return _displayName;
    }
    else {
      return _name;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "name":_name,
      "displayName": _displayName
    };
  }

  factory TbModel.fromMap(Map<String, dynamic> map) {
    String displayName = map["displayName"];
    return valueFromName(displayName);
  }
}

class BrotherUtils {

  /// Utility function for turning a byte array into a UI Image.
  /// @param imageBytes Byte array of the image.
  static Future<Image> bytesToImage(Uint8List imageBytes) async {
    final Completer<Image> completer = new Completer();
    decodeImageFromList(imageBytes, (Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  /// Utility method for getting an UI Image from a resource in the assts.
  /// @param assetPath path to retrieve the asset.
  static Future<Image> loadImage(String assetPath) async {
    final ByteData img = await rootBundle.load(assetPath);
    //BrotherUtils.printBytesHex(img.buffer.asUint8List(), 16);
    final Completer<Image> completer = new Completer();
    decodeImageFromList(new Uint8List.view(img.buffer), (Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  static Future<String> assetFileToPath(String assetKey) async {
    String fileName = assetKey
        .split("/")
        .last;
    // Load byte date from file.
    ByteData fileData = await PlatformAssetBundle().load(assetKey);
    // Save to a file.
    Directory directory = await getTemporaryDirectory();
    String dirPath = directory.path;
    File destFile = File('$dirPath/$fileName');
    destFile.writeAsBytesSync(fileData.buffer.asUint8List());
    return destFile.path;
  }

  /// Helper funtion to write a set of bytes to a temp file.
  static Future<String> bytesToTempFile(Uint8List bytesToWrite, String fileName) async {
    Directory directory = await getTemporaryDirectory();
    String dirPath = directory.path;
    File destFile = File('$dirPath/$fileName');
    destFile.writeAsBytesSync(bytesToWrite);
    return destFile.path;
  }

  static printBytes(Uint8List outImageBytes, int pictureWidthBytes) {
    String binLine = "";
    for (int i = 0; i < outImageBytes.length; i++) {
      if (i % pictureWidthBytes == 0) {
        print(binLine + " -- $i");
        binLine = "";
      }

      binLine =
          binLine + " " + (outImageBytes[i].toRadixString(2).padLeft(8, '0'));
    }
  }

  static printBytesHex(Uint8List bytes, int hexColCount) {
    String binLine = "";
    for (int i = 0; i < bytes.length; i++) {
      if (i % hexColCount == 0) {
        print(binLine + " -- $i");
        binLine = "";
      }

      binLine =
          binLine + " " + (bytes[i].toRadixString(16).padLeft(2, '0'));
    }
  }
}

abstract class ABrotherTbPrinter {
  String getName();
}

class TbBlePrinter implements BLEPrinter, ABrotherTbPrinter {
  final BLEPrinter _printer;
  const TbBlePrinter._(this._printer);

  @override
  String getName() => _printer.getName();

  @override
  String get localName => _printer.localName;

  @override
  Map<String, dynamic> toMap() => _printer.toMap();

}

class TbBluetoothPrinter implements BluetoothPrinter, ABrotherTbPrinter {
  final BluetoothPrinter _printer;
  const TbBluetoothPrinter._(this._printer);

  @override
  String getName() => _printer.getName();

  @override
  String get macAddress => _printer.macAddress;

  @override
  String get modelName => _printer.modelName;

  @override
  Map<String, dynamic> toMap() => _printer.toMap();
}

abstract class ATbLabelName extends ALabelName {

  int getWidth() => 50;
  int getHeight() => 50;
  int getSpeed() => 1;
  int getDensity() => 15;
  TbSensor getSensor() => TbSensor.GAP;
  int getSensorDistance() => 0;
  int getSensorOffset() => 0;
}

class TbLabelName implements ATbLabelName {

  static const int _kDefWidth = 50;
  static const int _kDefHeight = 50;
  static const int _kDefSpeed = 1;
  static const int _kDefDensity = 15;
  static const TbSensor _kDefSensor = TbSensor.GAP;
  static const int _kDefDistance = 0;
  static const int _kDefOffset = 0;

  final String _name;
  final int _width;
  final int _height;
  final int _speed;
  final int _density;
  final TbSensor _sensor;
  final int _sensorDistance;
  final int _sensorOffset;

  const TbLabelName._internal(this._name,
      this._width, this._height,
      this._speed, this._density,
      this._sensor, this._sensorDistance, this._sensorOffset);

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
  factory TbLabelName({required String name, int width = _kDefWidth, int height = _kDefHeight,
    int speed = _kDefSpeed,  int density = _kDefDensity, TbSensor sensor = _kDefSensor,
    int sensorDistance = _kDefDistance,
    int sensorOffset = _kDefOffset
  }) {
    return TbLabelName._internal(name, width, height, speed,
        density, sensor, sensorDistance,
        sensorOffset);
  }

  static const Unsupported = const TbLabelName._internal("UNSUPPORTED", 50, 50, 1, 15, TbSensor.GAP, 0, 0);

  static final _values = [
    Unsupported
  ];

  static getValues() => List.of(_values);

  @override
  String getName() =>_name;

  @override
  Map<String, dynamic> toMap() {
    return {
      "name": _name,
      "width": _width,
      "height": _height,
      "speed": _speed,
      "density": _density,
      "sensor": _sensor.toMap(),
      "sensorDistance": _sensorDistance,
      "sensorOffset": _sensorOffset
    };
  }

  static TbLabelName fromMap(Map<String, dynamic> map) {
    return TbLabelName(
    name: map["name"],
    width: map["width"],
      height: map["height"],
      speed: map["speed"],
      density: map["density"],
      sensor: TbSensor.fromMap(map["sensor"]),
      sensorDistance: map["sensorDistance"],
      sensorOffset: map["sensorOffset"]
    );
  }

  @override
  int getDensity() => _density;

  @override
  int getWidth() => _width;

  @override
  int getHeight() => _height;

  @override
  TbSensor getSensor() => _sensor;

  @override
  int getSensorDistance() => _sensorDistance;

  @override
  int getSensorOffset() => _sensorOffset;

  @override
  int getSpeed() => _speed;

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
