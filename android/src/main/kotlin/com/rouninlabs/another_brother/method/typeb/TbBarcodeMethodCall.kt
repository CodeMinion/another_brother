package com.rouninlabs.another_brother.method.typeb

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
 * Command for creating a barcode on the printer.
 */
class TbBarcodeMethodCall(val flutterAssets: FlutterPlugin.FlutterAssets, val context: Context, val call: MethodCall, val result: MethodChannel.Result) {
    companion object {
        const val METHOD_NAME = "typeB-barcode"
    }

    fun execute() {

        GlobalScope.launch(Dispatchers.IO) {

            val dartPrintInfo: HashMap<String, Any> = call.argument<HashMap<String, Any>>("printInfo")!!
            val printerId: String = call.argument<String>("printerId")!!
            val content:String = call.argument<String>("content")!!
            val x:Int = call.argument<Int>("x")!!
            val y:Int = call.argument<Int>("y")!!
            val type:String = call.argument<String>("type")!!
            val height:Int = call.argument<Int>("height")!!
            val humanReadable:Int = call.argument<Int>("humanReadable")!!
            val rotation:Int = call.argument<Int>("rotation")!!
            val narrowBarRatio:Int = call.argument<Int>("narrowBarRatio")!!
            val wideBarRatio:Int = call.argument<Int>("wideBarRatio")!!

            val tbPrinter:ITbPrinterAdapter? = BrotherManager.getTypeBPrinter(printerId = printerId)

            if (tbPrinter == null) {
                withContext(Dispatchers.Main) {
                    // Set result Printer status.
                    result.success(false)
                }
                return@launch
            }
            // Setup the label
            val success = tbPrinter.barcode(x = x, y = y, height = height, human_readable = humanReadable, narrow = narrowBarRatio, wide = wideBarRatio, rotation = rotation, type = type, string = content )

            if (!success) {
                withContext(Dispatchers.Main) {
                    // Set result Printer status.
                    result.success(false)
                }
                return@launch
            }

            // On Success track printer
            withContext(Dispatchers.Main) {
               // Set result Printer status.
               result.success(true)
           }
        }

    }
}