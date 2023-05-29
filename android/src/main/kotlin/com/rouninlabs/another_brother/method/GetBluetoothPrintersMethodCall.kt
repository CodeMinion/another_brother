package com.rouninlabs.another_brother.method

import android.bluetooth.BluetoothAdapter
import android.content.Context
import android.util.Log
import com.brother.ptouch.sdk.Printer
import com.brother.ptouch.sdk.PrinterInfo
import com.brother.ptouch.sdk.PrinterStatus
import com.rouninlabs.another_brother.BrotherManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*

/**
 * Command for getting the Brother that are paired to the device..
 */
class GetBluetoothPrintersMethodCall(val flutterAssets: FlutterPlugin.FlutterAssets, val context: Context, val call: MethodCall, val result: MethodChannel.Result) {
    companion object {
        const val METHOD_NAME = "getBluetoothPrinters"
    }

    fun execute() {

        GlobalScope.launch(Dispatchers.IO) {

            val dartPrintInfo: HashMap<String, Any> = call.argument<HashMap<String, Any>>("printInfo")!!
            val printerId: String = call.argument<String>("printerId")!!
            val models:List<String> = call.argument<List<String>>("models")!!

            // Decoded Printer Info
            val printInfo = printerInfofromMap(context = context, flutterAssets = flutterAssets, map = dartPrintInfo)

            /*
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

            val netPrinters = printer.getNetPrinters(models.toTypedArray());

            Log.e(TAG, "Printers: $netPrinters")
            // Encode Printers
            val dartPrinters:List<Map<String, Any>> = netPrinters.map {
                Log.e(TAG, "Printer Name: ${it.modelName}" )
                it.toMap() }
            Log.e(TAG, " Out Printers: $dartPrinters")
            */

            // TODO Only select the devices containing the model in them.
            // Brother names their printers with the model followed by what seems to be 4 digits.
            val matchingPrinters = BluetoothAdapter.getDefaultAdapter().bondedDevices.filter {
                bluetoothDevice -> models.filter { modelName ->
                bluetoothDevice.name.contains(modelName) || bluetoothDevice.name.replace("-", "_").contains(modelName)
                }.isNotEmpty()
            }

            //Log.e("Frank", "Found Printers ${BluetoothAdapter.getDefaultAdapter().bondedDevices}")
            //Log.e("Frank" , "Filtered Printers $matchingPrinters")

            val dartPrinters = matchingPrinters.map { it.toBluetoothPrinter() }
            withContext(Dispatchers.Main) {
               // Set result Printer status.
               result.success(dartPrinters)
           }
        }

    }
}