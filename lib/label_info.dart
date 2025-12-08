class LabelInfo {
  int labelNameIndex = -1;
  bool isAutoCut = true;
  bool isEndCut = true;
  bool isHalfCut = false;
  bool isSpecialTape = false;
  bool isCutMark = false;
  LabelColor labelColor;
  LabelColor labelFontColor;
  int labelType = -1;

  LabelInfo(
      {
      // TODO Consider using label ID instead
      this.labelNameIndex = -1,
      this.isAutoCut = true,
      this.isEndCut = true,
      this.isHalfCut = false,
      this.isSpecialTape = false,
      this.isCutMark = false,
      this.labelColor = LabelColor.UNSUPPORT,
      this.labelFontColor = LabelColor.UNSUPPORT,
      this.labelType = -1});

  static LabelInfo fromMap(Map<dynamic, dynamic> map) {
    return LabelInfo(
      labelNameIndex: map["labelNameIndex"],
      isAutoCut: map["isAutoCut"],
      isEndCut: map["isEndCut"],
      isHalfCut: map["isHalfCut"],
      isSpecialTape: map["isSpecialTape"],
      isCutMark: map["isCutMark"],
      labelColor: LabelColor.fromMap(map["labelColor"]),
      labelFontColor: LabelColor.fromMap(map["labelFontColor"]),
      labelType: map["labelType"],
    );
  }


  Map<String, dynamic> toMap() {
    return {
      "labelNameIndex": labelNameIndex,
      "isAutoCut": isAutoCut,
      "isEndCut" : isEndCut,
      "isHalfCut" : isHalfCut,
      "isSpecialTape" : isSpecialTape,
      "isCutMark" : isCutMark,
      "labelColor" : labelColor.toMap(),
      "labelFontColor": labelFontColor.toMap(),
      "labelType": labelType
    };
  }

  @override
  String toString() {
    return "{labelNameIndex $labelNameIndex, "
        "isAutoCut $isAutoCut, "
        "isEndCut $isEndCut, "
        "isHalfCut $isHalfCut, "
        "isSpecialTape  $isSpecialTape, "
        "isCutMark $isCutMark, "
        "labelColor $labelColor, "
        "labelFontColor $labelFontColor, "
        "labelType $labelType}";
  }
}

class LabelColor {
  final int _id;
  final String _name;

  const LabelColor._internal(this._id, this._name);

  static const WHITE = const LabelColor._internal(1, "WHITE");
  static const OTHERS = const LabelColor._internal(2, "OTHERS");
  static const CLEAR = const LabelColor._internal(3, "CLEAR");
  static const RED = const LabelColor._internal(4, "RED");
  static const BLUE = const LabelColor._internal(5, "BLUE");
  static const YELLOW = const LabelColor._internal(6, "YELLOW");
  static const GREEN = const LabelColor._internal(7, "GREEN");
  static const BLACK = const LabelColor._internal(8, "BLACK");
  static const CLEAR_WHITE = const LabelColor._internal(9, "CLEAR_WHITE");
  static const GOLD = const LabelColor._internal(10, "GOLD");
  static const GOLD_PREMIUM = const LabelColor._internal(11, "GOLD_PREMIUM");
  static const SILVER_PREMIUM = const LabelColor._internal(12, "SILVER_PREMIUM");
  static const OTHERS_PREMIUM = const LabelColor._internal(13, "OTHERS_PREMIUM");
  static const OTHERS_MASKING = const LabelColor._internal(14, "OTHERS_MASKING");
  static const LIGHTBLUE_SATIN = const LabelColor._internal(15, "LIGHTBLUE_SATIN");
  static const MINT_SATIN = const LabelColor._internal(16, "MINT_SATIN");
  static const SILVER_SATIN = const LabelColor._internal(17, "SILVER_SATIN");
  static const MATTE_WHITE = const LabelColor._internal(32, "MATTE_WHITE");
  static const MATTE_CLEAR = const LabelColor._internal(33, "MATTE_CLEAR");
  static const MATTE_SILVER = const LabelColor._internal(34, "MATTE_SILVER");
  static const SATIN_GOLD = const LabelColor._internal(35, "SATIN_GOLD");
  static const SATIN_SILVER = const LabelColor._internal(36, "SATIN_SILVER");
  static const BLUE_WHITE = const LabelColor._internal(48, "BLUE_WHITE");
  static const RED_WHITE = const LabelColor._internal(49, "RED_WHITE");
  static const FLUORESCENT_ORANGE = const LabelColor._internal(64, "FLUORESCENT_ORANGE");
  static const FLUORESCENT_YELLOW = const LabelColor._internal(65, "FLUORESCENT_YELLOW");
  static const BERRY_PINK = const LabelColor._internal(80, "BERRY_PINK");
  static const LIGHT_GRAY = const LabelColor._internal(81, "LIGHT_GRAY");
  static const LIME_GREEN = const LabelColor._internal(82, "LIME_GREEN");
  static const FABRIC_YELLOW = const LabelColor._internal(96, "FABRIC_YELLOW");
  static const FABRIC_PINK = const LabelColor._internal(97, "FABRIC_PINK");
  static const FABRIC_BLUE = const LabelColor._internal(98, "FABRIC_BLUE");
  static const TUBE_WHITE = const LabelColor._internal(112, "TUBE_WHITE");
  static const SELF_WHITE = const LabelColor._internal(128, "SELF_WHITE");
  static const FLEXIBLE_WHITE = const LabelColor._internal(144, "FLEXIBLE_WHITE");
  static const FLEXIBLE_YELLOW = const LabelColor._internal(145, "FLEXIBLE_YELLOW");
  static const CLEANING = const LabelColor._internal(240, "CLEANING");
  static const STENCIL = const LabelColor._internal(241, "STENCIL");
  static const PASTEL_PURPLE = const LabelColor._internal(37, "PASTEL_PURPLE");
  static const NAVY_BLUE = const LabelColor._internal(83, "NAVY_BLUE");
  static const WINE_RED = const LabelColor._internal(84, "WINE_RED");
  static const UNSUPPORT = const LabelColor._internal(255, "UNSUPPORT");

