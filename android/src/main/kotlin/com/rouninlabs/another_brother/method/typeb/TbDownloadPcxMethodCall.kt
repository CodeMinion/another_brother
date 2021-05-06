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
 * Command for Downloading a PCX file to the printer.
 */
class TbDownloadPcxMethodCall(val flutterAssets: FlutterPlugin.FlutterAssets, val context: Context, val call: MethodCall, val result: MethodChannel.Result) {
    companion object {
        const val METHOD_NAME = "typeB-downloadPcx"
    }

    fun execute() {

        GlobalScope.launch(Dispatchers.IO) {

            val dartPrintInfo: HashMap<String, Any> = call.argument<HashMap<String, Any>>("printInfo")!!
            val printerId: String = call.argument<String>("printerId")!!
            val filePath = call.argument<String>("filePath")!!
            val brotherFileName = call.argument<String>("brotherFileName")!!

            
            val tbPrinter:ITbPrinterAdapter? = BrotherManager.getTypeBPrinter(printerId = printerId)

            if (tbPrinter == null) {
                withContext(Dispatchers.Main) {
                    // Set result Printer status.
                    result.success(false)
                }
                return@launch
            }

            val success = tbPrinter.downloadPcx(filePath = filePath, brotherFileName = brotherFileName)
            
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