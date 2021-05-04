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
 * Command for ending a communication to a printer.
 */
class TbSetupMethodCall(val flutterAssets: FlutterPlugin.FlutterAssets, val context: Context, val call: MethodCall, val result: MethodChannel.Result) {
    companion object {
        const val METHOD_NAME = "typeB-setup"
    }

    fun execute() {

        GlobalScope.launch(Dispatchers.IO) {

            val dartPrintInfo: HashMap<String, Any> = call.argument<HashMap<String, Any>>("printInfo")!!
            val printerId: String = call.argument<String>("printerId")!!
            val width:Int = call.argument<Int>("width")!!
            val height:Int = call.argument<Int>("height")!!
            val speed:Int = call.argument<Int>("speed")!!
            val density:Int = call.argument<Int>("density")!!
            val sensor:Int = call.argument<Int>("sensor")!!
            val sensorDistance:Int = call.argument<Int>("sensorDistance")!!
            val sensorOffset:Int = call.argument<Int>("sensorOffset")!!

            val tbPrinter:ITbPrinterAdapter? = BrotherManager.getTypeBPrinter(printerId = printerId)

            if (tbPrinter == null) {
                withContext(Dispatchers.Main) {
                    // Set result Printer status.
                    result.success(false)
                }
                return@launch
            }
            // Setup the label
            val success = tbPrinter.setup(width = width, height = height, density = density, sensor = sensor, sensor_distance = sensorDistance, sensor_offset = sensorOffset, speed = speed)

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