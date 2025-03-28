package com.rouninlabs.another_brother.method

import android.bluetooth.BluetoothAdapter
import android.bluetooth.BluetoothDevice
import android.content.Context
import android.content.pm.PackageManager
import android.hardware.usb.UsbManager
import android.util.Log
import androidx.core.content.ContextCompat
import com.brother.ptouch.sdk.*
import com.brother.ptouch.sdk.Unit
import com.rouninlabs.another_brother.BrotherManager
import com.rouninlabs.another_brother.method.typeb.TbPrinterInfo
import io.flutter.embedding.engine.plugins.FlutterPlugin
import java.io.File

const val TAG = "A-Brother"

fun printerInfofromMap(context:Context, flutterAssets: FlutterPlugin.FlutterAssets, map: HashMap<String, Any>): PrinterInfo {
    val model: PrinterInfo.Model = modelFromMap(map["printerModel"] as Map<String, Any>)
    val timeout: TimeoutSetting = TimeoutSettingFromMap(map["timeout"] as Map<String, Any>)
    val customPaperInfo = customPaperInfoFromMap(map["customPaperInfo"] as Map<String, Any>?)
    val binFilePath = binFilePathFromMap(context = context, flutterAssets = flutterAssets, map = map["binCustomPaper"] as Map<String, Any>?)

    val info: PrinterInfo = PrinterInfo().apply {
        printerModel = model
        port = portFromMap(map["port"] as Map<String, Any>)
        ipAddress = map["ipAddress"] as String
        macAddress = map["macAddress"] as String
        localName = map["localName"] as String
        lastConnectedAddress = map["lastConnectedAddress"] as String
        paperSize = paperSizeFromMap(map["paperSize"] as Map<String, Any>)
        orientation = orientationFromMap(map["orientation"] as Map<String, Any>)
        numberOfCopies = map["numberOfCopies"] as Int
        halftone = halftoneFromMap(map["halftone"] as Map<String, Any>)
        printMode = printModeFromMap(map["printMode"] as Map<String, Any>)
        align = alignFromMap(map["align"] as Map<String, Any>)
        valign = vAlignFromMap(map["valign"] as Map<String, Any>)
        margin = marginFromMap(map["margin"] as Map<String, Any>)
        pjCarbon = map["pjCarbon"] as Boolean
        pjDensity = map["pjDensity"] as Int
        pjFeedMode = pjFeedModeFromMap(map["pjFeedMode"] as Map<String, Any>)
        customPaperWidth = map["customPaperWidth"] as Int
        customPaperLength = map["customPaperLength"] as Int
        customFeed = map["customFeed"] as Int
        rjDensity = map["rjDensity"] as Int
        rotate180 = map["rotate180"] as Boolean
        peelMode = map["peelMode"] as Boolean
        mirrorPrint = map["mirrorPrint"] as Boolean
        paperPosition = alignFromMap(map["paperPosition"] as Map<String, Any>)
        isAutoCut = map["isAutoCut"] as Boolean
        isCutAtEnd = map["isCutAtEnd"] as Boolean
        mode9 = map["mode9"] as Boolean
        skipStatusCheck = map["skipStatusCheck"] as Boolean
        checkPrintEnd = checkPrintEndFromMap(map["checkPrintEnd"] as Map<String, Any>)
        rollPrinterCase = pjRollCaseFromMap(map["rollPrinterCase"] as Map<String, Any>)
        pjSpeed = map["pjSpeed"] as Int
        thresholdingValue = map["thresholdingValue"] as Int
        //this.timeout = new TimeoutSetting(),
        dashLine = map["dashLine"] as Boolean
        savePrnPath = map["savePrnPath"] as String
        overwrite = map["overwrite"] as Boolean
        isHalfCut = map["isHalfCut"] as Boolean
        isSpecialTape = map["isSpecialTape"] as Boolean
        labelNameIndex = map["labelNameIndex"] as Int
        customPaper = binFilePath//map["customPaper"] as String
        //this.customPaperInfo = null,
        isLabelEndCut = map["isLabelEndCut"] as Boolean
        printQuality = printQualityFromMap(map["printQuality"] as Map<String, Any>)
        labelMargin = map["labelMargin"] as Int
        scaleValue = map["scaleValue"] as Double
        isCutMark = map["isCutMark"] as Boolean
        softFocusing = map["softFocusing"] as Boolean
        trimTapeAfterData = map["trimTapeAfterData"] as Boolean
        enabledTethering = map["enabledTethering"] as Boolean
        rawMode = map["rawMode"] as Boolean
        workPath = map["workPath"] as String
        pjPaperKind = pjPaperKindFromMap(map["pjPaperKind"] as Map<String, Any>)
        useLegacyHalftoneEngine = map["useLegacyHalftoneEngine"] as Boolean
        banishMargin = map["banishMargin"] as Boolean
        useCopyCommandInTemplatePrint = map["useCopyCommandInTemplatePrint"] as Boolean
        this.timeout = timeout
        setCustomPaperInfo(customPaperInfo)
    }
    return info;
}

