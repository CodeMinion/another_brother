package com.rouninlabs.another_brother.method

import android.bluetooth.BluetoothAdapter
import android.content.Context
import com.brother.ptouch.sdk.BLEPrinter
import com.brother.ptouch.sdk.Printer
import com.brother.ptouch.sdk.PrinterInfo
import com.brother.ptouch.sdk.PrinterStatus
import com.rouninlabs.another_brother.BrotherManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*

/**
 * Command for discovering the BLE Brother printers that are available.
 * This support both one-time as well as the standard openCommunication/print/closeCommunication
 * approach.
 */
class GetBlePrintersMethodCall(val flutterAssets: FlutterPlugin.FlutterAssets, val context: Context, val call: MethodCall, val result: MethodChannel.Result) {
    companion object {
        const val METHOD_NAME = "getBLEPrinters"
    }

    fun execute() {

        GlobalScope.launch(Dispatchers.IO) {

            val dartPrintInfo: HashMap<String, Any> = call.argument<HashMap<String, Any>>("printInfo")!!
            val printerId: String = call.argument<String>("printerId")!!
            val timeout:Long = call.argument<Long>("timeout")!!

            // Decoded Printer Info
            val printInfo = printerInfofromMap(context = context, flutterAssets = flutterAssets, map = dartPrintInfo)

            // A print request is considered one-time if there was no printer tracked with this ID.
            // this will open a new connection and close it when done.
            // If it is not one-time it means someone must have already opened a connection using
            // the startCommunication() API. When endCommunication() is called that printer will be removed.
            // Create Printer
            val trackedPrinter = BrotherManager.getPrinter(printerId = printerId)
            val isOneTime:Boolean = trackedPrinter == null;
            val printer = trackedPrinter?: Printer()

            // Prepare local connection.
            val error = setupConnectionManagers(context = context, printer = printer, printInfo = printInfo)
            if (error != PrinterInfo.ErrorCode.ERROR_NONE) {
                // There was an error notify
                withContext(Dispatchers.Main) {
                    result.success(arrayListOf<Map<String, Any>>())
                }
                return@launch
            }

            // Set Printer Info
            printer.printerInfo = printInfo

            val blePrinters = printer.getBLEPrinters(BluetoothAdapter.getDefaultAdapter(), timeout);

            // Encode Printers
            val dartPrinters = blePrinters.map { it-> it.toMap() }.toList()
           withContext(Dispatchers.Main) {
               // Set result Printer status.
               result.success(dartPrinters)
           }
        }

    }
}