  static final _values = [
    WHITE,
    OTHERS,
    CLEAR,
    RED,
    BLUE,
    YELLOW,
    GREEN,
    BLACK,
    CLEAR_WHITE,
    GOLD,
    GOLD_PREMIUM,
    SILVER_PREMIUM,
    OTHERS_PREMIUM,
    OTHERS_MASKING,
    LIGHTBLUE_SATIN,
    MINT_SATIN,
    SILVER_SATIN,
    MATTE_WHITE,
    MATTE_CLEAR,
    MATTE_SILVER,
    SATIN_GOLD,
    SATIN_SILVER,
    BLUE_WHITE,
    RED_WHITE,
    FLUORESCENT_ORANGE,
    FLUORESCENT_YELLOW,
    BERRY_PINK,
    LIGHT_GRAY,
    LIME_GREEN,
    FABRIC_YELLOW,
    FABRIC_PINK,
    FABRIC_BLUE,
    TUBE_WHITE,
    SELF_WHITE,
    FLEXIBLE_WHITE,
    FLEXIBLE_YELLOW,
    CLEANING,
    STENCIL,
    PASTEL_PURPLE,
    NAVY_BLUE,
    WINE_RED,
    UNSUPPORT
  ];

  int getId() {
    return _id;
  }

  String getName() {
    return _name;
  }

  static int getItemId(index) {
    if (index < 0 || index > _values.length) {
      return UNSUPPORT.getId();
    }

    return _values[index].getId();
  }

  static LabelColor valueFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      LabelColor num = _values[i];
      if (num.getId() == id) {
        return num;
      }
    }
    return UNSUPPORT;
  }

  static LabelColor valueFromName(String name) {
    for (int i = 0; i < _values.length; ++i) {
      LabelColor num = _values[i];
      if (num.getName() == name) {
        return num;
      }
    }
    return UNSUPPORT;
  }

  static LabelColor fromMap(Map<dynamic, dynamic> map) {
    //int id = map["id"];
    String name = map["name"];
    return LabelColor.valueFromName(name);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": _id,
      "name": _name
    };
  }

  static List<LabelColor> getValues() => List.from(_values);

  @override
  String toString() {
    return _name;
  }
}

abstract class ALabelName {
  Map<String, dynamic> toMap();
  String getName();

}
class PT3 implements ALabelName {
  final int _id;
  final String _name;
  static const String _model = "PT3";

  const PT3._internal(this._id, this._name);

  static const W3_5 = PT3._internal(18, "W3_5");
  static const W6 = PT3._internal(19, "W6");
  static const W9 = PT3._internal(20, "W9");
  static const W12 = PT3._internal(11, "W12");
  static const UNSUPPORT = PT3._internal(255, "UNSUPPORT");

