package com.rouninlabs.another_brother.method

import android.content.Context
import android.graphics.BitmapFactory
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
 * Command for printing an image to a Brother printer.
 * This support both one-time as well as the standard openCommunication/print/closeCommunication
 * approach.
 */
class PrintImageMethodCall(val flutterAssets: FlutterPlugin.FlutterAssets, val context: Context, val call: MethodCall, val result: MethodChannel.Result) {
    companion object {
        const val METHOD_NAME = "printImage"
    }

    fun execute() {

        GlobalScope.launch(Dispatchers.IO) {

            // TODO Run on background thread.
            val dartPrintInfo: HashMap<String, Any> = call.argument<HashMap<String, Any>>("printInfo")!!
            val imageBytes: ByteArray = call.argument<ByteArray>("imageBytes")!!
            val printerId: String = call.argument<String>("printerId")!!

            Log.e("Brother", "Image Bytes: $imageBytes - Size ${imageBytes.size}")
            // Bytes to bitmap
            val bitmap = BitmapFactory.decodeByteArray(imageBytes, 0, imageBytes.size)
            // Decoded Printer Info
            val printInfo = printerInfofromMap(context = context, flutterAssets = flutterAssets, map = dartPrintInfo)
            Log.e("Brother", "PrintInfo: $dartPrintInfo")
            Log.e("Brother", "Parsed Info: ${printInfo}")

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
                    // Set result Printer status.
                    result.success(PrinterStatus().apply {
                        errorCode = error
                    }.toMap())
                }
                return@launch
            }

            // Set Printer Info
            printer.printerInfo = printInfo
            val specs = printer.printerSpec

            // Start communication
            if (isOneTime) {
                // Note: Starting a communication does not seem to impact whether we can print or
                // not. Calling print without calling this seems to still print fine.
                val started: Boolean = printer.startCommunication()
            }

            // Print Image
            val printResult = try {
                printer.printImage(bitmap)
            }
            catch (e:Exception ) {
                Log.e("another-brother", "Print image error: ", e);
                PrinterStatus().apply {
                    errorCode = PrinterInfo.ErrorCode.ERROR_SYSTEM_ERROR
                }
            }

            // End Communication
            if (isOneTime) {
                val connectionClosed: Boolean = printer.endCommunication()
            }
            // Recycle bitmap
            if (!bitmap.isRecycled) {
                bitmap.recycle()
            }

            // Encode PrinterStatus
            val dartPrintStatus = printResult.toMap(context = context)
           withContext(Dispatchers.Main) {
               // Set result Printer status.
               result.success(dartPrintStatus)
               //result.error("Error", "Method not implemented", "")
           }
        }

    }
}