package com.rouninlabs.another_brother.method

import android.content.Context
import com.brother.ptouch.sdk.Printer
import com.brother.ptouch.sdk.PrinterInfo
import com.brother.ptouch.sdk.PrinterStatus
import com.rouninlabs.another_brother.BrotherManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*

/**
 * Command for starting a communication to a printer.
 * It will track the printer so it is available to print commands as well as close communication commands.
 */
class StartCommunicationMethodCall(val flutterAssets: FlutterPlugin.FlutterAssets, val context: Context, val call: MethodCall, val result: MethodChannel.Result) {
    companion object {
        const val METHOD_NAME = "startCommunication"
    }

    fun execute() {

        GlobalScope.launch(Dispatchers.IO) {

            val dartPrintInfo: HashMap<String, Any> = call.argument<HashMap<String, Any>>("printInfo")!!
            val printerId: String = call.argument<String>("printerId")!!

            // Decoded Printer Info
            val printInfo = printerInfofromMap(context = context, flutterAssets = flutterAssets, map = dartPrintInfo)

            // Check if the ID is already tracked, if so we return.
            val trackedPrinter = BrotherManager.getPrinter(printerId = printerId)
            if (trackedPrinter != null) {
                withContext(Dispatchers.Main) {
                    result.success(true)
                }
                return@launch
            }

            val printer = Printer()

            // Prepare local connection.
            val error = setupConnectionManagers(context = context, printer = printer, printInfo = printInfo)
            if (error != PrinterInfo.ErrorCode.ERROR_NONE) {
                // There was an error notify
                withContext(Dispatchers.Main) {
                    // Set result Printer status.
                    result.success(false)
                }
                return@launch
            }

            // Set Printer Info
            printer.printerInfo = printInfo


            val success = printer.startCommunication()

            if (success) {
                BrotherManager.trackPrinter(printerId = printerId, printer = printer)
            }

           withContext(Dispatchers.Main) {
               // Set result Printer status.
               result.success(success)
               //result.error("Error", "Method not implemented", "")
           }
        }

    }
}