fun customPaperInfoFromMap(map:Map<String, Any>?):CustomPaperInfo? {
    return map?.let {
        val paperKind:PaperKind = paperKindFromMap(map["paperKind"] as Map<String, Any>)
        val unit:Unit = unitFromMap(map["unit"] as Map<String, Any>)
        val printerModel:PrinterInfo.Model = modelFromMap(map["printerModel"] as Map<String, Any>)
        val tapeWidth = (map["tapeWidth"] as Double).toFloat()
        val tapeLength = (map["tapeLength"] as Double).toFloat()
        val rightMargin = (map["rightMargin"] as Double).toFloat()
        val leftMargin = (map["leftMargin"] as Double).toFloat()
        val topMargin = (map["topMargin"] as Double).toFloat()
        val bottomMargin = (map["bottomMargin"] as Double).toFloat()
        val labelPitch = (map["labelPitch"] as Double).toFloat()
        val markPosition = (map["markPosition"] as Double).toFloat()
        val markHeight = (map["markHeight"] as Double).toFloat()

        val customPaperInfo:CustomPaperInfo = when(paperKind) {
            PaperKind.DIE_CUT -> {
                CustomPaperInfo.newCustomDieCutPaper(printerModel,
                        unit, tapeWidth, tapeLength, rightMargin, leftMargin, topMargin, bottomMargin, labelPitch)
                //CustomPaperInfo.newCustomDiaCutPaper(printerModel,
                //        unit, tapeWidth, tapeLength, rightMargin, leftMargin, topMargin, bottomMargin, labelPitch)
            }
            PaperKind.MARKED_ROLL -> {
                CustomPaperInfo.newCustomMarkRollPaper(printerModel,
                        unit, tapeWidth, tapeLength, rightMargin, leftMargin, topMargin, bottomMargin, markPosition, markHeight)
            }
            PaperKind.ROLL -> {
                CustomPaperInfo.newCustomRollPaper(printerModel,
                        unit, tapeWidth, tapeLength, rightMargin, leftMargin)

            }
        }

        customPaperInfo
    }
}

fun unitFromMap(map:Map<String, Any>):com.brother.ptouch.sdk.Unit {
    val name = map["name"] as String
    return when(name){
        "Inch" -> com.brother.ptouch.sdk.Unit.Inch
        else ->
            com.brother.ptouch.sdk.Unit.Mm
    }
}
fun paperKindFromMap(map:Map<String, Any>):PaperKind {
    val name = map["name"] as String
    return PaperKind.valueOf(name)
}
fun modelFromMap(map: Map<String, Any>): PrinterInfo.Model {
    val id: Int = map["id"] as Int
    return PrinterInfo.Model.valueFromID(id)
}

