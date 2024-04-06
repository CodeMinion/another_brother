# another_brother

Another Bother SDK library for Flutter. For full demo app see Another-Brother-Demo-Prime https://github.com/CodeMinion/Demo-Another-Brother-Prime

## Android Support
- Bluetooth/BLE
- WiFi
- USB

## iOS Support
- Bluetooth/BLE
- WiFi

## Android Min SDK
- Requires minSdkVersion 19

## iOS Info.plist

Add the following to your Info.plist
```
	<!-- Another Brother Section -->
	<key>NSLocalNetworkUsageDescription</key>
        <string>Looking for local tcp Bonjour service</string>
        <key>NSBonjourServices</key>
        <array>
        	<string>_ipp._tcp</string>
        	<string>_printer._tcp</string>
        	<string>_pdl-datastream._tcp</string>
        </array>
        <key>UIBackgroundModes</key>
        <array>
        	<string>fetch</string>
        	<string>remote-notifications</string>
        </array>
        <key>NSBluetoothAlwaysUsageDescription</key>
    	<string>Need BLE permission</string>
    	<key>NSBluetoothPeripheralUsageDescription</key>
    	<string>Need BLE permission</string>
    	<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
    	<string>Need Location permission</string>
    	<key>NSLocationAlwaysUsageDescription</key>
    	<string>Need Location permission</string>
    	<key>NSLocationWhenInUseUsageDescription</key>
    	<string>Need Location permission</string>
    	<key>UISupportedExternalAccessoryProtocols</key>
    	<array>
    		<string>com.brother.ptcbp</string>
    		<!-- Only needed if working with TypeB printer. IMPORTANT: If planning to release to the Apple store don't use it as it will lead to a rejection -->
    		<string>com.issc.datapath</string>
    	</array>
    	<!-- End Another Brother Section -->
```
On your Runner make sure to mark: Allow non-modular includes as yes.
Also make sure to mark the libBROTHERSDK.a as belonging to another_brother in xCode: https://www.youtube.com/watch?v=42dBVdXU8gk

iOS Setup Video: https://www.youtube.com/watch?v=AcFnd-6hSew

## Publishing to the Apple Store
When submitting your application to the Apple store you'll need to obtain a PPID from Brother. This can be achieved by making a request here: https://secure6.brother.co.jp/mfi/Top.aspx

Without it you'll likely receive a rejection message along the lines of:

```
App has not been authorized by the accessory manufacturer to work with the MFi accessory
```



## Apps Built with another_brother
Have an app built using another_brother let me know and I will add it here!

- Easy Menu: https://www.youtube.com/watch?v=xy9qYo03pOQ
- QR Storage: https://play.google.com/store/apps/details?id=com.rouninlabs.qrstorage
- Speed Dater: https://youtu.be/z4jxO9HWze8
- 4.events: https://play.google.com/store/apps/details?id=com.fourevents.app
- PoachMe.dev: https://poachme.dev/#/devLand?reqCode=SAVETIME&
- OkosHACCP: https://play.google.com/store/apps/details?id=hu.okoshaccp.operator built by https://wunderbytes.eu/
- ARMS Mobile: https://apps.apple.com/us/app/arms-mobile/id1615127530

# Brother Hackathon
Feel free to use any of my GitHub repositories in your apps. You should also consider
attending the free Brother Hackathon happening this year. You get a free Brother QL-1110NWB,
a PT-P910BT, and possibly an awesome DS-940DW mobile scanner. Visit brotherhackathon.com for
more information. I will be teaching workshops, and they are free. You can ask me any questions.
Thank you.

