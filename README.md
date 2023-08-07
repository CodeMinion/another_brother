# another_brother

Another Bother SDK library for Flutter.

## Android Support
- Bluetooth/BLE
- WiFi
- USB

## iOS Support
- Bluetooth/BLE
- WiFi
Note: This branch does not include RJ-Go support on IOS.

## Android Min SDK
- Requires minSdkVersion 21

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
    		<string>com.issc.datapath</string>
    	</array>
    	<!-- End Another Brother Section -->
```
On your Runner make sure to mark: Allow non-modular includes as yes.
Also make sure to mark the libBROTHERSDK.a as belonging to another_brother in xCode: https://www.youtube.com/watch?v=42dBVdXU8gk