fun TimeoutSettingFromMap(map: Map<String, Any>): TimeoutSetting {
    return TimeoutSetting().apply {
        processTimeoutSec = map["processTimeoutSec"] as Int
        sendTimeoutSec = map["sendTimeoutSec"] as Int
        receiveTimeoutSec = map["receiveTimeoutSec"] as Int
        closeWaitMSec = map["closeWaitMSec"] as Int
        connectionWaitMSec = map["connectionWaitMSec"] as Int
        closeWaitDisusingStatusCheckSec = map["closeWaitDisusingStatusCheckSec"] as Int
    }
}

// TODO Send name instead of ID. But check first if Mac has the same names.
fun portFromMap(map: Map<String, Any>): PrinterInfo.Port {
    val id: Int = map["id"] as Int
    val name: String = map["name"] as String
    return PrinterInfo.Port.values().find { it.name == name }!!
}

fun paperSizeFromMap(map: Map<String, Any>): PrinterInfo.PaperSize {
    val id: Int = map["id"] as Int
    val name: String = map["name"] as String
    return PrinterInfo.PaperSize.values().find { it.name == name }!!
}

fun orientationFromMap(map: Map<String, Any>): PrinterInfo.Orientation {
    val id: Int = map["id"] as Int
    val name: String = map["name"] as String
    return PrinterInfo.Orientation.values().find { it.name == name }!!
}

fun halftoneFromMap(map: Map<String, Any>): PrinterInfo.Halftone {
    val id: Int = map["id"] as Int
    val name: String = map["name"] as String
    return PrinterInfo.Halftone.values().find { it.name == name }!!
}

fun printModeFromMap(map: Map<String, Any>): PrinterInfo.PrintMode {
    val id: Int = map["id"] as Int
    val name: String = map["name"] as String
    return PrinterInfo.PrintMode.values().find { it.name == name }!!
}

fun alignFromMap(map: Map<String, Any>): PrinterInfo.Align {
    val id: Int = map["id"] as Int
    val name: String = map["name"] as String
    return PrinterInfo.Align.values().find { it.name == name }!!
}

fun vAlignFromMap(map: Map<String, Any>): PrinterInfo.VAlign {
    val id: Int = map["id"] as Int
    val name: String = map["name"] as String
    return PrinterInfo.VAlign.values().find { it.name == name }!!
}

fun pjFeedModeFromMap(map: Map<String, Any>): PrinterInfo.PjFeedMode {
    val id: Int = map["id"] as Int
    val name: String = map["name"] as String
    return PrinterInfo.PjFeedMode.values().find { it.name == name }!!
}

fun checkPrintEndFromMap(map: Map<String, Any>): PrinterInfo.CheckPrintEnd {
    val id: Int = map["id"] as Int
    val name: String = map["name"] as String
    return PrinterInfo.CheckPrintEnd.values().find { it.name == name }!!
}

fun pjRollCaseFromMap(map: Map<String, Any>): PrinterInfo.PjRollCase {
    val id: Int = map["id"] as Int
    val name: String = map["name"] as String
    return PrinterInfo.PjRollCase.values().find { it.name == name }!!
}

fun printQualityFromMap(map: Map<String, Any>): PrinterInfo.PrintQuality {
    val id: Int = map["id"] as Int
    val name: String = map["name"] as String
    return PrinterInfo.PrintQuality.values().find { it.name == name }!!
}

fun pjPaperKindFromMap(map: Map<String, Any>): PrinterInfo.PjPaperKind {
    val id: Int = map["id"] as Int
    val name: String = map["name"] as String
    return PrinterInfo.PjPaperKind.values().find { it.name == name }!!
}

fun marginFromMap(map: Map<String, Any>): PrinterInfo.Margin {
    val top: Int = map["top"] as Int
    val left: Int = map["left"] as Int
    return PrinterInfo.Margin(left, top)
}

fun printerSettingItemFromMap(map:Map<String, Any>):PrinterInfo.PrinterSettingItem {
    val id:Int = map["id"] as Int
    val name:String = map["name"] as String
    return PrinterInfo.PrinterSettingItem.valueFromID(id)
}

