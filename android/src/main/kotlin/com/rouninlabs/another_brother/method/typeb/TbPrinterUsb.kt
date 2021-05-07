package com.rouninlabs.another_brother.method.typeb

import android.content.Context
import android.hardware.usb.UsbDevice
import android.hardware.usb.UsbManager
import android.os.Environment
import com.rouninlabs.another_brother.BrotherManager
import com.rouninlabs.another_brother.method.typeb.internal.BrotherUSBActivity
import java.io.File
import java.util.*

class TbPrinterUsb(val context: Context):ITbPrinterAdapter {
    private val RESULT_SUCCESS = "1"

    private val BROTHER_VENDOR_ID = 1273

    private val mPrintConnector: BrotherUSBActivity = BrotherUSBActivity()

    override fun openPort(): Boolean {
        
        val usbManager = context.getSystemService(Context.USB_SERVICE) as UsbManager
        val deviceList: HashMap<String, UsbDevice> = usbManager.getDeviceList()

        val deviceIterator: Iterator<UsbDevice> = deviceList.values.iterator()
        var brotherUsbDevice:UsbDevice? = null
        while (deviceIterator.hasNext()) {
            val usbDevice = deviceIterator.next()
            if (usbDevice.getVendorId() == BROTHER_VENDOR_ID) {
                brotherUsbDevice = usbDevice
                break
            }
        }

        if (brotherUsbDevice == null) {
            return false;
        }
        
        val hasPermissions = BrotherManager.requestUsbPermission(context = context, usbManager = usbManager, usbDevice = brotherUsbDevice)
        
        if (!hasPermissions) {
            return false
        }
        
        val result = mPrintConnector.openport(usbManager, brotherUsbDevice)
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

    override fun downloadBmp(filePath: String, brotherFileName:String): Boolean {
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
        return "$BROTHER_VENDOR_ID"
    }
}