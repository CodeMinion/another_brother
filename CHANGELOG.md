## 0.0.1
- Initial release with support for both Android and iOS.
- Includes support for paper bin files.
- Includes support fort TypeB printers as well.

## 0.0.7
- Updates NetPrint to use common Printer interface.

## 0.0.8
- Exposes getName from papers.

## 0.0.9
- Fixes name for QL1100's W102 paper.

## 0.0.10
- Exposes getValues for additional papers.
- Paper now return an immutable list from getValues()

## 0.0.11
- Fixes dimension calculation for Type B download Image.
- Handles missing BT address when trying to connect over BT on Type B.

## 0.0.12
- Added valueFromName to Bin papers.
- Added UNSUPPORTED to Bin papers.

## 0.0.13
- Updated the names for the RJ-4250 bin papers.

## 0.0.14
- Additional Updates for the names of the RJ-4250 bin papers.

## 0.0.15
- Discovered TypeB printers now share the common interface ABrotherTbPrinter.

## 0.0.16
- Adds support for downloadImage in iOS. This allows for printing of custom images on a TypeB printer.

## 0.0.17
- RJ-Go models now share model interface with label printers.
- RJ-Go Labels now share label interface with label printers.

## 0.0.18
- Exposes getName in common printer model interface.

## 0.0.19
- Updates TypeB unsupported label name for parity.

## 0.0.20
- Adds missing toMap/fromMap for Type B models and Type B labels.

## 0.0.21
- Fixes toMap on TbModel.

## 0.0.22
- PaperSize now shares common interface as other labels.

## 0.0.23
- Fixes issue with startPTTPrint. Special thanks to rendesg for the fixes.

## 0.0.24
- Fixes exception on iOS print. Special thanks to BentEngbers for the report.

## 0.0.25
- Moved from JCenter to MavenCentral for Android dependencies.

## 0.0.26
- Added Bluetooth permissions required by Android 12

## 0.0.27
- Replaces flutter_blue with flutter_blu_plus

## 0.0.28
- Resolves issue where app UI freezes while calling printImage on iOS.

## 0.0.29
- Upgrades Android libs to v4.6.1 of the Brother SDK.

## 0.0.30
- Adds support for getPDFFilePages on iOS.

## 0.0.31
- Adds orientation support for PT printers on iOS.

## 0.0.32
- Updates Bluetooth printer filter on Android.

## 0.0.33
- Updates USB permissions check for Android 13.
