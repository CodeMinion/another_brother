import 'dart:ui';

import 'package:another_brother/label_info.dart';
import 'package:another_brother/printer_info.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:another_brother/another_brother.dart';
// To add platforms, run `flutter create -t plugin --platforms <platforms> .` under another_brother.
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      //platformVersion = await AnotherBrother.platformVersion;
      platformVersion = await Printer.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<PrinterStatus> printImage() async {
    PictureRecorder recorder = PictureRecorder();
    Canvas c = Canvas(recorder);
    Paint paint = new Paint();
    paint.color = Color.fromRGBO(255, 0, 0, 1);
    Rect bounds = new Rect.fromLTWH(0, 0, 300, 100);
    c.drawRect(bounds, paint);
    var picture = await recorder.endRecording().toImage(300, 100);

    var printer = new Printer();
    var printInfo = PrinterInfo();
    printInfo.printerModel = Model.QL_1110NWB;
    printInfo.printMode = PrintMode.FIT_TO_PAGE;
    printInfo.isAutoCut = true;
    //printInfo.port = Port.BLUETOOTH;
    //printInfo.macAddress = "58:93:D8:BD:69:95"; // Printer BLuetooth Mac
    printInfo.port = Port.NET;
    printInfo.ipAddress = "192.168.1.80"; // Printer BLuetooth Mac
    //printInfo.port = Port.USB;
    printInfo.labelNameIndex = QL1100.ordinalFromID(QL1100.W103.getId());
    await printer.setPrinterInfo(printInfo);

    // Alternatively we can startCommunication/endCommunication if we
    // want to do a batch operation.
    //bool opened = await printer.startCommunication();

    // Print
    //PrinterStatus status = await printer.printImage(picture);

    //var netPrinters = await printer.getNetPrinters(["QL-1110NWB"]);
    //print ("Found Printers: $netPrinters");

    var netPrinter = await printer.getNetPrinterInfo("192.168.1.80");
    print ("Net Printer: $netPrinter");
    /*
    FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: true);

    PrinterStatus status = PrinterStatus();
    if(result != null) {
      //PrinterStatus status = await printer.printFile(result.files.single.path);
      status = await printer.printFileList(result.paths);

    } else {
      // User canceled the picker
    }*/
    
    //bool closed = await printer.endCommunication();

    //print ("Got Status: $status and Error: ${status.errorCode.getName()}");
    //return status;
    return PrinterStatus();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            Center(
              child: Text('Running on: $_platformVersion\n'),
            ),
            ElevatedButton(onPressed: (){
              printImage();
            }, child: Text("Print"))
          ],
        ),
      ),
    );
  }
}