fun bluetoothPreferenceFromMap(map:Map<String, Any>):BluetoothPreference {
    return BluetoothPreference().apply {
        enableSsp = sspFromMap(map["enableSsp"] as Map<String, Any>)
        powerMode to powerSaveModeFromMap(map["powerMode"] as Map<String, Any>)
        // Note: Auth Mode is Protected in the SDK
        //authMode to AuthMode.fromMap(map["authMode"])
    }
}

fun binFilePathFromMap(context:Context, flutterAssets: FlutterPlugin.FlutterAssets, map:Map<String, Any>?):String {
    if (map == null) {
        return ""
    }
    val name: String = map["name"] as String
    val assetPath:String = map["assetPath"] as String
    val androidAssetPath = flutterAssets.getAssetFilePathByName(assetPath)
    val assetManager = context.assets
    // Copy the file so we can get the path
    val cachePrintFile = File(context.cacheDir, "printBinTemp.bin");
    //cachePrintFile.mkdirs()
    assetManager.open(androidAssetPath).use {binInputStream->
        cachePrintFile.outputStream().use { cache->
            binInputStream.copyTo(cache)
        }
    }
    val binFilePath = cachePrintFile.absolutePath
    return binFilePath
}

fun sspFromMap(map:Map<String, Any>):BluetoothPreference.SSP {
    return BluetoothPreference.SSP.getSsp(map["command"] as Int)
}

fun powerSaveModeFromMap(map:Map<String, Any>):BluetoothPreference.PowerSaveMode {
    return BluetoothPreference.PowerSaveMode.getPowerSaveMode(map["command"] as Int)
}


fun PrinterInfo.ErrorCode.toMap(context:Context? = null): Map<String, Any> {
    /*
    if (context != null && name == PrinterInfo.ErrorCode.ERROR_WRONG_LABEL.name && ContextCompat.checkSelfPermission(context, "android.permission.WRITE_EXTERNAL_STORAGE") != PackageManager.PERMISSION_GRANTED){
        // When the App does not have storage permissions the Brother libs fail with this error ERROR_WRONG_LABEL
        // We convert it to a more meaningful one.
        return hashMapOf(
            "id" to 9999,
            "name" to "ERROR_STORAGE_PERMISSION_NOT_GRANTED"
        )
    }
     */
    return hashMapOf(
            "id" to -1,
            "name" to name
    )
}

fun NetPrinter.toMap(): Map<String, Any> {
    return hashMapOf(
            "modelName" to modelName,
            "serNo" to serNo,
            "ipAddress" to ipAddress,
            "macAddress" to macAddress,
            "nodeName" to nodeName,
            "location" to location
    )
}

fun BLEPrinter.toMap(): Map<String, Any> {
    return hashMapOf(
            "localName" to localName
    )
}

fun JNIStatus.BatteryTernary.toMap(): Map<String, Any> {
    return hashMapOf(
            "id" to -1,
            "name" to name
    )
}

fun PrinterStatus.toMap(context:Context? = null): Map<String, Any> {
    return hashMapOf(
            "errorCode" to errorCode.toMap(context),
            "labelId" to labelId,
            "labelType" to labelType,
            "isACConnected" to isACConnected.toMap(),
            "isBatteryMounted" to isBatteryMounted.toMap(),
            "batteryLevel" to batteryLevel,
            "batteryResidualQuantityLevel" to batteryResidualQuantityLevel,
            "maxOfBatteryResidualQuantityLevel" to maxOfBatteryResidualQuantityLevel
    )
}

fun LabelParam.toMap(): Map<String, Any> {
    return hashMapOf(
            "labelWidth" to labelWidth,
            "labelLength" to labelLength,
            "paperWidth" to paperWidth,
            "paperLength" to paperLength,
            "imageAreaWidth" to imageAreaWidth,
            "imageAreaLength" to imageAreaLength,
            "pinOffsetLeft" to pinOffsetLeft,
            "pinOffsetRight" to pinOffsetRight,
            "physicalOffsetX" to physicalOffsetX,
            "physicalOffsetY" to physicalOffsetY,
            "labelType" to labelType,
            "paperID" to paperID
    )
}