  static final _values = [W3_5, W6, W9, W12, UNSUPPORT];

  int getId() {
    return _id;
  }

  static int getItemId(index) {
    if (index < 0 || index > _values.length) {
      return UNSUPPORT.getId();
    }

    return _values[index].getId();
  }

  static PT3 valueFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      PT3 num = _values[i];
      if (num.getId() == id) {
        return num;
      }
    }
    return UNSUPPORT;
  }

  static int ordinalFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      PT3 num = _values[i];
      if (num.getId() == id) {
        return i;
      }
    }
    return -1;
  }

  static PT3 fromMap(Map<dynamic, dynamic> map) {
    int id = map["id"];
    return PT3.valueFromID(id);
  }

  static PT3 fromIndex (int index) {
    if (index < 0 ||index >= _values.length ) {
      return UNSUPPORT;
    }
    return _values[index];
  }

  Map<String, dynamic> toMap() {
    return {"id": _id,
      "name": _name,
      "model": _model
    };
  }

  static List<PT3> getValues() {
    return List.from(_values);
  }

  @override
  String getName() => _name;
}

class PT implements ALabelName {
  final int _id;
  final String _name;
  static const String _model = "PT";

  const PT._internal(this._id, this._name);

  static const W3_5 = const PT._internal(18, "W3_5");
  static const W6 = const PT._internal(19, "W6");
  static const W9 = const PT._internal(20, "W9");
  static const W12 = const PT._internal(11, "W12");
  static const W18 = const PT._internal(21, "W18");
  static const W24 = const PT._internal(22, "W24");
  static const HS_W6 = const PT._internal(23, "HS_W6");
  static const HS_W9 = const PT._internal(24, "HS_W9");
  static const HS_W12 = const PT._internal(25, "HS_W12");
  static const HS_W18 = const PT._internal(26, "HS_W18");
  static const HS_W24 = const PT._internal(27, "HS_W24");
  static const W36 = const PT._internal(28, "W36");
  static const R6_5 = const PT._internal(29, "R6_5");
  static const R6_0 = const PT._internal(31, "R6_0");
  static const R5_0 = const PT._internal(32, "R5_0");
  static const R4_0 = const PT._internal(33, "R4_0");
  static const R3_5 = const PT._internal(34, "R3_5");
  static const R3_0 = const PT._internal(35, "R3_0");
  static const R2_5 = const PT._internal(36, "R2_5");
  static const FLE_W21H45 = const PT._internal(37, "FLE_W21H45");
  static const UNSUPPORT = const PT._internal(255, "UNSUPPORT");

  static final _values = [
    W3_5,
    W6,
    W9,
    W12,
    W18,
    W24,
    HS_W6,
    HS_W9,
    HS_W12,
    HS_W18,
    HS_W24,
    W36,
    R6_5,
    R6_0,
    R5_0,
    R4_0,
    R3_5,
    R3_0,
    R2_5,
    FLE_W21H45,
    UNSUPPORT
  ];

  int getId() {
    return _id;
  }

  @override
  String getName() {
    return _name;
  }

  static int getItemId(index) {
    if (index < 0 || index > _values.length) {
      return UNSUPPORT.getId();
    }

    return _values[index].getId();
  }

  static PT valueFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      PT num = _values[i];
      if (num.getId() == id) {
        return num;
      }
    }
    return UNSUPPORT;
  }

  static int ordinalFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      PT num = _values[i];
      if (num.getId() == id) {
        return i;
      }
    }
    return -1;
  }

  static PT fromMap(Map<dynamic, dynamic> map) {
    int id = map["id"];
    return PT.valueFromID(id);
  }

  static PT fromIndex (int index) {
    if (index < 0 ||index >= _values.length ) {
      return UNSUPPORT;
    }
    return _values[index];
  }

  Map<String, dynamic> toMap() {
    return {"id": _id,
      "name": _name,
      "model": _model
    };
  }

  static List<PT> getValues() {
    return List.from(_values);
  }
}

class QL700 implements ALabelName {
  final int _id;
  final String _name;
  static const String _model = "QL700";

  const QL700._internal(this._id, this._name);

