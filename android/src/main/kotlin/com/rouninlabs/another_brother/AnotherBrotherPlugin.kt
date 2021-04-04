package com.rouninlabs.another_brother

import android.content.Context
import androidx.annotation.NonNull
import com.rouninlabs.another_brother.method.*

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import kotlin.contracts.contract

/** AnotherBrotherPlugin */
class AnotherBrotherPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
    private lateinit var mContext: Context

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "another_brother")
    channel.setMethodCallHandler(this)
    mContext = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    }
    else if (call.method == PrintImageMethodCall.METHOD_NAME) {
        PrintImageMethodCall(context = mContext, call = call, result = result).execute()
    }
    else if (call.method == StartCommunicationMethodCall.METHOD_NAME) {
        StartCommunicationMethodCall(context = mContext, call = call, result = result).execute()
    }
    else if (call.method == EndCommunicationMethodCall.METHOD_NAME) {
        EndCommunicationMethodCall(context = mContext, call = call, result = result).execute()
    }
    else if (call.method == PrintFileMethodCall.METHOD_NAME) {
        PrintFileMethodCall(context = mContext, call = call, result = result).execute()
    }
    else if (call.method == PrintFileListMethodCall.METHOD_NAME) {
        PrintFileListMethodCall(context = mContext, call = call, result = result).execute()
    }
    else if (call.method == PrintPdfFileMethodCall.METHOD_NAME) {
        PrintPdfFileMethodCall(context = mContext, call = call, result = result).execute()
    }
    else if (call.method == GetPdfPagesMethodCall.METHOD_NAME) {
        GetPdfPagesMethodCall(context = mContext, call = call, result = result).execute()
    }
    else if (call.method == GetPdfFilePagesMethodCall.METHOD_NAME) {
        GetPdfFilePagesMethodCall(context = mContext, call = call, result = result).execute()
    }
    else if (call.method == TransferMethodCall.METHOD_NAME) {
        TransferMethodCall(context = mContext, call = call, result = result).execute()
    }
    else if (call.method == SendDatabaseMethodCall.METHOD_NAME) {
        SendDatabaseMethodCall(context = mContext, call = call, result = result).execute()
    }
    else if (call.method == SendBinaryFileMethodCall.METHOD_NAME) {
        SendBinaryFileMethodCall(context = mContext, call = call, result = result).execute()
    }
    else if (call.method == SendBinaryMethodCall.METHOD_NAME) {
        SendBinaryMethodCall(context = mContext, call = call, result = result).execute()
    }
    else if (call.method == GetFirmVersionMethodCall.METHOD_NAME) {
        GetFirmVersionMethodCall(context = mContext, call = call, result = result).execute()
    }
    else if (call.method == GetMediaVersionMethodCall.METHOD_NAME) {
        GetMediaVersionMethodCall(context = mContext, call = call, result = result).execute()
    }
    else if (call.method == GetSerialNumberMethodCall.METHOD_NAME) {
        GetSerialNumberMethodCall(context = mContext, call = call, result = result).execute()
    }
    else if (call.method == GetBatteryWeakMethodCall.METHOD_NAME) {
        GetBatteryWeakMethodCall(context = mContext, call = call, result = result).execute()
    }
    else if (call.method == GetBootModeMethodCall.METHOD_NAME) {
        GetBootModeMethodCall(context = mContext, call = call, result = result).execute()
    }
    else if (call.method == GetFirmFileVersionMethodCall.METHOD_NAME) {
        GetFirmFileVersionMethodCall(context = mContext, call = call, result = result).execute()
    }
    else if (call.method == GetMediaFileVersionMethodCall.METHOD_NAME) {
        GetMediaFileVersionMethodCall(context = mContext, call = call, result = result).execute()
    }
    else if (call.method == RemoveTemplateMethodCall.METHOD_NAME) {
        RemoveTemplateMethodCall(context = mContext, call = call, result = result).execute()
    }
    else if (call.method == CancelMethodCall.METHOD_NAME) {
        CancelMethodCall(context = mContext, call = call, result = result).execute()
    }
    else if (call.method == GetPrinterStatusMethodCall.METHOD_NAME) {
        GetPrinterStatusMethodCall(context = mContext, call = call, result = result).execute()
    }
    else if (call.method == GetSystemReportMethodCall.METHOD_NAME) {
        GetSystemReportMethodCall(context = mContext, call = call, result = result).execute()
    }
    else if (call.method == StartPttPrintMethodCall.METHOD_NAME) {
        StartPttPrintMethodCall(context = mContext, call = call, result = result).execute()
    }
    else if (call.method == ReplaceTextMethodCall.METHOD_NAME) {
        ReplaceTextMethodCall(context = mContext, call = call, result = result).execute()
    }
    else if (call.method == ReplaceTextIndexMethodCall.METHOD_NAME) {
        ReplaceTextIndexMethodCall(context = mContext, call = call, result = result).execute()
    }
    else if (call.method == ReplaceTextNameMethodCall.METHOD_NAME) {
        ReplaceTextNameMethodCall(context = mContext, call = call, result = result).execute()
    }
    else if (call.method == GetNetPrintersMethodCall.METHOD_NAME) {
        GetNetPrintersMethodCall(context = mContext, call = call, result = result).execute()
    }
    else if (call.method == GetNetPrinterInfoMethodCall.METHOD_NAME) {
        GetNetPrinterInfoMethodCall(context = mContext, call = call, result = result).execute()
    }
    else if (call.method == GetBlePrintersMethodCall.METHOD_NAME) {
        GetBlePrintersMethodCall(context = mContext, call = call, result = result).execute()
    }
    else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
