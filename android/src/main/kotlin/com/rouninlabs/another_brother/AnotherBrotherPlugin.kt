package com.rouninlabs.another_brother

import android.content.Context
import android.os.Build
import androidx.annotation.NonNull
import com.rouninlabs.another_brother.method.*
import com.rouninlabs.another_brother.method.typeb.*

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import kotlin.contracts.contract

/** AnotherBrotherPlugin */
class AnotherBrotherPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var mContext: Context
    private lateinit var mFlutterAssets: FlutterPlugin.FlutterAssets

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "another_brother")
        channel.setMethodCallHandler(this)
        mContext = flutterPluginBinding.applicationContext
        mFlutterAssets = flutterPluginBinding.flutterAssets
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        if (call.method == "getPlatformVersion") {
            result.success("Android ${android.os.Build.VERSION.RELEASE}")
        }
        else if (call.method == PrintImageMethodCall.METHOD_NAME) {
            PrintImageMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == StartCommunicationMethodCall.METHOD_NAME) {
            StartCommunicationMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == EndCommunicationMethodCall.METHOD_NAME) {
            EndCommunicationMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == PrintFileMethodCall.METHOD_NAME) {
            PrintFileMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == PrintFileListMethodCall.METHOD_NAME) {
            PrintFileListMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == PrintPdfFileMethodCall.METHOD_NAME) {
            if (Build.VERSION.SDK_INT > Build.VERSION_CODES.M) {
                PrintPdfFileMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
            } else {
                PrintPdfMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
            }
        }
        /* @Deprecated - Both methods have been merged to expose a single call in Flutter.
        else if (call.method == GetPdfPagesMethodCall.METHOD_NAME) {
            GetPdfPagesMethodCall(context = mContext, call = call, result = result).execute()
        }
         */
        else if (call.method == GetPdfFilePagesMethodCall.METHOD_NAME) {
            if (Build.VERSION.SDK_INT > Build.VERSION_CODES.M) {
                GetPdfFilePagesMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
            } else {
                GetPdfPagesMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
            }
        }
        else if (call.method == TransferMethodCall.METHOD_NAME) {
            TransferMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == SendDatabaseMethodCall.METHOD_NAME) {
            SendDatabaseMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == SendBinaryFileMethodCall.METHOD_NAME) {
            SendBinaryFileMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == SendBinaryMethodCall.METHOD_NAME) {
            SendBinaryMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == GetFirmVersionMethodCall.METHOD_NAME) {
            GetFirmVersionMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == GetMediaVersionMethodCall.METHOD_NAME) {
            GetMediaVersionMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == GetSerialNumberMethodCall.METHOD_NAME) {
            GetSerialNumberMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == GetBatteryWeakMethodCall.METHOD_NAME) {
            GetBatteryWeakMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == GetBootModeMethodCall.METHOD_NAME) {
            GetBootModeMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == GetFirmFileVersionMethodCall.METHOD_NAME) {
            GetFirmFileVersionMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == GetMediaFileVersionMethodCall.METHOD_NAME) {
            GetMediaFileVersionMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == RemoveTemplateMethodCall.METHOD_NAME) {
            RemoveTemplateMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == CancelMethodCall.METHOD_NAME) {
            CancelMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == GetPrinterStatusMethodCall.METHOD_NAME) {
            GetPrinterStatusMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == GetSystemReportMethodCall.METHOD_NAME) {
            GetSystemReportMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == StartPttPrintMethodCall.METHOD_NAME) {
            StartPttPrintMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == ReplaceTextMethodCall.METHOD_NAME) {
            ReplaceTextMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == ReplaceTextIndexMethodCall.METHOD_NAME) {
            ReplaceTextIndexMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == ReplaceTextNameMethodCall.METHOD_NAME) {
            ReplaceTextNameMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == FlushPttPrintMethodCall.METHOD_NAME) {
            FlushPttPrintMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == GetNetPrintersMethodCall.METHOD_NAME) {
            GetNetPrintersMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == GetNetPrinterInfoMethodCall.METHOD_NAME) {
            GetNetPrinterInfoMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == GetBlePrintersMethodCall.METHOD_NAME) {
            GetBlePrintersMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == GetLabelParamMethodCall.METHOD_NAME) {
            GetLabelParamMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == GetLabelInfoMethodCall.METHOD_NAME) {
            GetLabelInfoMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == GetTemplateListMethodCall.METHOD_NAME) {
            GetTemplateListMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == GetBatteryInfoMethodCall.METHOD_NAME) {
            GetBatteryInfoMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == UpdatePrinterSettingsMethodCall.METHOD_NAME) {
            UpdatePrinterSettingsMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == GetPrinterSettingsMethodCall.METHOD_NAME) {
            GetPrinterSettingsMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == GetBluetoothPreferenceMethodCall.METHOD_NAME) {
            GetBluetoothPreferenceMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == UpdateBluetoothPreferenceMethodCall.METHOD_NAME) {
            UpdateBluetoothPreferenceMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == GetBluetoothPrintersMethodCall.METHOD_NAME) {
            GetBluetoothPrintersMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == TbStartCommunicationMethodCall.METHOD_NAME) {
            TbStartCommunicationMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == TbEndCommunicationMethodCall.METHOD_NAME) {
            TbEndCommunicationMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == TbSetupMethodCall.METHOD_NAME) {
            TbSetupMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == TbBarcodeMethodCall.METHOD_NAME) {
            TbBarcodeMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == TbPrintLabelMethodCall.METHOD_NAME) {
            TbPrintLabelMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == TbClearBufferMethodCall.METHOD_NAME) {
            TbClearBufferMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == TbNoBackFeedMethodCall.METHOD_NAME) {
            TbNoBackFeedMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == TbPrinterFontMethodCall.METHOD_NAME) {
            TbPrinterFontMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == TbSendCommandMethodCall.METHOD_NAME) {
            TbSendCommandMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == TbDownloadPcxMethodCall.METHOD_NAME) {
            TbDownloadPcxMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == TbDownloadBmpMethodCall.METHOD_NAME) {
            TbDownloadBmpMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == TbGetPrinterStatusMethodCall.METHOD_NAME) {
            TbGetPrinterStatusMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == TbFormFeedMethodCall.METHOD_NAME) {
            TbFormFeedMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == TbSendCommandBinMethodCall.METHOD_NAME) {
            TbSendCommandBinMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == TbGetBluetoothPrintersMethodCall.METHOD_NAME) {
            TbGetBluetoothPrintersMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else if (call.method == TbSendFileMethodCall.METHOD_NAME) {
            TbSendFileMethodCall(flutterAssets = mFlutterAssets, context = mContext, call = call, result = result).execute()
        }
        else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
