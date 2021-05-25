package com.rouninlabs.another_brother.method.typeb

import android.content.Context
import android.os.Environment
import android.util.Log
import com.rouninlabs.another_brother.method.typeb.internal.BrotherActivity
//import com.example.brotherdll.BrotherActivity
import java.io.File

class TbPrinterBluetooth(val context: Context, val btAddress:String):ITbPrinterAdapter {
    private val RESULT_SUCCESS = "1"

    private val mPrintConnector: BrotherActivity = BrotherActivity()

    override fun openPort(): Boolean {
        try {
            val result = mPrintConnector.openport(btAddress)
            return result == RESULT_SUCCESS
        }
        catch (e:Exception) {
            Log.w("another_brother", "openPort Failed:", e)
            return false;
        }
    }

    override fun downloadPcx(filePath: String, brotherFileName:String): Boolean {
        val inputFile = File(filePath)
        val downloadFolder = context.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS)
        val downloadFile = File(downloadFolder, brotherFileName)
        inputFile.copyTo(downloadFile, overwrite = true)
        val result = mPrintConnector.downloadpcx(context, downloadFile.name)
        return result == RESULT_SUCCESS
    }

    override fun downloadBmp(filePath: String, brotherFileName:String): Boolean {
        val inputFile = File(filePath)
        // Library is hardcoded to this, this is a problem and needs to be chanced. 
        val downloadFolder = context.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS)
        val downloadFile = File(downloadFolder, brotherFileName)

        // Note: This is a work around because of the location it is being saved to 
        inputFile.copyTo(downloadFile, overwrite = true)
        val result = mPrintConnector.downloadbmp(context, downloadFile.name)
        return result == RESULT_SUCCESS
    }

    override fun sendFile(filePath: String, brotherFileName: String): Boolean {
        val inputFile = File(filePath)
        val downloadFolder = context.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS)
        val downloadFile = File(downloadFolder, brotherFileName)
        inputFile.copyTo(downloadFile, overwrite = true)
        val result = mPrintConnector.downloadfile(downloadFile, downloadFile.name)
        return result == RESULT_SUCCESS
    }

    override fun setup(width: Int, height: Int, speed: Int, density: Int, sensor: Int, sensor_distance: Int, sensor_offset: Int): Boolean {
        val result = mPrintConnector.setup(width, height, speed, density, sensor, sensor_distance, sensor_offset)
        return result == RESULT_SUCCESS
    }

    override fun clearBuffer(): Boolean {
        val result = mPrintConnector.clearbuffer()
        return result == RESULT_SUCCESS
    }

    override fun noBackFeed(): Boolean {
        val result = mPrintConnector.nobackfeed()
        return result == RESULT_SUCCESS
    }

    override fun formFeed(): Boolean {
        val result = mPrintConnector.formfeed()
        return result == RESULT_SUCCESS
    }

    override fun barcode(x: Int, y: Int, type: String, height: Int, human_readable: Int, rotation: Int, narrow: Int, wide: Int, string: String): Boolean {
        val result = mPrintConnector.barcode(x, y, type, height, human_readable, rotation, narrow, wide, string)
        return result == RESULT_SUCCESS
    }

    override fun printerFont(x: Int, y: Int, size: String, rotation: Int, x_multiplication: Int, y_multiplication: Int, string: String): Boolean {
        val result = mPrintConnector.printerfont(x, y, size, rotation, x_multiplication, y_multiplication, string)
        return result == RESULT_SUCCESS
    }

    override fun sendCommand(message: String): Boolean {
        val result = mPrintConnector.sendcommand(message)
        return result == RESULT_SUCCESS
    }

    override fun sendCommand(message: ByteArray): Boolean {
        val result = mPrintConnector.sendcommand(message)
        return result == RESULT_SUCCESS
    }

    override fun printLabel(quantity: Int, copy: Int): Boolean {
        val result = mPrintConnector.printlabel(quantity, copy)
        return result == RESULT_SUCCESS
    }

    override fun printerStatus(delay: Int): String {
        val result = mPrintConnector.printerstatus(delay)
        return result
    }

    override fun closePort(timeout: Int): Boolean {
        val result = mPrintConnector.closeport(timeout)
        return result == RESULT_SUCCESS
    }

    override fun getId(): String {
        return btAddress
    }
}