  static const W17H54 = const QL700._internal(1, "W17H54");
  static const W17H87 = const QL700._internal(2, "W17H87");
  static const W23H23 = const QL700._internal(3, "W23H23");
  static const W29H42 = const QL700._internal(4, "W29H42");
  static const W29H90 = const QL700._internal(5, "W29H90");
  static const W38H90 = const QL700._internal(6, "W38H90");
  static const W39H48 = const QL700._internal(7, "W39H48");
  static const W52H29 = const QL700._internal(8, "W52H29");
  static const W62H29 = const QL700._internal(9, "W62H29");
  static const W62H100 = const QL700._internal(10, "W62H100");
  static const W12 = const QL700._internal(11, "W12");
  static const W29 = const QL700._internal(12, "W29");
  static const W38 = const QL700._internal(13, "W38");
  static const W50 = const QL700._internal(14, "W50");
  static const W54 = const QL700._internal(15, "W54");
  static const W62 = const QL700._internal(16, "W62");
  static const W60H86 = const QL700._internal(17, "W60H86");
  static const W62RB = const QL700._internal(38, "W62RB");
  static const W54H29 = const QL700._internal(39, "W54H29");
  static const UNSUPPORT = const QL700._internal(255, "UNSUPPORT");

  static final _values = [
    W17H54,
    W17H87,
    W23H23,
    W29H42,
    W29H90,
    W38H90,
    W39H48,
    W52H29,
    W62H29,
    W62H100,
    W12,
    W29,
    W38,
    W50,
    W54,
    W62,
    W60H86,
    W62RB,
    W54H29,
    UNSUPPORT,
  ];

  int getId() {
    return _id;
  }

  @override
  String getName() {
    return _name;
  }

  static int getItemId(index) {
    if (index < 0 || index > _values.length) {
      return UNSUPPORT.getId();
    }

    return _values[index].getId();
  }

  static QL700 valueFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      QL700 num = _values[i];
      if (num.getId() == id) {
        return num;
      }
    }
    return UNSUPPORT;
  }

  static List<QL700> getValues() => List.from(_values);

  static int ordinalFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      QL700 num = _values[i];
      if (num.getId() == id) {
        return i;
      }
    }
    return -1;
  }

  static QL700 fromMap(Map<dynamic, dynamic> map) {
    int id = map["id"];
    return QL700.valueFromID(id);
  }

  static QL700 fromIndex (int index) {
    if (index < 0 ||index >= _values.length ) {
      return UNSUPPORT;
    }
    return _values[index];
  }

  Map<String, dynamic> toMap() {
    return {"id": _id,
      "name": _name,
      "model": _model
    };
  }
}

class QL1115 implements ALabelName {
  final int _id;
  final String _name;
  static const String _model = "QL1115";

  const QL1115._internal(this._id, this._name);

  static const W17H54 = const QL1115._internal(1, "W17H54");
  static const W17H87 = const QL1115._internal(2, "W17H87");
  static const W23H23 = const QL1115._internal(3, "W23H23");
  static const W29H42 = const QL1115._internal(4, "W29H42");
  static const W29H90 = const QL1115._internal(5, "W29H90");
  static const W38H90 = const QL1115._internal(6, "W38H90");
  static const W39H48 = const QL1115._internal(7, "W39H48");
  static const W52H29 = const QL1115._internal(8, "W52H29");
  static const W62H29 = const QL1115._internal(9, "W62H29");
  static const W62H100 = const QL1115._internal(10, "W62H100");
  static const W12 = const QL1115._internal(11, "W12");
  static const W29 = const QL1115._internal(12, "W29");
  static const W38 = const QL1115._internal(13, "W38");
  static const W50 = const QL1115._internal(14, "W50");
  static const W54 = const QL1115._internal(15, "W54");
  static const W62 = const QL1115._internal(16, "W62");
  static const W60H86 = const QL1115._internal(17, "W60H86");
  static const W102 = const QL1115._internal(40, "W102");
  static const W102H51 = const QL1115._internal(41, "W102H51");
  static const W102H152 = const QL1115._internal(48, "W102H152");
  static const W103 = const QL1115._internal(49, "W103");
  static const W103H164 = const QL1115._internal(50, "W103H164");
  static const DT_W90 = const QL1115._internal(51, "DT_W90");
  static const DT_W102 = const QL1115._internal(52, "DT_W102");
  static const DT_W102H51 = const QL1115._internal(53, "DT_W102H51");
  static const DT_W102H152 = const QL1115._internal(54, "DT_W102H152");
  static const UNSUPPORT = const QL1115._internal(255, "UNSUPPORT");

