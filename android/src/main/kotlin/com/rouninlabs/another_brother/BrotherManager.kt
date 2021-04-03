package com.rouninlabs.another_brother

import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.hardware.usb.UsbDevice
import android.hardware.usb.UsbManager
import com.brother.ptouch.sdk.Printer
import com.rouninlabs.another_brother.receiver.UsbPermissionsReceiver
import java.util.concurrent.ArrayBlockingQueue
import java.util.concurrent.BlockingQueue

/**
 * Tracker active printers to support the open/print/close approach.
 */
object BrotherManager {

    val mActivePrinters:MutableMap<String, Printer> = hashMapOf()
    val mUsbPermissionRequests: MutableMap<Int, BlockingQueue<Boolean>> = hashMapOf()

    fun getPrinter(printerId:String):Printer? {
        return mActivePrinters[printerId]
    }

    fun trackPrinter(printerId: String, printer: Printer) {
        mActivePrinters.put(printerId, printer)
    }

    fun untrackPrinter(printerId: String) {
        mActivePrinters.remove(printerId)
    }

    /**
     * Makes a permission request to get access to the usb device
     */
    fun requestUsbPermission(context: Context, usbManager: UsbManager, usbDevice: UsbDevice) :BlockingQueue<Boolean> {
        val requestId = usbDevice.deviceId
        if (mUsbPermissionRequests.containsKey(requestId)) {
            return mUsbPermissionRequests[requestId]!!;
        }

        val completableFuture = ArrayBlockingQueue<Boolean>(1)
        mUsbPermissionRequests.put(requestId, completableFuture)
        val intent = Intent(context, UsbPermissionsReceiver::class.java)
        usbManager.requestPermission(usbDevice, PendingIntent.getBroadcast(context, 1234, intent, 0))
        return completableFuture
    }

    fun completePermissionRequest(usbDevice: UsbDevice, granted:Boolean) {
        val requestId = usbDevice.deviceId
        if (!mUsbPermissionRequests.containsKey(requestId)) {
            return
        }

       mUsbPermissionRequests[requestId]?.put(granted)
        mUsbPermissionRequests.remove(requestId)

    }
}