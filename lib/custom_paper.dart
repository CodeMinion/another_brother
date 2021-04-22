
abstract class ACustomPaper {
  Map<String, dynamic> toMap();

}

class Paper_RJ4250WB implements ACustomPaper {
  final String _name;
  final String _assetPath;

  static const String _rootDir = "packages/another_brother/custom_paper";
  const Paper_RJ4250WB._internal(this._name, this._assetPath);

  static const RD_W1_9H3_3in = const Paper_RJ4250WB._internal("RJ4250WB-RD1.9x3.3", "$_rootDir/CustomRJ4250Paper/RJ4250WB-RD1.9x3.3.bin");
  static const RD_W2_2in = const Paper_RJ4250WB._internal("RJ4250WB-RD2.2inch", "$_rootDir/CustomRJ4250Paper/RJ4250WB-RD2.2inch.bin");
  static const RD_W2_3H3_6in = const Paper_RJ4250WB._internal("RJ4250WB-RD2.3x3.6", "$_rootDir/CustomRJ4250Paper/RJ4250WB-RD2.3x3.6.bin");
  static const RD_W3_1H4_5in = const Paper_RJ4250WB._internal("RJ4250WB-RD3.1x4.5", "$_rootDir/CustomRJ4250Paper/RJ4250WB-RD3.1x4.5.bin");
  static const RD_W4in = const Paper_RJ4250WB._internal("RJ4250WB-RD4inch", "$_rootDir/CustomRJ4250Paper/RJ4250WB-RD4inch.bin");
  static const RD_W4H1in = const Paper_RJ4250WB._internal("RJ4250WB-RD4x1", "$_rootDir/CustomRJ4250Paper/RJ4250WB-RD4x1.bin");
  static const RD_W4H2in = const Paper_RJ4250WB._internal("RJ4250WB-RD4x2", "$_rootDir/CustomRJ4250Paper/RJ4250WB-RD4x2.bin");
  static const RD_W4H3in = const Paper_RJ4250WB._internal("RJ4250WB-RD4x3", "$_rootDir/CustomRJ4250Paper/RJ4250WB-RD4x3.bin");
  static const RD_W4H4in = const Paper_RJ4250WB._internal("RJ4250WB-RD4x4", "$_rootDir/CustomRJ4250Paper/RJ4250WB-RD4x4.bin");
  static const RD_W4H6in = const Paper_RJ4250WB._internal("RJ4250WB-RD4x6", "$_rootDir/CustomRJ4250Paper/RJ4250WB-RD4x6.bin");
  static const RD_W50H85mm = const Paper_RJ4250WB._internal("RJ4250WB-RD50_85mm", "$_rootDir/CustomRJ4250Paper/RJ4250WB-RD50_85mm.bin");
  static const RD_W60H92mm = const Paper_RJ4250WB._internal("RJ4250WB-RD60_92mm", "$_rootDir/CustomRJ4250Paper/RJ4250WB-RD60_92mm.bin");
  static const RD_W80H115mm = const Paper_RJ4250WB._internal("RJ4250WB-RD80_115mm", "$_rootDir/CustomRJ4250Paper/RJ4250WB-RD80_115mm.bin");
  static const RD_W80mm = const Paper_RJ4250WB._internal("RJ4250WB-RD80mm", "CustomPaper/$_rootDir/RJ4250WB-RD80mm.bin");

  @override
  Map<String, dynamic> toMap() {
    return {
      "name": _name,
      "assetPath": _assetPath
    };
  }
}