  static final _values = [
    W17H54,
    W17H87,
    W23H23,
    W29H42,
    W29H90,
    W38H90,
    W39H48,
    W52H29,
    W62H29,
    W62H100,
    W12,
    W29,
    W38,
    W50,
    W54,
    W62,
    W60H86,
    W102,
    W102H51,
    W102H152,
    W103,
    W103H164,
    DT_W90,
    DT_W102,
    DT_W102H51,
    DT_W102H152,
    UNSUPPORT
  ];

  @override
  String getName() => _name;

  int getId() {
    return _id;
  }

  static List<QL1115> getValues() => List.from(_values);

  static int getItemId(index) {
    if (index < 0 || index > _values.length) {
      return UNSUPPORT.getId();
    }

    return _values[index].getId();
  }

  static QL1115 valueFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      QL1115 num = _values[i];
      if (num.getId() == id) {
        return num;
      }
    }
    return UNSUPPORT;
  }

  static int ordinalFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      QL1115 num = _values[i];
      if (num.getId() == id) {
        return i;
      }
    }
    return -1;
  }

  static QL1115 fromMap(Map<dynamic, dynamic> map) {
    int id = map["id"];
    return QL1115.valueFromID(id);
  }

  Map<String, dynamic> toMap() {
    return {"id": _id,
    "name": _name,
      "model": _model
    };
  }

  static QL1115 fromIndex (int index) {
    if (index < 0 ||index >= _values.length ) {
      return UNSUPPORT;
    }

    return _values[index];
  }
}

class QL1100 implements ALabelName {
  final _id;
  final String _name;
  static const String _model = "QL1100";

  const QL1100._internal(this._id, this._name);

  static const W17H54 = const QL1100._internal(1, "W17H54");
  static const W17H87 = const QL1100._internal(2, "W17H87");
  static const W23H23 = const QL1100._internal(3, "W23H23");
  static const W29H42 = const QL1100._internal(4, "W29H42");
  static const W29H90 = const QL1100._internal(5, "W29H90");
  static const W38H90 = const QL1100._internal(6, "W38H90");
  static const W39H48 = const QL1100._internal(7, "W39H48");
  static const W52H29 = const QL1100._internal(8, "W52H29");
  static const W62H29 = const QL1100._internal(9, "W62H29");
  static const W62H100 = const QL1100._internal(10, "W62H100");
  static const W12 = const QL1100._internal(11, "W12");
  static const W29 = const QL1100._internal(12, "W29");
  static const W38 = const QL1100._internal(13, "W38");
  static const W50 = const QL1100._internal(14, "W50");
  static const W54 = const QL1100._internal(15, "W54");
  static const W62 = const QL1100._internal(16, "W62");
  static const W60H86 = const QL1100._internal(17, "W60H86");
  static const W102 = const QL1100._internal(40, "W102");
  static const W102H51 = const QL1100._internal(41, "W102H51");
  static const W102H152 = const QL1100._internal(48, "W102H152");
  static const W103 = const QL1100._internal(49, "W103");
  static const W103H164 = const QL1100._internal(50, "W103H164");
  static const UNSUPPORT = const QL1100._internal(255, "UNSUPPORT");

  static final List<QL1100> _values = [
    W17H54,
    W17H87,
    W23H23,
    W29H42,
    W29H90,
    W38H90,
    W39H48,
    W52H29,
    W62H29,
    W62H100,
    W12,
    W29,
    W38,
    W50,
    W54,
    W62,
    W60H86,
    W102,
    W102H51,
    W102H152,
    W103,
    W103H164,
    UNSUPPORT
  ];

  int getId() {
    return _id;
  }

  @override
  String getName() {
    return _name;
  }

  static List<QL1100> getValues() => List.from(_values);

  static int getItemId(index) {
    if (index < 0 || index > _values.length) {
      return UNSUPPORT.getId();
    }

    return _values[index].getId();
  }

  static QL1100 valueFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      QL1100 num = _values[i];
      if (num.getId() == id) {
        return num;
      }
    }
    return UNSUPPORT;
  }

  static int ordinalFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      QL1100 num = _values[i];
      if (num.getId() == id) {
        return i;
      }
    }
    return -1;
  }

  static QL1100 fromMap(Map<dynamic, dynamic> map) {
    int id = map["id"];
    return QL1100.valueFromID(id);
  }

  static QL1100 fromIndex (int index) {
    if (index < 0 ||index >= _values.length ) {
      return UNSUPPORT;
    }

    return _values[index];
  }

  Map<String, dynamic> toMap() {
    return {"id": _id,
      "name": _name,
      "model": _model
    };
  }
}
