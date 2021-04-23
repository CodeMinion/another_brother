
abstract class ACustomPaper {
  Map<String, dynamic> toMap();

}

class BinPaper_RJ2050 implements ACustomPaper {
  final String _name;
  final String _assetPath;

  static const String _rootDir = "packages/another_brother/custom_paper/CustomRJ2050Paper";
  const BinPaper_RJ2050._internal(this._name, this._assetPath);

  static const RD_W50mm = const BinPaper_RJ2050._internal("RJ2050-RD50mm", "$_rootDir/RJ2050-RD50mm.bin");
  static const RD_W58mm = const BinPaper_RJ2050._internal("RJ2050-RD58mm", "$_rootDir/RJ2050-RD58mm.bin");

  @override
  Map<String, dynamic> toMap() {
    return {
      "name": _name,
      "assetPath": _assetPath
    };
  }

}

class BinPaper_RJ2150 implements ACustomPaper {
  final String _name;
  final String _assetPath;

  static const String _rootDir = "packages/another_brother/custom_paper/CustomRJ2150Paper";
  const BinPaper_RJ2150._internal(this._name, this._assetPath);

  static const RD_W2H4in = const BinPaper_RJ2150._internal("RJ2150-2x4inch", "$_rootDir/RJ2150-2x4inch.bin");
  static const RD_W1_9H3_3in = const BinPaper_RJ2150._internal("RJ2150-RD1.9x3.3inch", "$_rootDir/RJ2150-RD1.9x3.3inch.bin");
  static const RD_W50mm = const BinPaper_RJ2150._internal("RJ2150-RD50mm", "$_rootDir/RJ2150-RD50mm.bin");
  static const RD_W50H85mm = const BinPaper_RJ2150._internal("RJ2150-RD50x85mm", "$_rootDir/RJ2150-RD50x85mm.bin");
  static const RD_W58mm = const BinPaper_RJ2150._internal("RJ2150-RD58mm", "$_rootDir/RJ2150-RD58mm.bin");
  static const RD_W2H1in = const BinPaper_RJ2150._internal("RJ2150_20ix10i", "$_rootDir/RJ2150_20ix10i.bin");
  static const RD_W2_1H1_5in = const BinPaper_RJ2150._internal("RJ2150_21ix15i", "$_rootDir/RJ2150_21ix15i.bin");

  @override
  Map<String, dynamic> toMap() {
    return {
      "name": _name,
      "assetPath": _assetPath
    };
  }

}

class BinPaper_RJ3050Ai implements ACustomPaper {
  final String _name;
  final String _assetPath;

  static const String _rootDir = "packages/another_brother/custom_paper/CustomRJ3050AiPaper";
  const BinPaper_RJ3050Ai._internal(this._name, this._assetPath);

  static const RD_W76mm = const BinPaper_RJ3050Ai._internal("RJ3050Ai-RD76mm", "$_rootDir/RJ3050Ai-RD76mm.bin");
  static const RD_W2_2in = const BinPaper_RJ3050Ai._internal("RJ-3050Ai_RD2.2Continuous", "$_rootDir/RJ-3050Ai_RD2.2Continuous.bin");
  static const RD_W50mm = const BinPaper_RJ3050Ai._internal("RJ-3050Ai_RD50mmContinuous", "$_rootDir/RJ-3050Ai_RD50mmContinuous.bin");
  static const RD_W58mm = const BinPaper_RJ3050Ai._internal("RJ-3050Ai_RD58mmContinuous", "$_rootDir/RJ-3050Ai_RD58mmContinuous.bin");
  static const RD_W80mm = const BinPaper_RJ3050Ai._internal("RJ-3050Ai_RD80mmContinuous", "$_rootDir/RJ-3050Ai_RD80mmContinuous.bin");

  @override
  Map<String, dynamic> toMap() {
    return {
      "name": _name,
      "assetPath": _assetPath
    };
  }

}

class BinPaper_RJ3050 implements ACustomPaper {
  final String _name;
  final String _assetPath;

  static const String _rootDir = "packages/another_brother/custom_paper/CustomRJ3050Paper";
  const BinPaper_RJ3050._internal(this._name, this._assetPath);

