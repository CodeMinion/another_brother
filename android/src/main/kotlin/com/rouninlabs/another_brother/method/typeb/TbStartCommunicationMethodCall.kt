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
 * Command for starting a communication to a printer.
 * It will track the printer so it is available to print commands as well as close communication commands.
 */
class TbStartCommunicationMethodCall(val flutterAssets: FlutterPlugin.FlutterAssets, val context: Context, val call: MethodCall, val result: MethodChannel.Result) {
    companion object {
        const val METHOD_NAME = "typeB-startCommunication"
    }

    fun execute() {

        // The TypeB SDK is wrapped around an Activity...
        GlobalScope.launch(Dispatchers.Main) {

            val dartPrintInfo: HashMap<String, Any> = call.argument<HashMap<String, Any>>("printInfo")!!
            //val printerId: String = call.argument<String>("printerId")!!

            // TODO Decode printer Info

            val printerInfo:TbPrinterInfo = TbPrinterInfo.fromMap(dartPrintInfo)

            // TODO Create printer connector based on port info
            val tbPrinter:ITbPrinterAdapter? = when (printerInfo.port) {
                PrinterInfo.Port.USB -> {
                    TbPrinterUsb(context = context)
                }
                PrinterInfo.Port.BLUETOOTH -> {
                    TbPrinterBluetooth(context = context, btAddress = printerInfo.btAddress)
                }
                PrinterInfo.Port.NET -> {
                    TbPrinterWifi(context = context, ipAddress = printerInfo.ipAddress, porNumber = printerInfo.portNumber)
                }
                else -> {
                    // We don't support anything else on BT printers.
                    null
                }

            }


            if (tbPrinter == null) {

                withContext(Dispatchers.Main) {
                    // Set result Printer status.
                    result.success("")
                }
                return@launch
            }
            // open connection
            //val success = tbPrinter.openPort()

            val success = withContext(Dispatchers.IO) {
                // Set result Printer status.
                tbPrinter.openPort()
            }

            if (!success) {
                withContext(Dispatchers.Main) {
                    // Set result Printer status.
                    result.success("")
                }
                return@launch
            }

            val printerId = tbPrinter.getId()
            // On Success track printer
            BrotherManager.trackTypeBPrinter(printerId = printerId, printer = tbPrinter)
            withContext(Dispatchers.Main) {
               // Set result Printer status.
               result.success(printerId)
           }
        }

    }
}