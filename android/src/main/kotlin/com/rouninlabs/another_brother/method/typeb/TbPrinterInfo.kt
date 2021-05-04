package com.rouninlabs.another_brother.method.typeb

import com.brother.ptouch.sdk.PrinterInfo
import com.rouninlabs.another_brother.method.portFromMap

data class TbPrinterInfo(val ipAddress:String, val portNumber:String, val btAddress:String, val port:PrinterInfo.Port) {
    companion object {
        fun fromMap(map:Map<String, Any>):TbPrinterInfo {
            return TbPrinterInfo(
                    ipAddress = map["ipAddress"] as String,
                    portNumber = map["portNumber"] as String,
                    btAddress = map["btAddress"] as String,
                    port = portFromMap(map["port"] as Map<String, Any>)

            )
        }
    }
}