  static const RD_W1_9in = const BinPaper_RJ3050._internal("RJ3050-RD1.90inch", "$_rootDir/RJ3050-RD1.90inch.bin");
  static const RD_W2in = const BinPaper_RJ3050._internal("RJ3050-RD2.00inch", "$_rootDir/RJ3050-RD2.00inch.bin");
  static const RD_W3in = const BinPaper_RJ3050._internal("RJ3050-RD3.00inch", "$_rootDir/RJ3050-RD3.00inch.bin");
  static const RD_W3_15in = const BinPaper_RJ3050._internal("RJ3050-RD3.15inch", "$_rootDir/RJ3050-RD3.15inch.bin");

  @override
  Map<String, dynamic> toMap() {
    return {
      "name": _name,
      "assetPath": _assetPath
    };
  }

}

class BinPaper_RJ3150Ai implements ACustomPaper {
  final String _name;
  final String _assetPath;

  static const String _rootDir = "packages/another_brother/custom_paper/CustomRJ3150AiPaper";
  const BinPaper_RJ3150Ai._internal(this._name, this._assetPath);

  static const RD_W76mm = const BinPaper_RJ3150Ai._internal("RJ3150Ai-RD76mm", "$_rootDir/RJ3150Ai-RD76mm.bin");
  static const RD_W76H44mm = const BinPaper_RJ3150Ai._internal("RJ3150Ai-RD76mm44mm", "$_rootDir/RJ3150Ai-RD76mm44mm.bin");
  static const RD_W2_2in = const BinPaper_RJ3150Ai._internal("RJ-3150Ai_RD2.2Continuous", "$_rootDir/RJ-3150Ai_RD2.2Continuous.bin");
  static const RD_W50mm = const BinPaper_RJ3150Ai._internal("RJ-3150Ai_RD50mmContinuous", "$_rootDir/RJ-3150Ai_RD50mmContinuous.bin");
  static const RD_W58mm = const BinPaper_RJ3150Ai._internal("RJ-3150Ai_RD58mmContinuous", "$_rootDir/RJ-3150Ai_RD58mmContinuous.bin");
  static const RD_W80mm = const BinPaper_RJ3150Ai._internal("RJ-3150Ai_RD80mmContinuous", "$_rootDir/RJ-3150Ai_RD80mmContinuous.bin");

  @override
  Map<String, dynamic> toMap() {
    return {
      "name": _name,
      "assetPath": _assetPath
    };
  }

}

class BinPaper_RJ3150 implements ACustomPaper {
  final String _name;
  final String _assetPath;

  static const String _rootDir = "packages/another_brother/custom_paper/CustomRJ3150Paper";
  const BinPaper_RJ3150._internal(this._name, this._assetPath);

  static const RD_W1H1in = const BinPaper_RJ3150._internal("RJ3150-RD1.0x1.0[1]", "$_rootDir/RJ3150-RD1.0x1.0[1].bin");
  static const RD_W1_9in = const BinPaper_RJ3150._internal("RJ3150-RD1.9inch", "$_rootDir/RJ3150-RD1.9inch.bin");
  static const RD_W1_9H3_3in = const BinPaper_RJ3150._internal("RJ3150-RD1.9x3.3", "$_rootDir/RJ3150-RD1.9x3.3.bin");
  static const RD_W2in = const BinPaper_RJ3150._internal("RJ3150-RD2.0inch", "$_rootDir/RJ3150-RD2.0inch.bin");
  static const RD_W2H1in = const BinPaper_RJ3150._internal("RJ3150-RD2.0x1.0[1]", "$_rootDir/RJ3150-RD2.0x1.0[1].bin");
  static const RD_W2_3H3_6in = const BinPaper_RJ3150._internal("RJ3150-RD2.3x3.6", "$_rootDir/RJ3150-RD2.3x3.6.bin");
  static const RD_W3in = const BinPaper_RJ3150._internal("RJ3150-RD3.0inch", "$_rootDir/RJ3150-RD3.0inch.bin");
  static const RD_W3H1in = const BinPaper_RJ3150._internal("RJ3150-RD3.0x1.0[1]", "$_rootDir/RJ3150-RD3.0x1.0[1].bin");
  static const RD_W3H1_75mm = const BinPaper_RJ3150._internal("RJ3150-RD3.0x1.75", "$_rootDir/RJ3150-RD3.0x1.75.bin");
  static const RD_W3_15in = const BinPaper_RJ3150._internal("RJ3150-RD3.15inch", "$_rootDir/RJ3150-RD3.15inch.bin");
  static const RD_W50H85mm = const BinPaper_RJ3150._internal("RJ3150-RD50_85mm", "$_rootDir/RJ3150-RD50_85mm.bin");
  static const RD_W60H92mm = const BinPaper_RJ3150._internal("RJ3150-RD60_92mm", "$_rootDir/RJ3150-RD60_92mm.bin");
  static const RD_W76H44mm = const BinPaper_RJ3150._internal("RJ3150-RD76_44mm", "$_rootDir/RJ3150-RD76_44mm.bin");

