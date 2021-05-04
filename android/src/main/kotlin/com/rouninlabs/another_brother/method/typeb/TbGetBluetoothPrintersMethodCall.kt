package com.rouninlabs.another_brother.method.typeb

import android.bluetooth.BluetoothAdapter
import android.content.Context
import android.util.Log
import com.rouninlabs.another_brother.method.toBluetoothPrinter
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*

/**
 * Command for getting the Brother that are paired to the device..
 */
class TbGetBluetoothPrintersMethodCall(val flutterAssets: FlutterPlugin.FlutterAssets, val context: Context, val call: MethodCall, val result: MethodChannel.Result) {
    companion object {
        const val METHOD_NAME = "typeB-getBluetoothPrinters"
    }

    fun execute() {

        GlobalScope.launch(Dispatchers.IO) {

            val dartPrintInfo: HashMap<String, Any> = call.argument<HashMap<String, Any>>("printInfo")!!
            val printerId: String = call.argument<String>("printerId")!!
            val models:List<String> = call.argument<List<String>>("models")!!

            
            // TODO Only select the devices containing the model in them.
            // Brother names their printers with the model followed by what seems to be 4 digits.
            val matchingPrinters = BluetoothAdapter.getDefaultAdapter().bondedDevices.filter {
                bluetoothDevice -> models.filter { modelName -> bluetoothDevice.name.contains(modelName) }.isNotEmpty()
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