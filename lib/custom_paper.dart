abstract class CustomPaper {
  Map<String, dynamic> toMap();

}

class Paper_RJ4250WB implements CustomPaper {
  final String _name;
  final String _assetPath;

  const Paper_RJ4250WB._internal(this._name, this._assetPath);

  static const RD_W1_9H3_3in = const Paper_RJ4250WB._internal("RJ4250WB-RD1.9x3.3", "CustomPaper/CustomRJ4250Paper/RJ4250WB-RD1.9x3.3.bin");
  static const RD_W2_2in = const Paper_RJ4250WB._internal("RJ4250WB-RD2.2inch", "CustomPaper/CustomRJ4250Paper/RJ4250WB-RD2.2inch.bin");
  static const RD_W2_3H3_6in = const Paper_RJ4250WB._internal("RJ4250WB-RD2.3x3.6", "CustomPaper/CustomRJ4250Paper/RJ4250WB-RD2.3x3.6.bin");
  static const RD_W3_1H4_5in = const Paper_RJ4250WB._internal("RJ4250WB-RD3.1x4.5", "CustomPaper/CustomRJ4250Paper/RJ4250WB-RD3.1x4.5.bin");
  static const RD_W4in = const Paper_RJ4250WB._internal("RJ4250WB-RD4inch", "CustomPaper/CustomRJ4250Paper/RJ4250WB-RD4inch.bin");
  static const RD_W4H1in = const Paper_RJ4250WB._internal("RJ4250WB-RD4x1", "CustomPaper/CustomRJ4250Paper/RJ4250WB-RD4x1.bin");
  static const RD_W4H2in = const Paper_RJ4250WB._internal("RJ4250WB-RD4x2", "CustomPaper/CustomRJ4250Paper/RJ4250WB-RD4x2.bin");
  static const RD_W4H3in = const Paper_RJ4250WB._internal("RJ4250WB-RD4x3", "CustomPaper/CustomRJ4250Paper/RJ4250WB-RD4x3.bin");
  static const RD_W4H4in = const Paper_RJ4250WB._internal("RJ4250WB-RD4x4", "CustomPaper/CustomRJ4250Paper/RJ4250WB-RD4x4.bin");
  static const RD_W4H6in = const Paper_RJ4250WB._internal("RJ4250WB-RD4x6", "CustomPaper/CustomRJ4250Paper/RJ4250WB-RD4x6.bin");
  static const RD_W50H85mm = const Paper_RJ4250WB._internal("RJ4250WB-RD50_85mm", "CustomPaper/CustomRJ4250Paper/RJ4250WB-RD50_85mm.bin");
  static const RD_W60H92mm = const Paper_RJ4250WB._internal("RJ4250WB-RD60_92mm", "CustomPaper/CustomRJ4250Paper/RJ4250WB-RD60_92mm.bin");
  static const RD_W80H115mm = const Paper_RJ4250WB._internal("RJ4250WB-RD80_115mm", "CustomPaper/CustomRJ4250Paper/RJ4250WB-RD80_115mm.bin");
  static const RD_W80mm = const Paper_RJ4250WB._internal("RJ4250WB-RD80mm", "CustomPaper/CustomRJ4250Paper/RJ4250WB-RD80mm.bin");

  @override
  Map<String, dynamic> toMap() {
    return {
      "name": _name,
      "assetPath": _assetPath
    };
  }

  
}