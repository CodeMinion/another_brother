package com.rouninlabs.another_brother

import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.hardware.usb.UsbDevice
import android.hardware.usb.UsbManager
import android.os.Build
import androidx.annotation.WorkerThread
import com.brother.ptouch.sdk.Printer
import com.rouninlabs.another_brother.method.typeb.ITbPrinterAdapter
import com.rouninlabs.another_brother.receiver.UsbPermissionsReceiver
import java.util.concurrent.ArrayBlockingQueue
import java.util.concurrent.BlockingQueue

/**
 * Tracker active printers to support the open/print/close approach.
 */
object BrotherManager {

    val mActivePrinters: MutableMap<String, Printer> = hashMapOf()
    val mActiveTypeBPrinters: MutableMap<String, ITbPrinterAdapter> = hashMapOf()

    val mUsbPermissionRequests: MutableMap<Int, BlockingQueue<Boolean>> = hashMapOf()

    fun getPrinter(printerId: String): Printer? {
        return mActivePrinters[printerId]
    }

    fun trackPrinter(printerId: String, printer: Printer) {
        mActivePrinters.put(printerId, printer)
    }

    fun untrackPrinter(printerId: String) {
        mActivePrinters.remove(printerId)
    }

    fun trackTypeBPrinter(printerId: String, printer: ITbPrinterAdapter) {
        mActiveTypeBPrinters.put(printerId, printer)
    }

    fun untrackTypeBPrinter(printerId: String) {
        mActiveTypeBPrinters.remove(printerId)
    }

    fun getTypeBPrinter(printerId: String): ITbPrinterAdapter? {
        return mActiveTypeBPrinters[printerId]
    }

    /**
     * Makes a permission request to get access to the usb device
     */
    @WorkerThread
    fun requestUsbPermission(
        context: Context,
        usbManager: UsbManager,
        usbDevice: UsbDevice
    ): Boolean {//:BlockingQueue<Boolean> {
        val requestId = usbDevice.deviceId
        if (mUsbPermissionRequests.containsKey(requestId)) {
            return mUsbPermissionRequests[requestId]!!.take()
        }

        val completableFuture = ArrayBlockingQueue<Boolean>(1)
        mUsbPermissionRequests.put(requestId, completableFuture)
        val intent = Intent(context, UsbPermissionsReceiver::class.java)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            usbManager.requestPermission(
                usbDevice,
                PendingIntent.getBroadcast(context, 1234, intent, PendingIntent.FLAG_IMMUTABLE)
            )
        } else {
            usbManager.requestPermission(
                usbDevice,
                PendingIntent.getBroadcast(context, 1234, intent, 0)
            )
        }
        return completableFuture.take()
    }

    fun completePermissionRequest(usbDevice: UsbDevice, granted: Boolean) {
        val requestId = usbDevice.deviceId
        if (!mUsbPermissionRequests.containsKey(requestId)) {
            return
        }

        mUsbPermissionRequests[requestId]?.put(granted)
        mUsbPermissionRequests.remove(requestId)

    }
}