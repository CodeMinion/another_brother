package com.rouninlabs.another_brother.method

import android.bluetooth.BluetoothAdapter
import android.content.Context
import android.graphics.BitmapFactory
import android.util.Log
import com.brother.ptouch.sdk.LabelInfo
import com.brother.ptouch.sdk.Printer
import com.brother.ptouch.sdk.PrinterInfo
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*


class PrintImageMethodCall(val context: Context, val call: MethodCall, val result: MethodChannel.Result) {
    companion object {
        const val METHOD_NAME = "printImage"
    }

    fun execute() {

        GlobalScope.launch(Dispatchers.IO) {

            // TODO Run on background thread.
            val dartPrintInfo: HashMap<String, Any> = call.argument<HashMap<String, Any>>("printInfo")!!
            val imageBytes: ByteArray = call.argument<ByteArray>("imageBytes")!!

            Log.e("Brother", "Image Bytes: $imageBytes - Size ${imageBytes.size}")
            // Bytes to bitmap
            val bitmap = BitmapFactory.decodeByteArray(imageBytes, 0, imageBytes.size)
            // Decoded Printer Info
            val printInfo = printerInfofromMap(dartPrintInfo)
            Log.e("Brother", "PrintInfo: $dartPrintInfo")
            Log.e("Brother", "Parsed Info: ${printInfo}")
            // Create Printer
            val printer = Printer()
            if (printInfo.workPath.isEmpty()) {
                printInfo.workPath = context.filesDir.absolutePath + "/";
            }
            // Set Printer Info
            printer.printerInfo = printInfo

            if (printInfo.port == PrinterInfo.Port.BLUETOOTH){
                printer.setBluetooth(BluetoothAdapter.getDefaultAdapter())
            }
            else if ( printInfo.port == PrinterInfo.Port.BLE) {
                printer.setBluetoothLowEnergy(context, BluetoothAdapter.getDefaultAdapter(), 3000)
            }

            // Start communication
            printer.startCommunication()
            // Print Image
            val printResult = printer.printImage(bitmap)
            // End Communication
            printer.endCommunication()
            // Recycle bitmap
            if (!bitmap.isRecycled) {
                bitmap.recycle()
            }

            // Encode PrinterStatus
            val dartPrintStatus = printResult.toMap()
           withContext(Dispatchers.Main) {
               // Set result Printer status.
               result.success(dartPrintStatus)
               //result.error("Error", "Method not implemented", "")
           }
        }

    }
}