package com.rouninlabs.another_brother.receiver

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.hardware.usb.UsbDevice
import android.hardware.usb.UsbManager
import com.rouninlabs.another_brother.BrotherManager

class UsbPermissionsReceiver: BroadcastReceiver() {

    override fun onReceive(context: Context, intent: Intent) {

        val device:UsbDevice? = intent.getParcelableExtra(UsbManager.EXTRA_DEVICE)
        val granted = intent.getBooleanExtra(UsbManager.EXTRA_PERMISSION_GRANTED, false)
        
        device?.let {
            BrotherManager.completePermissionRequest(usbDevice = it, granted = granted)
        }
    }
}