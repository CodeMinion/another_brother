import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:another_brother/custom_paper.dart';
import 'package:another_brother/label_info.dart';
import 'package:another_brother/printer_info.dart';
import 'package:another_brother/type_b_commands.dart';
import 'package:another_brother/type_b_printer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import "dart:ui" as ui;
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:another_brother/another_brother.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

//import 'package:flutter_scan_bluetooth/flutter_scan_bluetooth.dart';
// To add platforms, run `flutter create -t plugin --platforms <platforms> .` under another_brother.
void main() {
  runApp(MyApp());
  //runApp(TbPrinterSetup());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  File? _selectedImage;

  ui.Image? _imageToShow;
  Uint8List? _imageBytes;

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

  Future<TbPrinterStatus> printLabelTypeB() async {

    TbPrinterInfo printerInfo = TbPrinterInfo(
      printerModel: TbModel.RJ_3035B,
        port: Port.BLUETOOTH,
        //port: Port.USB,
      //btAddress: "34:81:F4:9A:5A:EC"
    );


    //TbPrinterInfo printerInfo =
    //    TbPrinterInfo(port: Port.NET, ipAddress: "10.0.0.35");

    /*
    TbPrinterInfo printerInfo = TbPrinterInfo(
        port: Port.USB);
    */
    TbPrinter printer = TbPrinter();

    await printer.setPrinterInfo(printerInfo);

    //var printersFound = await printer.getBLEPrinters();
    //print ("Found LE Printers: $printersFound");
    var printerFound = await printer.getBluetoothPrinters([TbModel.RJ_3035B.getName()]);
    print("Found Printers: $printerFound");

    printerInfo.btAddress = printerFound.single.macAddress;
    await printer.setPrinterInfo(printerInfo);

    bool success = false;
    success = await printer.startCommunication();
    print("TypeB: Connection Success? $success");

    //bool bleEnabled = await printer.toggleBle(false);
    //print("BLE Enabled: $bleEnabled");

    //success = await printer.formFeed();
    //print ("TypeB: Form Feed Success? $success");

    //success = await printer.downloadPcxAsset("assets/UL.PCX");
    //print ("TypeB: Download PCX Success? $success");

    //success = await printer.downloadBmpAsset("assets/LOGO.BMP");
    //print ("TypeB: Download BMP Success? $success");

    success = await printer.setup();
    print ("TypeB: Print Setup Success? $success");

    success = await printer.clearBuffer();
    print ("TypeB: Clear Buffer Success? $success");

    //success = await printer.barcode("1234567");
    //print ("TypeB: Barcode Success? $success");

    //success = await printer.printerFont("printerFont", x: 10, y: 150);
    //print ("TypeB: Printer Font Success? $success");

    //success = await printer.sendCommand("PUTPCX 145,15,\"UL.PCX\"\r\n");
    //success = await printer.sendTbCommand(TbCommandPutPcx(145, 15, "assets/UL.PCX"));
    //print ("TypeB: Send Command Success? $success");

    //success = await printer.sendCommand("PUTBMP 10,190,\"LOGO.BMP\"\r\n");
    //success = await printer.sendTbCommand(TbCommandPutBmp(10, 190, "assets/LOGO.BMP"));
    //print ("TypeB: Send Command Success? $success");

    //var assetImage = await loadImage("assets/brother_hack.png");
    //success = await printer.downloadImage(assetImage, scale: 0.6);
    success = await printer.downloadImageAsset("assets/brother_hack.png", x: 10, y:10, scale: 0.6);
    //success = await printer.downloadImageAsset("assets/LOGO.BMP", scale: 1, printerDpi: 95);
    print ("TypeB: Image Download Success? $success");

    //var grayImage = await printer.downloadImageAsset("assets/brother_hack.png", scale: 0.2);
    //_imageBytes = (await grayImage.toByteData(format: ImageByteFormat.rawUnmodified)).buffer.asUint8List();
    //setState(() {
    //_imageToShow = grayImage;
    //});

    //print ("TypeB: Image Download Success? $success");

    //success = await printer.printLabel();
    //print ("TypeB: Print Success? $success");

    //success = await printer.sendTbCommand(TbCommandSetWlanSsid(""));
    //success = await printer.sendTbCommand(TbCommandSetWlanSsid(null));
    //print("TypeB: WLAN Set Command Success? $success");

    //success = await printer.sendTbCommand(TbCommandSetWlanWpa(passKey: ""));
    //print("TypeB: WPA Set Command Success? $success");

    //success = await printer.sendTbCommand(TbCommandSetWlanIp(ipAddress: "10.0.0.35", gatewayAddress: "10.0.0.1"));
    //print("TypeB: WPA Set Command Success? $success");

    //success = await printer.sendTbCommand(TbCommandSetWlanDhcp());
    //print ("TypeB: DHCP Set Command Success? $success");

    //success = await printer.sendTbCommand(TbCommandSelfTest(page: TbSelfTestPage.SYSTEM));
    //print("TypeB: WLAN Test Command Success? $success");

    success = await printer.printLabel();
    print ("TypeB: Print Success? $success");

    TbPrinterStatus printerStatus = await printer.printerStatus();
    print ("TypeB: Printer Status? ${printerStatus.getStatusValue()}");

    // Delete all files downloaded to the printer memory
    success = await printer.sendTbCommand(TbCommandDeleteFile());
    print ("TypeB: Delete delete Success? $success");

    //bool fileSent = await printer.updateFirmAsset("assets/RJ-3035B_EZC_B1.00.Q38.NEW");
    //print("File Sent: $fileSent");

    success = await printer.endCommunication(timeoutMillis: 50000);
    print("TypeB: Connection Closed? $success");

    return printerStatus;
  }

  Future<ui.Image> loadImage(String assetPath) async {
    final ByteData img = await rootBundle.load(assetPath);
    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(new Uint8List.view(img.buffer), (ui.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }

  Future<PrinterStatus> printImageUsb() async {
    PictureRecorder recorder = PictureRecorder();
    Canvas c = Canvas(recorder);
    Paint paint = new Paint();
    paint.color = Color.fromRGBO(255, 0, 0, 1);
    Rect bounds = new Rect.fromLTWH(0, 0, 300, 100);
    c.save();
    c.translate(150, 150);
    c.rotate(1.57);
    c.translate(-150, -150);
    c.drawRect(bounds, paint);

    c.restore();

    var picture = await recorder.endRecording().toImage(300, 300);

    _imageBytes = (await picture.toByteData(format: ImageByteFormat.png))
        !.buffer
        .asUint8List();
    setState(() {
      //_imageToShow = picture;
    });

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

    printInfo.paperSize = PaperSize.CUSTOM;
    printInfo.binCustomPaper = BinPaper_RJ4250.RD_W4in;

    /*
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
     */
    //printInfo.port = Port.NET;
    //printInfo.ipAddress = "192.168.1.80"; // Printer Bluetooth Mac
    //printInfo.port = Port.USB;
    // Note: This request stopped working, revisit.
    //LabelInfo info = await printer.getLabelInfo();
    //print ("Label Info $info");

    //printInfo.labelNameIndex = info.labelNameIndex; //QL1100.ordinalFromID(QL1100.W103.getId());
    //printInfo.labelNameIndex = QL1100.ordinalFromID(QL1100.W103.getId());

    PrinterStatus status = PrinterStatus();

    //await printer.setPrinterInfo(printInfo);
    //status  = await printer.printImage(picture);
    //print ("Got Status: $status and Error: ${status.errorCode.getName()}");

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
    print("BLE Printer: $blePrinters");

    if (blePrinters.isNotEmpty) {
      printInfo.port = Port.BLE;
      printInfo.setLocalName(blePrinters.single.localName);
      printer.setPrinterInfo(printInfo);
      status = await printer.printImage(picture);
    }

    /*
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
*/

    //bool closed = await printer.endCommunication();

    //print ("Got Status: $status and Error: ${status.errorCode.getName()}");
    print("Got Status: $status and Error: ${status.errorCode.getName()}");
    return status;
    //return PrinterStatus();
  }

  Future sleep() {
    return new Future.delayed(const Duration(seconds: 50), () => "5");
  }

  Future<PrinterStatus> printBle() async {
    /*
    final String ip =  await WifiInfo().getWifiIP();
    final String subnet = ip.substring(0, ip.lastIndexOf('.'));
    final int port = 80;

    final stream = NetworkAnalyzer.discover2(subnet, port);
    stream.listen((NetworkAddress addr) {
      if (addr.exists) {
        print('Found device: ${addr.ip}');
      }
    });

     */

    /*
    var reusePort = false;
    if (Platform.isIOS) {
      reusePort = true;
    }
    const String name = '_ipp._tcp';
    // https://github.com/flutter/flutter/issues/27346#issuecomment-594021847
    var factory = (dynamic host, int port,
        {bool reuseAddress, bool reusePort, int ttl}) {
      return RawDatagramSocket.bind(host, port, reuseAddress: true, reusePort: reusePort, ttl: 255);
    };

    var client = MDnsClient(rawDatagramSocketFactory: factory);
    //final MDnsClient client = MDnsClient();
    await client.start();

    // Get the PTR recod for the service.
    await for (PtrResourceRecord ptr in client
        .lookup<PtrResourceRecord>(ResourceRecordQuery.serverPointer(name))) {
      await for (SrvResourceRecord srv in client.lookup<SrvResourceRecord>(
          ResourceRecordQuery.service(ptr.domainName))) {
        String model =
        ptr.domainName.substring(0, ptr.domainName.indexOf('._printer'));
        print('Dart observatory instance found at '
            '${srv.target}:${srv.port} for "$model".');
        await for (IPAddressResourceRecord ipr in client.lookup(
            ResourceRecordQuery.addressIPv4(srv.target))) {
          debugPrint('Printer found at '
              '${ipr.address} with "$model".');
          model = "(mDNS)"+model;
        }
      }
    }
    client.stop();
    print('Done.');
    */

    /*
    final flutterNsd = FlutterNsd();

    await flutterNsd.discoverServices('_printer._tcp');

    flutterNsd.stream.listen((nsdServiceInfo) {
      print('Discovered service name: ${nsdServiceInfo.name}');
      print('Discovered service hostname/IP: ${nsdServiceInfo.hostname}');
      print('Discovered service port: ${nsdServiceInfo.port}');

    }, onError: (e) async {
      print("Error: ${e.errorCode}");
    });

    await Future.delayed(Duration(seconds: 4), () {flutterNsd.stopDiscovery();});

     */

    /*
    // This is the type of service we're looking for :
    String type = '_printer._tcp';//'_printer._tcp';
// Once defined, we can start the discovery :
    BonsoirDiscovery discovery = BonsoirDiscovery(type: type);
    await discovery.ready;
    await discovery.start();

// If you want to listen to the discovery :
    discovery.eventStream.listen((event) {
      print("Event $event");
      if (event.type == BonsoirDiscoveryEventType.DISCOVERY_SERVICE_FOUND) {
        print('Service found : ${event.service.toJson()}');
      } else if (event.type == BonsoirDiscoveryEventType.DISCOVERY_SERVICE_LOST) {
        print('Service lost : ${event.service.toJson()}');
      }
    });

// Then if you want to stop the discovery :
    await Future.delayed(Duration(seconds: 40), () async {
      await discovery.stop();
    });

    */
    /*
    MDNSPlugin mdns = new MDNSPlugin(Delegate());
    await mdns.startDiscovery("_pdl-datastream._tcp",enableUpdating: true);
    await sleep();
    await mdns.stopDiscovery();
    await sleep();
    */
    var printer = new Printer();
    var printInfo = PrinterInfo();
    //printInfo.printerModel = Model.RJ_4250WB;
    printInfo.printerModel = Model.RJ_4250WB;
    printInfo.printMode = PrintMode.FIT_TO_PAGE;
    printInfo.isAutoCut = true;
    printInfo.rotate180 = false;
    printInfo.numberOfCopies = 2;
    printInfo.port = Port.BLE;
    //printInfo.setLocalName("RJ-4250WB_5113");
    //printInfo.port = Port.BLUETOOTH;
    //printInfo.macAddress = "795B8714-AC40-6FFE-C8D0-4FFF6D67D056";
    //printInfo.setLocalName("RJ-4250WB_5113");

    // Set the label type.
    double width = 102.0;
    double rightMargin = 0.0;
    double leftMargin = 0.0;
    double topMargin = 0.0;
    CustomPaperInfo customPaperInfo = CustomPaperInfo.newCustomRollPaper(
        printInfo.printerModel,
        Unit.Mm,
        width,
        rightMargin,
        leftMargin,
        topMargin);
    printInfo.customPaperInfo = customPaperInfo;

    // Set the printer info so we can use the SDK to get the printers.
    await printer.setPrinterInfo(printInfo);

    // Get a list of printers with my model available in the network.
    List<BLEPrinter> printers = await printer.getBLEPrinters(3000);
    // Get the BT name from the first printer found.
    printInfo.setLocalName(printers.single.localName);

    //List<NetPrinter> netPrinters = await printer.getNetPrinters([Model.QL_1110NWB.getName()]);
    //print ("Net Printers Found: $netPrinters");

    //List<BluetoothPrinter> netPrinters = await printer.getBluetoothPrinters([Model.RJ_4250WB.getName()]);
    //print ("Bt Printers Found: $netPrinters");
    //printInfo.macAddress = netPrinters.single.macAddress;

    printer.setPrinterInfo(printInfo);

    PictureRecorder recorder = PictureRecorder();
    Canvas c = Canvas(recorder);
    Paint paint = new Paint();
    paint.color = Color.fromRGBO(255, 0, 0, 1);
    Rect bounds = new Rect.fromLTWH(0, 0, 300, 100);
    c.drawRect(bounds, paint);
    var picture = await recorder.endRecording().toImage(300, 100);
    PrinterStatus status = await printer.printImage(picture);

    //FilePickerResult result = await FilePicker.platform.pickFiles();

    /*
      FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: true,
          type: FileType.custom,
          allowedExtensions: ['jpg', 'pdf', 'png']);


      PrinterStatus status = PrinterStatus();
      if(result != null) {
        setState(() {
          _selectedImage = File(result.files.first.path);
        });
        //status = await printer.printFile(result.files.single.path);
        status = await printer.getPrinterStatus();
        print ("Got Status $status");
        // Get Information about currently loaded paper
        //LabelInfo labelInfo = await printer.getLabelInfo();
        //print ("Label Info: $labelInfo");
        //LabelParam labelParam = await printer.getLabelParam();
        //print ("Label Param $labelParam");

        //status = await printer.printFileList(result.paths);
        //status = await printer.printPdfFile(result.paths.first, 2);

      } else {
        // User canceled the picker
      }

       */
     return status;
  }

  Future<PrinterStatus> printImageBluetooth() async {
    var printer = new Printer();
    var printInfo = PrinterInfo();
    printInfo.printerModel = Model.QL_1110NWB;
    printInfo.printMode = PrintMode.FIT_TO_PAGE;
    printInfo.isAutoCut = true;
    printInfo.port = Port.NET;
    printInfo.numberOfCopies = 2;
    //printInfo.macAddress = "58:93:D8:BD:69:95"; // Printer BLuetooth Mac
    //printInfo.port = Port.NET;
    //printInfo.ipAddress = "192.168.1.80"; // Printer Bluetooth Mac

    // Ask the printer what label it has on.
    //printInfo.labelNameIndex = (await printer.getLabelInfo()).labelNameIndex; //QL1100.ordinalFromID(QL1100.W103.getId());
    printInfo.labelNameIndex = QL1100.ordinalFromID(QL1100.W62.getId());

    /*
    List<BluetoothPrinter> netPrinters =
        await printer.getBluetoothPrinters([Model.QL_1110NWB.getName()]);
    print("Bt Printers Found: $netPrinters");
    printInfo.macAddress = netPrinters.single.macAddress;
*/
    List<NetPrinter> netPrinters =
    await printer.getNetPrinters([Model.QL_1110NWB.getName()]);
    print("Net Printers Found: $netPrinters");
    printInfo.ipAddress = netPrinters.single.ipAddress;

    /*
    var printer = new Printer();
    var printInfo = PrinterInfo();
    printInfo.printerModel = Model.PJ_773;
    printInfo.printMode = PrintMode.FIT_TO_PAGE;
    printInfo.isAutoCut = true;
    printInfo.port = Port.NET;
    // Set the label type.
    printInfo.paperSize = PaperSize.A4;

    // Set the printer info so we can use the SDK to get the printers.
    await printer.setPrinterInfo(printInfo);

    // Get a list of printers with my model available in the network.
    List<NetPrinter> printers = await printer.getNetPrinters([Model.PJ_773.getName()]);
    // Get the IP Address from the first printer found.
    printInfo.ipAddress = printers.single.ipAddress;
*/
    printer.setPrinterInfo(printInfo);

    await printer.setPrinterInfo(printInfo);

    /*
    PictureRecorder recorder = PictureRecorder();
    Canvas c = Canvas(recorder);
    Paint paint = new Paint();
    paint.color = Color.fromRGBO(255, 0, 0, 1);
    Rect bounds = new Rect.fromLTWH(0, 0, 300, 100);
    c.drawRect(bounds, paint);
    var picture = await recorder.endRecording().toImage(300, 100);
    PrinterStatus status = await printer.printImage(picture);
*/

    TextStyle style = TextStyle(
        color: Colors.black,
        fontSize: 30,
        fontWeight: FontWeight.bold
    );

    ui.ParagraphBuilder paragraphBuilder = ui.ParagraphBuilder(
        ui.ParagraphStyle(
          fontSize:   style.fontSize,
          fontFamily: style.fontFamily,
          fontStyle:  style.fontStyle,
          fontWeight: style.fontWeight,
          textAlign: TextAlign.center,
          maxLines: 10,
        )
    )
      ..pushStyle(style.getTextStyle())
      ..addText("Hello World This is a long text ");

    ui.Paragraph paragraph = paragraphBuilder.build()..layout(ui.ParagraphConstraints(width: 300));

    PrinterStatus status = await printer.printText(paragraph);

    //FilePickerResult result = await FilePicker.platform.pickFiles();

    //FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: true,
    //    type: FileType.custom,
    //    allowedExtensions: ['jpg', 'pdf', 'png']);

    /*
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
    */

    print("Got Status: $status and Error: ${status.errorCode.getName()}");
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
            _selectedImage != null
                ? Image.file(_selectedImage!)
                : Text("No Image Selected"),
            _imageBytes != null
                ? Image.memory(_imageBytes!)
                : Text("No Image From Canvas"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        printImageUsb();
                      },
                      child: Text("Print USB")),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: () {
                        //printBle();
                        //printImageBluetooth();
                        printLabelTypeB();
                      },
                      child: Text("Print Bluetooth")),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
/*
class Delegate implements MDNSPluginDelegate {
  void onDiscoveryStarted() {
    print("Discovery started");
  }
  void onDiscoveryStopped() {
    print("Discovery stopped");
  }
  bool onServiceFound(MDNSService service) {
    print("Found: $service");
    // Always returns true which begins service resolution
    return true;
  }
  void onServiceResolved(MDNSService service) {
    print("Resolved: $service");
  }
  void onServiceUpdated(MDNSService service) {
    print("Updated: $service");
  }
  void onServiceRemoved(MDNSService service) {
    print("Removed: $service");
  }
}

 */

class TbPrinterSetup extends StatefulWidget {
  @override
  _TbPrinterSetupState createState() => _TbPrinterSetupState();
}

class _TbPrinterSetupState extends State<TbPrinterSetup> {

  final _ssidEditController = TextEditingController();
  final _ssidWPAKeyController = TextEditingController();

  TbPrinterInfo printerInfo = TbPrinterInfo(port: Port.USB);
  TbPrinter printer = TbPrinter();
/*
    TbPrinterInfo printerInfo = TbPrinterInfo(
        port: Port.BLUETOOTH,
        btAddress: "00:80:A3:8B:51:FD");
*/

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose(){
    // TODO: implement dispose
    super.dispose();

    _ssidEditController.dispose();
    _ssidWPAKeyController.dispose();

  }

  Future<bool> configureSSid(String ssid, String passkey) async {


    await printer.setPrinterInfo(printerInfo);
    bool success = await printer.startCommunication();
      print("Connected to printer? $success");

    success = await printer.clearBuffer();

    success = await printer.sendTbCommand(TbCommandSetWlanSsid(ssid));
    print("TypeB: WLAN Set Command Success? $success");

    success =  success && await printer
        .sendTbCommand(TbCommandSetWlanWpa(passKey: passkey));
    print("TypeB: WPA Set Command Success? $success");

    success = await printer.sendTbCommand(TbCommandSetWlanDhcp());
    print("TypeB: DHCP Set Command Success? $success");

    success = await printer.barcode(ssid);
    await printer.printLabel();
    success = await printer.endCommunication();

    return success;
  }

  Future<bool> printBtInfo () async {

    await printer.setPrinterInfo(printerInfo);
    bool success = await printer.startCommunication();
    print("Connected to printer? $success");

    success = await printer.clearBuffer();

    success = await printer.sendTbCommand(TbCommandSelfTest(page: TbSelfTestPage.BT));
    print("TypeB: BT Test Set Command Success? $success");

    success = await printer.endCommunication();

    return success;

  }

  Future<bool> printAllSettings() async {
    await printer.setPrinterInfo(printerInfo);
    bool success = await printer.startCommunication();
    print("Connected to printer? $success");

    success = await printer.clearBuffer();

    success = await printer.sendTbCommand(TbCommandSelfTest());
    print("TypeB: All Test Set Command Success? $success");

    success = await printer.endCommunication();

    return success;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Type B WiFi Configuration'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _ssidEditController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter Network SSID',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _ssidWPAKeyController,
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter Network PASSKEY',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      child: Text("Print BT Settings"),
                      onPressed: () {
                    // Print BT Info
                        printBtInfo();
                  }),
                  ElevatedButton(onPressed: () {
                    printAllSettings();
                    //printer.sendTbCommand(TbCommandSelfTest());
                  }, child: Text("Print All Settings"))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:28.0),
              child: ElevatedButton(onPressed: (){
                configureSSid(_ssidEditController.value.text, _ssidWPAKeyController.value.text);
              }, child: Text("Configure WiFI")),
            )
          ],
        ),
      ),
    );
  }
}