  @override
  Map<String, dynamic> toMap() {
    return {
      "name": _name,
      "assetPath": _assetPath
    };
  }

}

class BinPaper_RJ4250WB implements ACustomPaper {
  final String _name;
  final String _assetPath;

  static const String _rootDir = "packages/another_brother/custom_paper/CustomRJ4250Paper";
  const BinPaper_RJ4250WB._internal(this._name, this._assetPath);

  static const RD_W1_9H3_3in = const BinPaper_RJ4250WB._internal("RJ4250WB-RD1.9x3.3", "$_rootDir/RJ4250WB-RD1.9x3.3.bin");
  static const RD_W2_2in = const BinPaper_RJ4250WB._internal("RJ4250WB-RD2.2inch", "$_rootDir/RJ4250WB-RD2.2inch.bin");
  static const RD_W2_3H3_6in = const BinPaper_RJ4250WB._internal("RJ4250WB-RD2.3x3.6", "$_rootDir/RJ4250WB-RD2.3x3.6.bin");
  static const RD_W3_1H4_5in = const BinPaper_RJ4250WB._internal("RJ4250WB-RD3.1x4.5", "$_rootDir/RJ4250WB-RD3.1x4.5.bin");
  static const RD_W4in = const BinPaper_RJ4250WB._internal("RJ4250WB-RD4inch", "$_rootDir/RJ4250WB-RD4inch.bin");
  static const RD_W4H1in = const BinPaper_RJ4250WB._internal("RJ4250WB-RD4x1", "$_rootDir/RJ4250WB-RD4x1.bin");
  static const RD_W4H2in = const BinPaper_RJ4250WB._internal("RJ4250WB-RD4x2", "$_rootDir/RJ4250WB-RD4x2.bin");
  static const RD_W4H3in = const BinPaper_RJ4250WB._internal("RJ4250WB-RD4x3", "$_rootDir/RJ4250WB-RD4x3.bin");
  static const RD_W4H4in = const BinPaper_RJ4250WB._internal("RJ4250WB-RD4x4", "$_rootDir/RJ4250WB-RD4x4.bin");
  static const RD_W4H6in = const BinPaper_RJ4250WB._internal("RJ4250WB-RD4x6", "$_rootDir/RJ4250WB-RD4x6.bin");
  static const RD_W50H85mm = const BinPaper_RJ4250WB._internal("RJ4250WB-RD50_85mm", "$_rootDir/RJ4250WB-RD50_85mm.bin");
  static const RD_W60H92mm = const BinPaper_RJ4250WB._internal("RJ4250WB-RD60_92mm", "$_rootDir/RJ4250WB-RD60_92mm.bin");
  static const RD_W80H115mm = const BinPaper_RJ4250WB._internal("RJ4250WB-RD80_115mm", "$_rootDir/RJ4250WB-RD80_115mm.bin");
  static const RD_W80mm = const BinPaper_RJ4250WB._internal("RJ4250WB-RD80mm", "$_rootDir/RJ4250WB-RD80mm.bin");

  @override
  Map<String, dynamic> toMap() {
    return {
      "name": _name,
      "assetPath": _assetPath
    };
  }
}