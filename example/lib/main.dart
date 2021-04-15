import 'dart:io';
import 'dart:ui';

import 'package:another_brother/label_info.dart';
import 'package:another_brother/printer_info.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:another_brother/another_brother.dart';
import 'package:flutter_blue/flutter_blue.dart';

//import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart';
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
  File _selectedImage = null;

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

  Future<PrinterStatus> printImageUsb() async {

    PictureRecorder recorder = PictureRecorder();
    Canvas c = Canvas(recorder);
    Paint paint = new Paint();
    paint.color = Color.fromRGBO(255, 0, 0, 1);
    Rect bounds = new Rect.fromLTWH(0, 0, 300, 100);
    c.drawRect(bounds, paint);
    var picture = await recorder.endRecording().toImage(300, 100);

    var printer = new Printer();
    var printInfo = PrinterInfo();
    printInfo.port = Port.BLUETOOTH;
    //printInfo.printerModel = Model.QL_1110NWB;
    //printInfo.macAddress = "58:93:D8:BD:69:95"; // Printer Bluetooth Mac
    printInfo.printerModel = Model.RJ_4250WB;
    //printInfo.macAddress = "F8:5B:3B:70:BF:57"; // Printer Bluetooth Mac
    printInfo.macAddress = "69:50:C6:D5:33:0E"; // Printer Bluetooth Mac
    printInfo.printMode = PrintMode.FIT_TO_PAGE;
    printInfo.isAutoCut = true;

    double width = 102.0;
    double rightMargin = 0.0;
    double leftMargin = 0.0;
    double topMargin = 0.0;
    CustomPaperInfo customPaperInfo = CustomPaperInfo.newCustomRollPaper(printInfo.printerModel,
        Unit.Mm,
        width,
        rightMargin,
        leftMargin,
        topMargin);
    printInfo.customPaperInfo = customPaperInfo;
    //printInfo.port = Port.NET;
    //printInfo.ipAddress = "192.168.1.80"; // Printer Bluetooth Mac
    //printInfo.port = Port.USB;
    // Note: This request stopped working, revisit.
    //LabelInfo info = await printer.getLabelInfo();
    //print ("Label Info $info");

    //printInfo.labelNameIndex = info.labelNameIndex; //QL1100.ordinalFromID(QL1100.W103.getId());
    printInfo.labelNameIndex = QL1100.ordinalFromID(QL1100.W103.getId());

    PrinterStatus status = PrinterStatus();

    //await printer.setPrinterInfo(printInfo);
    //status  = await printer.printImage(picture);
    print ("Got Status: $status and Error: ${status.errorCode.getName()}");


    //LabelInfo info = await printer.getLabelInfo();
    //print ("Label Info $info");


    // Alternatively we can startCommunication/endCommunication if we
    // want to do a batch operation.
    //bool opened = await printer.startCommunication();

    // Print
    //PrinterStatus status = await printer.printImage(picture);

    //var netPrinters = await printer.getNetPrinters([Model.QL_1110NWB.getName()]);
    //print ("Found Printers: $netPrinters");

    //List<TemplateInfo> templates = [];
    //status = await printer.getTemplateList(templates);
    //print ("Found Templates: $templates");

    //BatteryInfo battInfo = await printer.getBatteryInfo();
    //print ("Found Battery Info: $battInfo");

    //status = await printer.updatePrinterSettings({PrinterSettingItem.RESET: ""});
    //print("Settings Status $status");

    //status = await printer.updatePrinterSettings({PrinterSettingItem.BT_DEVICENAME: "QL-1110NWB7078"});
    //print("Settings Status $status");

    //Map<PrinterSettingItem, String> outValues = {};
    //status = await printer.getPrinterSettings([PrinterSettingItem.BT_DEVICENAME], outValues);
    //print ("Settings: ${outValues}");

    //var netPrinter = await printer.getNetPrinterInfo("192.168.1.80");
    //print ("Net Printer: $netPrinter");

    var blePrinters = await printer.getBLEPrinters(3000);
    print ("BLE Printer: $blePrinters");

    if (blePrinters.isNotEmpty) {
      printInfo.port = Port.BLE;
      printInfo.setLocalName(blePrinters.single.localName);
      printer.setPrinterInfo(printInfo);
      status  = await printer.printImage(picture);

    }

    FilePickerResult result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['jpg', /*'pdf' ,*/ 'png']);

    //PrinterStatus status = PrinterStatus();
    if(result != null) {
      setState(() {
        //_selectedImage = File(result.files.single.path);
      });
      status = await printer.printFile(result.files.single.path);
      //int pages = await printer.getPdfFilePages(result.files.single.path);
      //print ("Pages in PDF: $pages");
      //status = await printer.printPdfFile(result.paths.single, 1);

    } else {
      // User canceled the picker
    }


    //bool closed = await printer.endCommunication();

    //print ("Got Status: $status and Error: ${status.errorCode.getName()}");
    print ("Got Status: $status and Error: ${status.errorCode.getName()}");
    return status;
    //return PrinterStatus();
  }

  Future<PrinterStatus> printBle() async {

      var printer = new Printer();
      var printInfo = PrinterInfo();
      printInfo.printerModel = Model.RJ_4250WB;
      printInfo.printMode = PrintMode.FIT_TO_PAGE;
      printInfo.isAutoCut = true;
      printInfo.rotate180 = false;
      printInfo.port = Port.BLE;
      printInfo.setLocalName("RJ-4250WB_5113");
      //printInfo.port = Port.BLUETOOTH;
      //printInfo.macAddress = "795B8714-AC40-6FFE-C8D0-4FFF6D67D056";
      //printInfo.setLocalName("RJ-4250WB_5113");

      // Set the label type.
      double width = 102.0;
      double rightMargin = 0.0;
      double leftMargin = 0.0;
      double topMargin = 0.0;
      CustomPaperInfo customPaperInfo = CustomPaperInfo.newCustomRollPaper(printInfo.printerModel,
          Unit.Mm,
          width,
          rightMargin,
          leftMargin,
          topMargin);
      printInfo.customPaperInfo = customPaperInfo;

      // Set the printer info so we can use the SDK to get the printers.
      await printer.setPrinterInfo(printInfo);

      PictureRecorder recorder = PictureRecorder();
      Canvas c = Canvas(recorder);
      Paint paint = new Paint();
      paint.color = Color.fromRGBO(255, 0, 0, 1);
      Rect bounds = new Rect.fromLTWH(0, 0, 300, 100);
      c.drawRect(bounds, paint);
      var picture = await recorder.endRecording().toImage(300, 100);
      //PrinterStatus status = await printer.printImage(picture);

      //FilePickerResult result = await FilePicker.platform.pickFiles();

      FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: true,
          type: FileType.custom,
          allowedExtensions: ['jpg', 'pdf', 'png']);


      PrinterStatus status = PrinterStatus();
      if(result != null) {
        setState(() {
          //_selectedImage = File(result.files.first.path);
        });
        //status = await printer.printFile(result.files.single.path);
        // Get Information about currently loaded paper
        //LabelInfo labelInfo = await printer.getLabelInfo();
        //print ("Label Info: $labelInfo");
        //LabelParam labelParam = await printer.getLabelParam();
        //print ("Label Param $labelParam");

        //status = await printer.printFileList(result.paths);
        status = await printer.printPdfFile(result.paths.first, 2);

      } else {
        // User canceled the picker
      }


  }
  Future<PrinterStatus> printImageBluetooth() async {


    //BLE Scanning
    FlutterBlue flutterBlue = FlutterBlue.instance;

    // Start scanning
    flutterBlue.startScan(timeout: Duration(seconds: 4));

    // Listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.device.id.id}');
      }
    });

    // Stop scanning
    flutterBlue.stopScan();

    var printer = new Printer();
    var printInfo = PrinterInfo();
    printInfo.printerModel = Model.QL_1110NWB;
    printInfo.printMode = PrintMode.FIT_TO_PAGE;
    printInfo.isAutoCut = true;
    printInfo.port = Port.BLUETOOTH;
    printInfo.macAddress = "58:93:D8:BD:69:95"; // Printer BLuetooth Mac
    //printInfo.port = Port.NET;
    //printInfo.ipAddress = "192.168.1.80"; // Printer Bluetooth Mac

    // Ask the printer what label it has on.
    //printInfo.labelNameIndex = (await printer.getLabelInfo()).labelNameIndex; //QL1100.ordinalFromID(QL1100.W103.getId());
    printInfo.labelNameIndex = QL1100.ordinalFromID(QL1100.W103.getId());
    await printer.setPrinterInfo(printInfo);

    PictureRecorder recorder = PictureRecorder();
    Canvas c = Canvas(recorder);
    Paint paint = new Paint();
    paint.color = Color.fromRGBO(255, 0, 0, 1);
    Rect bounds = new Rect.fromLTWH(0, 0, 300, 100);
    c.drawRect(bounds, paint);
    var picture = await recorder.endRecording().toImage(300, 100);
    //PrinterStatus status = await printer.printImage(picture);


    FilePickerResult result = await FilePicker.platform.pickFiles();

    //FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: true,
    //    type: FileType.custom,
    //    allowedExtensions: ['jpg', 'pdf', 'png']);


    PrinterStatus status = PrinterStatus();
    if(result != null) {
      setState(() {
        _selectedImage = File(result.files.single.path);
      });
      status = await printer.printFile(result.files.single.path);
      // Get Information about currently loaded paper
      //LabelInfo labelInfo = await printer.getLabelInfo();
      //print ("Label Info: $labelInfo");
      //LabelParam labelParam = await printer.getLabelParam();
      //print ("Label Param $labelParam");

      //status = await printer.printFileList(result.paths);

    } else {
      // User canceled the picker
    }



    print ("Got Status: $status and Error: ${status.errorCode.getName()}");
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text('Running on: $_platformVersion\n'),
            ),
            _selectedImage != null ? Image.file(_selectedImage): Text("No Image Selected"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(onPressed: (){
                    printImageUsb();
                  }, child: Text("Print USB")),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(onPressed: (){
                    printBle();
                    //printImageBluetooth();
                  }, child: Text("Print Bluetooth")),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