fun LabelInfo.toMap(): Map<String, Any> {
    return hashMapOf(
            "labelNameIndex" to labelNameIndex,
            "isAutoCut" to isAutoCut,
            "isEndCut" to isEndCut,
            "isHalfCut" to isHalfCut,
            "isSpecialTape" to isSpecialTape,
            "isCutMark" to isCutMark,
            "labelColor" to labelColor.toMap(),
            "labelFontColor" to labelFontColor.toMap(),
            "labelType" to labelType
    )
}

fun LabelInfo.LabelColor.toMap(): Map<String, Any> {
    return hashMapOf(
            "id" to -1,
            "name" to name
    )
}

fun TemplateInfo.toMap(): Map<String, Any> {
    return hashMapOf(
            "key" to key,
            "fileSize" to fileSize,
            "checksum" to checksum,
            "modifiedDate" to modifiedDate,
            "fileName" to fileName,
            "modifiedDateRaw" to modifiedDateRaw
    )
}

fun BatteryInfo.toMap(): Map<String, Any> {
    return hashMapOf(
            "chargeLevel" to batteryChargeLevel,
            "healthLevel" to batteryHealthLevel,
            "healthStatus" to batteryHealthStatus.toMap()
    )
}

fun BatteryInfo.HealthStatus.toMap(): Map<String, Any> {
    return hashMapOf(
            "id" to -1,
            "name" to name
    )
}

fun PrinterInfo.PrinterSettingItem.toMap():Map<String, Any> {
    return hashMapOf(
            "id" to -1,
            "name" to name
    )
}

fun BluetoothPreference.toMap():Map<String, Any> {
    return hashMapOf<String, Any>(
            "enableSsp" to enableSsp.toMap(),
    "powerMode" to powerMode.toMap(),
    "authMode" to 255 //authMode.toMap()
    )
}

fun BluetoothPreference.SSP.toMap():Map<String, Any> {
    return hashMapOf(
            "command" to this.command
    )
}

fun BluetoothPreference.PowerSaveMode.toMap():Map<String, Any> {
    return hashMapOf(
            "command" to this.command
    )
}



fun setupConnectionManagers(context: Context, printInfo: PrinterInfo, printer: Printer): PrinterInfo.ErrorCode {

    if (printInfo.workPath.isEmpty()) {
        printInfo.workPath = context.filesDir.absolutePath + "/";
    }

    if (printInfo.port == PrinterInfo.Port.BLUETOOTH) {
        printer.setBluetooth(BluetoothAdapter.getDefaultAdapter())

    } else if (printInfo.port == PrinterInfo.Port.BLE) {
        printer.setBluetoothLowEnergy(context, BluetoothAdapter.getDefaultAdapter(), 3000)

    } else if (printInfo.port == PrinterInfo.Port.USB) {
        val usbManager = context.getSystemService(Context.USB_SERVICE) as UsbManager
        val usbDevice = printer.getUsbDevice(usbManager)
        val currSpecs = printer.printerSpec

        if (usbDevice == null) {
            Log.e(TAG, "USB not Connected")
            return PrinterInfo.ErrorCode.ERROR_BROTHER_PRINTER_NOT_FOUND
        }
        // Check if the user has the permission to print to the device.
        val hasPermission = usbManager.hasPermission(usbDevice)
        if (!hasPermission) {
            // Block until granted/denied
            val granted = BrotherManager.requestUsbPermission(context = context, usbManager = usbManager, usbDevice = usbDevice)//.take()
            
        }
    }

    return PrinterInfo.ErrorCode.ERROR_NONE
}

fun BluetoothDevice.toBluetoothPrinter():Map<String, Any> {
    return hashMapOf(
            "modelName" to name,
            "macAddress" to address
    )
}

////////////////////// TYPE B Section //////////////////////////



