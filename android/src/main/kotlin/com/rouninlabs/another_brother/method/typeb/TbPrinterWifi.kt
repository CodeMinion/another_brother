package com.rouninlabs.another_brother.method.typeb

import android.content.Context
import android.os.Environment
import com.rouninlabs.another_brother.method.typeb.internal.BrotherWifiActivity

import java.io.File

class TbPrinterWifi(val context: Context, val ipAddress:String, val porNumber:String):ITbPrinterAdapter {
    private val RESULT_SUCCESS = "1"

    private val mPrintConnector: BrotherWifiActivity = BrotherWifiActivity()

    override fun openPort(): Boolean {
        val result = mPrintConnector.openport(ipAddress, porNumber.toInt())
        return result == RESULT_SUCCESS
    }

    override fun downloadPcx(filePath: String, brotherFileName:String): Boolean {
        val inputFile = File(filePath)
        val downloadFolder = context.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS)
        val downloadFile = File(downloadFolder, brotherFileName)
        inputFile.copyTo(downloadFile, overwrite = true)
        val result = mPrintConnector.downloadpcx(context, downloadFile.name)
        return result == RESULT_SUCCESS
    }

    override fun downloadBmp(filePath: String, brotherFileName: String): Boolean {
        val inputFile = File(filePath)
        val downloadFolder = context.getExternalFilesDir(Environment.DIRECTORY_DOWNLOADS)
        val downloadFile = File(downloadFolder, brotherFileName)
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
        return "$ipAddress:$porNumber"
    }
}