package com.rouninlabs.another_brother.method.typeb

interface ITbPrinterAdapter {

    fun openPort():Boolean

    fun downloadPcx(filePath:String, brotherFileName:String):Boolean

    fun downloadBmp(filePath:String, brotherFileName: String):Boolean

    fun sendFile(filePath:String, brotherFileName:String):Boolean

    fun setup(width:Int, height:Int, speed:Int, density:Int, sensor:Int, sensor_distance:Int, sensor_offset:Int):Boolean

    fun clearBuffer():Boolean

    fun noBackFeed():Boolean

    fun formFeed():Boolean

    fun barcode(x:Int, y:Int, type:String , height:Int, human_readable:Int, rotation:Int, narrow:Int, wide:Int, string:String):Boolean

    fun printerFont(x:Int, y:Int, size:String , rotation:Int, x_multiplication:Int, y_multiplication:Int, string:String):Boolean

    fun sendCommand(message:String):Boolean
    
    fun sendCommand(message:ByteArray):Boolean

    fun printLabel(quantity:Int, copy:Int):Boolean

    fun printerStatus(delay:Int):String

    fun closePort(timeout:Int):Boolean

    fun getId():String
}