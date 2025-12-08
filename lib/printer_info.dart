import 'dart:io';
import 'dart:ui';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import 'custom_paper.dart';
import "label_info.dart";
import 'bluetooth_preference.dart';

class PaperSize implements ALabelName {
  final int _id;
  final String _name;

  const PaperSize._internal(this._id, this._name);

  static const CUSTOM = PaperSize._internal(254, "CUSTOM");
  static const A7 = const PaperSize._internal(6, "A7");
  static const A6 = PaperSize._internal(7, "A6");
  static const A4 = PaperSize._internal(1, "A4");
  static const A5 = PaperSize._internal(2, "A5");
  static const A5_LANDSCAPE = PaperSize._internal(3, "A5_LANDSCAPE");
  static const LETTER = PaperSize._internal(4, "LETTER");
  static const LEGAL = PaperSize._internal(5, "LEGAL");

  static final _values = [CUSTOM, A7, A6, A4, A5, A5_LANDSCAPE, LETTER, LEGAL];

  int getPaperId() {
    return _id;
  }

  String getName() {
    return _name;
  }

  List<PaperSize> getValues() => List.of(_values);

  static int getItemId(index) {
    if (index < 0 || index > _values.length) {
      return CUSTOM.getPaperId();
    }

    return _values[index].getPaperId();
  }

  static PaperSize valueFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      PaperSize num = _values[i];
      if (num.getPaperId() == id) {
        return num;
      }
    }
    return CUSTOM;
  }

  static PaperSize fromMap(Map<dynamic, dynamic> map) {
    int id = map["id"];
    //String name = map["name"];
    return PaperSize.valueFromID(id);
  }

  Map<String, dynamic> toMap() {
    return {"id": this._id, "name": this._name};
  }
}

abstract class AModel {
  String getDisplayName();
  String getName();
}

class Model implements AModel {
  final int _defaultPaper;
  final int _id;
  final PrinterSeries _series;
  final String _name;

  const Model._internal(this._name, this._id, this._defaultPaper, this._series);

  Model._internal2(this._name, this._id, Model alias)
      : _defaultPaper = alias._defaultPaper,
        _series = alias._series;

  //const Model.model(this._id, Model alias): _defaultPaper = 0, _series = MW_140BT

  static final MW_140BT = Model._internal(
      "MW_140BT", 0, PaperSize.A7.getPaperId(), PrinterSeries.MOBILE_PRINTER);
  static final MW_145BT = Model._internal2("MW_145BT", 1, MW_140BT);
  static final MW_260 = Model._internal(
      "MW_260", 2, PaperSize.A6.getPaperId(), PrinterSeries.MOBILE_PRINTER);
  static final PJ_522 = Model._internal(
      "PJ_522", 3, PaperSize.A4.getPaperId(), PrinterSeries.MOBILE_PRINTER);
  static final PJ_523 = Model._internal2("PJ_523", 4, PJ_522);
  static final PJ_520 = Model._internal2("PJ_520", 5, PJ_522);
  static final PJ_560 = Model._internal2("PJ_560", 6, PJ_522);
  static final PJ_562 = Model._internal2("PJ_562", 7, PJ_522);
  static final PJ_563 = Model._internal2("PJ_563", 8, PJ_522);
  static final PJ_622 = Model._internal2("PJ_622", 9, PJ_522);
  static final PJ_623 = Model._internal2("PJ_623", 10, PJ_522);
  static final PJ_662 = Model._internal2("PJ_662", 11, PJ_522);
  static final PJ_663 = Model._internal2("PJ_663", 12, PJ_522);
  static final RJ_4030 = Model._internal("RJ_4030", 13,
      PaperSize.CUSTOM.getPaperId(), PrinterSeries.CUSTOM_PAPER_PRINTER);
  static final RJ_4040 = Model._internal2("RJ_4040", 14, RJ_4030);
  static final RJ_3150 = Model._internal2("RJ_3150", 15, RJ_4030);
  static final RJ_3050 = Model._internal2("RJ_3050", 16, RJ_4030);
  static final QL_580N = Model._internal(
      "QL_580N", 17, QL700.W38.getId(), PrinterSeries.QL700_LABEL_PRINTER);
  static final QL_710W = Model._internal2("QL_710W", 18, QL_580N);
  static final QL_720NW = Model._internal2("QL_720NW", 19, QL_580N);
  static final TD_2020 = Model._internal2("TD_2020", 20, RJ_4030);
  static final TD_2120N = Model._internal2("TD_2120N", 21, RJ_4030);
  static final TD_2130N = Model._internal2("TD_2130N", 22, RJ_4030);
  static final PT_E550W = Model._internal(
      "PT_E550W", 23, PT.W24.getId(), PrinterSeries.PT_LABEL_PRINTER);
  static final PT_P750W = Model._internal2("PT_P750W", 24, PT_E550W);
  static final TD_4100N = Model._internal2("TD_4100N", 25, RJ_4030);
  static final TD_4000 = Model._internal2("TD_4000", 26, RJ_4030);
  static final PJ_762 = Model._internal2("PJ_762", 27, PJ_522);
  static final PJ_763 = Model._internal2("PJ_763", 28, PJ_522);
  static final PJ_773 = Model._internal2("PJ_773", 29, PJ_522);
  static final PJ_722 = Model._internal2("PJ_722", 30, PJ_522);
  static final PJ_723 = Model._internal2("PJ_723", 31, PJ_522);
  static final PJ_763MFi = Model._internal2("PJ_763MFi", 32, PJ_522);
  static final MW_145MFi = Model._internal2("MW_145MFi", 34, MW_140BT);
  static final MW_260MFi = Model._internal2("MW_260MFi", 35, MW_140BT);
  static final PT_P300BT = Model._internal(
      "PT_P300BT", 36, PT3.W12.getId(), PrinterSeries.PT3_LABEL_PRINTER);
  static final PT_E850TKW = Model._internal(
      "PT_E850TKW", 37, PT.W36.getId(), PrinterSeries.PT_LABEL_PRINTER);
  static final PT_D800W = Model._internal2("PT_D800W", 38, PT_E850TKW);
  static final PT_P900W = Model._internal2("PT_P900W", 39, PT_E850TKW);
  static final PT_P950NW = Model._internal2("PT_P950NW", 40, PT_E850TKW);
  static final RJ_4030Ai = Model._internal2("RJ_4030Ai", 41, RJ_4030);
  static final PT_E800W = Model._internal2("PT_E800W", 42, PT_E850TKW);
  static final RJ_2030 = Model._internal2("RJ_2030", 45, RJ_4030);
  static final RJ_2050 = Model._internal2("RJ_2050", 46, RJ_4030);
  static final RJ_2140 = Model._internal2("RJ_2140", 47, RJ_4030);
  static final RJ_2150 = Model._internal2("RJ_2150", 48, RJ_4030);
  static final RJ_3050Ai = Model._internal2("RJ_3050Ai", 49, RJ_4030);
  static final RJ_3150Ai = Model._internal2("RJ_3150Ai", 50, RJ_4030);
  static final QL_800 = Model._internal2("QL_800", 51, QL_580N);
  static final QL_810W = Model._internal2("QL_810W", 52, QL_580N);
  static final QL_820NWB = Model._internal2("QL_820NWB", 53, QL_580N);
  static final QL_820NWBc = Model._internal2("QL_820NWBc", 53, QL_580N);
  static final QL_1100 = Model._internal(
      "QL_1100", 54, QL1100.W38.getId(), PrinterSeries.QL1100_LABEL_PRINTER);
  static final QL_1110NWB = Model._internal2("QL_1110NWB", 55, QL_1100);
  static final QL_1115NWB = Model._internal(
      "QL_1115NWB", 56, QL1115.W38.getId(), PrinterSeries.QL1115_LABEL_PRINTER);
  static final PT_P710BT = Model._internal2("PT_P710BT", 57, PT_E550W);
  static final PT_E500 = Model._internal(
      "PT_E500", 58, PT.W24.getId(), PrinterSeries.PT_LABEL_PRINTER);
  static final RJ_4230B = Model._internal2("RJ_4230B", 59, RJ_4030);
  static final RJ_4250WB = Model._internal2("RJ_4250WB", 60, RJ_4030);
  static final TD_4410D = Model._internal2("TD_4410D", 61, TD_4100N);
  static final TD_4420DN = Model._internal2("TD_4420DN", 62, TD_4410D);
  static final TD_4510D = Model._internal2("TD_4510D", 63, TD_4410D);
  static final TD_4520DN = Model._internal2("TD_4520DN", 64, TD_4410D);
  static final TD_4550DNWB = Model._internal2("TD_4550DNWB", 65, TD_4410D);
  static final MW_170 = Model._internal2("MW_170", 66, MW_140BT);
  static final MW_270 = Model._internal2("MW_270", 67, MW_260);
  static final PT_P715eBT = Model._internal2("PT_P715eBT", 69, PT_E550W);
  static final PT_P910BT = Model._internal(
      "PT_P910BT", 68, PT.W36.getId(), PrinterSeries.PT_LABEL_PRINTER);
  static final RJ_3230B = Model._internal2("RJ_3230B", 70, RJ_4030);
  static final RJ_3250WB = Model._internal2("RJ_3250WB", 71, RJ_4030);
  static final PT_D410 = Model._internal(
      "PT_D410", 72, PT.W18.getId(), PrinterSeries.PT_LABEL_PRINTER);
  static final PT_D460BT = Model._internal2("PT_D460BT", 73, PT_D410);
  static final PT_D610BT = Model._internal(
      "PT_D610BT", 74, PT.W24.getId(), PrinterSeries.PT_LABEL_PRINTER);
  static final PJ_822 = Model._internal2("PJ_822", 75, PJ_522);
  static final PJ_823 = Model._internal2("PJ_823", 76, PJ_522);
  static final PJ_862 = Model._internal2("PJ_862", 77, PJ_522);
  static final PJ_863 = Model._internal2("PJ_863", 78, PJ_522);
  static final PJ_883 = Model._internal2("PJ_883", 79, PJ_522);
  static final TD_2030A = Model._internal2("TD_2030A", 80, RJ_4030);
  static final TD_2125N = Model._internal2("TD_2125N", 81, RJ_4030);
  static final TD_2125NWB = Model._internal2("TD_2125NWB", 82, RJ_4030);
  static final TD_2135N = Model._internal2("TD_2135N", 83, RJ_4030);
  static final TD_2135NWB = Model._internal2("TD_2135NWB", 84, RJ_4030);
  static final TD_2350D_203 = Model._internal2("TD_2350D", 97, RJ_4030);
  static final TD_2350D_300 = Model._internal2("TD_2350D", 98, RJ_4030);
  static final TD_2350DF_203 = Model._internal2("TD_2350D", 99, RJ_4030);
  static final TD_2350DF_300 = Model._internal2("TD_2350D", 100, RJ_4030);
  static final TD_2350DSA_203 = Model._internal2("TD_2350D", 101, RJ_4030);
  static final TD_2350DSA_300 = Model._internal2("TD_2350D", 102, RJ_4030);
  static final TD_2350DFSA_203 = Model._internal2("TD_2350D", 103, RJ_4030);
  static final TD_2350DFSA_300 = Model._internal2("TD_2350D", 104, RJ_4030);

  static final UNSUPPORTED = Model._internal("UNSUPPORTED", 255,
      PaperSize.CUSTOM.getPaperId(), PrinterSeries.UNSUPPORTED);

  static final _values = [
    MW_140BT,
    MW_145BT,
    MW_260,
    PJ_522,
    PJ_523,
    PJ_520,
    PJ_560,
    PJ_562,
    PJ_563,
    PJ_622,
    PJ_623,
    PJ_662,
    PJ_663,
    RJ_4030,
    RJ_4040,
    RJ_3150,
    RJ_3050,
    QL_580N,
    QL_710W,
    QL_720NW,
    TD_2020,
    TD_2120N,
    TD_2130N,
    PT_E550W,
    PT_P750W,
    TD_4100N,
    TD_4000,
    PJ_762,
    PJ_763,
    PJ_773,
    PJ_722,
    PJ_723,
    PJ_763MFi,
    MW_145MFi,
    MW_260MFi,
    PT_P300BT,
    PT_E850TKW,
    PT_D800W,
    PT_P900W,
    PT_P950NW,
    RJ_4030Ai,
    PT_E800W,
    RJ_2030,
    RJ_2050,
    RJ_2140,
    RJ_2150,
    RJ_3050Ai,
    RJ_3150Ai,
    QL_800,
    QL_810W,
    QL_820NWB,
    QL_820NWBc,
    QL_1100,
    QL_1110NWB,
    QL_1115NWB,
    PT_P710BT,
    PT_E500,
    RJ_4230B,
    RJ_4250WB,
    TD_4410D,
    TD_4420DN,
    TD_4510D,
    TD_4520DN,
    TD_4550DNWB,
    MW_170,
    MW_270,
    PT_P715eBT,
    PT_P910BT,
    RJ_3230B,
    RJ_3250WB,
    PT_D410,
    PT_D460BT,
    PT_D610BT,
    PJ_822,
    PJ_823,
    PJ_862,
    PJ_863,
    PJ_883,
    TD_2030A,
    TD_2125N,
    TD_2125NWB,
    TD_2135N,
    TD_2135NWB,
    TD_2350D_203,
    TD_2350D_300,
    TD_2350DF_203,
    TD_2350DF_300,
    TD_2350DSA_203,
    TD_2350DSA_300,
    TD_2350DFSA_203,
    TD_2350DFSA_300,
    UNSUPPORTED
  ];

  int getId() {
    return _id;
  }

  static int getItemId(index) {
    if (index < 0 || index > _values.length) {
      return UNSUPPORTED.getId();
    }

    return _values[index].getId();
  }

  static Model valueFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      Model num = _values[i];
      if (num.getId() == id) {
        return num;
      }
    }
    return UNSUPPORTED;
  }

  int getDefaultPaper() {
    return this._defaultPaper;
  }

  bool customPaperPrinter() {
    return this._series == PrinterSeries.CUSTOM_PAPER_PRINTER;
  }

  bool labelPrinter() {
    return this._series == PrinterSeries.PT3_LABEL_PRINTER ||
        this._series == PrinterSeries.PT_LABEL_PRINTER ||
        this._series == PrinterSeries.QL1100_LABEL_PRINTER ||
        this._series == PrinterSeries.QL1115_LABEL_PRINTER ||
        this._series == PrinterSeries.QL700_LABEL_PRINTER;
  }

  int getLabelID(int index) {
    if (this._series == PrinterSeries.PT3_LABEL_PRINTER) {
      return PT3.getItemId(index);
    } else if (this._series == PrinterSeries.PT_LABEL_PRINTER) {
      return PT.getItemId(index);
    } else if (this._series == PrinterSeries.QL700_LABEL_PRINTER) {
      return QL700.getItemId(index);
    } else if (this._series == PrinterSeries.QL1100_LABEL_PRINTER) {
      return QL1100.getItemId(index);
    } else {
      return this._series == PrinterSeries.QL1115_LABEL_PRINTER
          ? QL1115.getItemId(index)
          : 255;
    }
  }

  int getLabelOrder(int index) {
    if (this._series == PrinterSeries.PT3_LABEL_PRINTER) {
      return PT3.ordinalFromID(index); //PT3.valueFromID(index).ordinal();
    } else if (this._series == PrinterSeries.PT_LABEL_PRINTER) {
      return PT.ordinalFromID(index); //PT.valueFromID(index).ordinal();
    } else if (this._series == PrinterSeries.QL700_LABEL_PRINTER) {
      return QL700.ordinalFromID(index); //QL700.valueFromID(index).ordinal();
    } else if (this._series == PrinterSeries.QL1100_LABEL_PRINTER) {
      return QL1100.ordinalFromID(index); //QL1100.valueFromID(index).ordinal();
    } else {
      return this._series == PrinterSeries.QL1115_LABEL_PRINTER
          ? QL1115.ordinalFromID(index)
          : 255;
    }
  }

  ALabelName getLabelName(int index) {
    if (this._series == PrinterSeries.PT3_LABEL_PRINTER) {
      return PT3.fromIndex(index);
    } else if (this._series == PrinterSeries.PT_LABEL_PRINTER) {
      return PT.fromIndex(index);
    } else if (this._series == PrinterSeries.QL700_LABEL_PRINTER) {
      return QL700.fromIndex(index);
    } else if (this._series == PrinterSeries.QL1100_LABEL_PRINTER) {
      return QL1100.fromIndex(index);
    } else {
      return this._series == PrinterSeries.QL1115_LABEL_PRINTER
          ? QL1115.fromIndex(index)
          : QL700.UNSUPPORT;
    }
  }

  String getName() {
    return this._name.replaceAll("_", "-");
  }

  static Model fromMap(Map<dynamic, dynamic> map) {
    int id = map["id"];
    //String name = map["name"];
    return Model.valueFromID(id);
  }

  Map<String, dynamic> toMap() {
    return {"id": _id, "name": _name};
  }

  static List<Model> getValues() => List.of(_values);

  @override
  String getDisplayName() => getName();
}

class PrinterSeries {
  final int _id;

  const PrinterSeries._internal(this._id);

  static const CUSTOM_PAPER_PRINTER = PrinterSeries._internal(1);
  static const PT_LABEL_PRINTER = PrinterSeries._internal(2);
  static const PT3_LABEL_PRINTER = PrinterSeries._internal(3);
  static const QL700_LABEL_PRINTER = PrinterSeries._internal(4);
  static const QL1100_LABEL_PRINTER = PrinterSeries._internal(5);
  static const QL1115_LABEL_PRINTER = PrinterSeries._internal(6);
  static const MOBILE_PRINTER = PrinterSeries._internal(7);
  static const UNSUPPORTED = PrinterSeries._internal(8);

  static final List<PrinterSeries> _values = [
    CUSTOM_PAPER_PRINTER,
    PT_LABEL_PRINTER,
    PT3_LABEL_PRINTER,
    QL700_LABEL_PRINTER,
    QL1100_LABEL_PRINTER,
    QL1115_LABEL_PRINTER,
    MOBILE_PRINTER,
    UNSUPPORTED
  ];

  int getId() {
    return this._id;
  }

  static PrinterSeries valueFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      PrinterSeries num = _values[i];
      if (num.getId() == id) {
        return num;
      }
    }
    return UNSUPPORTED;
  }

  static PrinterSeries fromMap(Map<dynamic, dynamic> map) {
    int id = map["id"];
    return PrinterSeries.valueFromID(id);
  }

  Map<String, dynamic> toMap() {
    return {"id": this._id};
  }
}

class Port {
  final int _id;
  final String _name;

  const Port._internal(this._id, this._name);

  static const USB = Port._internal(1, "USB");
  static const BLUETOOTH = Port._internal(2, "BLUETOOTH");
  static const NET = Port._internal(4, "NET");
  static const BLE = Port._internal(8, "BLE");
  static const FILE = Port._internal(255, "FILE");

  static final _values = [USB, BLUETOOTH, NET, BLE, FILE];

  int getId() {
    return _id;
  }

  String getName() {
    return _name;
  }

  static Port valueFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      Port num = _values[i];
      if (num.getId() == id) {
        return num;
      }
    }
    return USB;
  }

  static Port fromMap(Map<dynamic, dynamic> map) {
    int id = map["id"];
    //String name = map["name"];
    return Port.valueFromID(id);
  }

  Map<String, dynamic> toMap() {
    return {"id": _id, "name": _name};
  }
}

class Orientation {
  final int _id;
  final String _name;

  const Orientation._internal(this._id, this._name);

  static const PORTRAIT = const Orientation._internal(1, "PORTRAIT");
  static const LANDSCAPE = const Orientation._internal(2, "LANDSCAPE");

  static final _values = [PORTRAIT, LANDSCAPE];

  int getId() {
    return _id;
  }

  String getName() {
    return _name;
  }

  static Orientation valueFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      Orientation num = _values[i];
      if (num.getId() == id) {
        return num;
      }
    }
    return PORTRAIT;
  }

  static Orientation fromMap(Map<dynamic, dynamic> map) {
    int id = map["id"];
    //String name = map["name"];
    return Orientation.valueFromID(id);
  }

  Map<String, dynamic> toMap() {
    return {"id": _id, "name": _name};
  }
}

class PrintMode {
  final int _id;
  final String _name;

  const PrintMode._internal(this._id, this._name);

  static const ORIGINAL = PrintMode._internal(1, "ORIGINAL");
  static const FIT_TO_PAGE = PrintMode._internal(2, "FIT_TO_PAGE");
  static const SCALE = PrintMode._internal(3, "SCALE");
  static const FIT_TO_PAPER = PrintMode._internal(4, "FIT_TO_PAPER");

  static final _values = [ORIGINAL, FIT_TO_PAGE, SCALE, FIT_TO_PAPER];

  int getId() {
    return _id;
  }

  String getName() {
    return _name;
  }

  static PrintMode valueFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      PrintMode num = _values[i];
      if (num.getId() == id) {
        return num;
      }
    }
    return FIT_TO_PAPER;
  }

  static PrintMode fromMap(Map<dynamic, dynamic> map) {
    int id = map["id"];
    //String name = map["name"];
    return PrintMode.valueFromID(id);
  }

  Map<String, dynamic> toMap() {
    return {"id": _id, "name": _name};
  }
}

class Halftone {
  final int _id;
  final String _name;

  const Halftone._internal(this._id, this._name);

  static const THRESHOLD = const Halftone._internal(1, "THRESHOLD");
  static const PATTERNDITHER = const Halftone._internal(2, "PATTERNDITHER");
  static const ERRORDIFFUSION = const Halftone._internal(3, "ERRORDIFFUSION");

  static final _values = [THRESHOLD, PATTERNDITHER, ERRORDIFFUSION];

  int getId() {
    return _id;
  }

  String getName() {
    return _name;
  }

  static Halftone valueFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      Halftone num = _values[i];
      if (num.getId() == id) {
        return num;
      }
    }
    return PATTERNDITHER;
  }

  static Halftone fromMap(Map<dynamic, dynamic> map) {
    int id = map["id"];
    //String name = map["name"];
    return Halftone.valueFromID(id);
  }

  Map<String, dynamic> toMap() {
    return {"id": _id, "name": _name};
  }
}

class Align {
  final int _id;
  final String _name;

  const Align._internal(this._id, this._name);

  static const LEFT = const Align._internal(1, "LEFT");
  static const CENTER = const Align._internal(2, "CENTER");
  static const RIGHT = const Align._internal(3, "RIGHT");

  static final _values = [LEFT, CENTER, RIGHT];

  int getId() {
    return _id;
  }

  String getName() {
    return _name;
  }

  static Align valueFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      Align num = _values[i];
      if (num.getId() == id) {
        return num;
      }
    }
    return LEFT;
  }

  static Align fromMap(Map<dynamic, dynamic> map) {
    int id = map["id"];
    //String name = map["name"];
    return Align.valueFromID(id);
  }

  Map<String, dynamic> toMap() {
    return {"id": _id, "name": _name};
  }
}

class VAlign {
  final int _id;
  final String _name;

  const VAlign._internal(this._id, this._name);

  static const TOP = const VAlign._internal(1, "TOP");
  static const MIDDLE = const VAlign._internal(2, "MIDDLE");
  static const BOTTOM = const VAlign._internal(3, "BOTTOM");

  static final _values = [TOP, MIDDLE, BOTTOM];

  int getId() {
    return _id;
  }

  String getName() {
    return _name;
  }

  static VAlign valueFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      VAlign num = _values[i];
      if (num.getId() == id) {
        return num;
      }
    }
    return TOP;
  }

  static VAlign fromMap(Map<dynamic, dynamic> map) {
    int id = map["id"];
    //String name = map["name"];
    return VAlign.valueFromID(id);
  }

  Map<String, dynamic> toMap() {
    return {"id": _id, "name": _name};
  }
}

class PjRollCase {
  final int _id;
  final String _name;

  const PjRollCase._internal(this._id, this._name);

  static const PJ_ROLLCASE_OFF = PjRollCase._internal(1, "PJ_ROLLCASE_OFF");
  static const PJ_ROLLCASE_ON = PjRollCase._internal(2, "PJ_ROLLCASE_ON");
  static const PJ_ROLLCASE_WITH_ANTICURL =
      PjRollCase._internal(3, "PJ_ROLLCASE_WITH_ANTICURL");

  static final _values = [
    PJ_ROLLCASE_OFF,
    PJ_ROLLCASE_ON,
    PJ_ROLLCASE_WITH_ANTICURL
  ];

  int getId() {
    return _id;
  }

  String getName() {
    return _name;
  }

  static PjRollCase valueFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      PjRollCase num = _values[i];
      if (num.getId() == id) {
        return num;
      }
    }
    return PJ_ROLLCASE_OFF;
  }

  static PjRollCase fromMap(Map<dynamic, dynamic> map) {
    int id = map["id"];
    //String name = map["name"];
    return PjRollCase.valueFromID(id);
  }

  Map<String, dynamic> toMap() {
    return {"id": _id, "name": _name};
  }
}

class PjFeedMode {
  final int _id;
  final String _name;

  const PjFeedMode._internal(this._id, this._name);

  static const PJ_FEED_MODE_FREE =
      const PjFeedMode._internal(1, "PJ_FEED_MODE_FREE");
  static const PJ_FEED_MODE_FIXEDPAGE =
      const PjFeedMode._internal(2, "PJ_FEED_MODE_FIXEDPAGE");
  static const PJ_FEED_MODE_ENDOFPAGE =
      const PjFeedMode._internal(3, "PJ_FEED_MODE_ENDOFPAGE");
  static const PJ_FEED_MODE_ENDOFPAGERETRACT =
      const PjFeedMode._internal(4, "PJ_FEED_MODE_ENDOFPAGERETRACT");

  static final _values = [
    PJ_FEED_MODE_FREE,
    PJ_FEED_MODE_FIXEDPAGE,
    PJ_FEED_MODE_ENDOFPAGE,
    PJ_FEED_MODE_ENDOFPAGERETRACT
  ];

  int getId() {
    return _id;
  }

  String getName() {
    return _name;
  }

  static PjFeedMode valueFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      PjFeedMode num = _values[i];
      if (num.getId() == id) {
        return num;
      }
    }
    return PJ_FEED_MODE_FREE;
  }

  static PjFeedMode fromMap(Map<dynamic, dynamic> map) {
    int id = map["id"];
    //String name = map["name"];
    return PjFeedMode.valueFromID(id);
  }

  Map<String, dynamic> toMap() {
    return {"id": _id, "name": _name};
  }
}

class CheckPrintEnd {
  final int _id;
  final String _name;

  const CheckPrintEnd._internal(this._id, this._name);

  static const CPE_NO_CHECK = const CheckPrintEnd._internal(1, "CPE_NO_CHECK");
  static const CPE_SKIP_LAST =
      const CheckPrintEnd._internal(2, "CPE_SKIP_LAST");
  static const CPE_CHECK = const CheckPrintEnd._internal(3, "CPE_CHECK");

  static final _values = [CPE_NO_CHECK, CPE_SKIP_LAST, CPE_CHECK];

  int getId() {
    return _id;
  }

  String getName() {
    return _name;
  }

  static CheckPrintEnd valueFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      CheckPrintEnd num = _values[i];
      if (num.getId() == id) {
        return num;
      }
    }
    return CPE_NO_CHECK;
  }

  static CheckPrintEnd fromMap(Map<dynamic, dynamic> map) {
    int id = map["id"];
    //String name = map["name"];
    return CheckPrintEnd.valueFromID(id);
  }

  Map<String, dynamic> toMap() {
    return {"id": _id, "name": _name};
  }
}

class ErrorCode {
  final int _id;
  final String _name;

  const ErrorCode._internal(this._id, this._name);

  static const ERROR_NONE = ErrorCode._internal(1, "ERROR_NONE");
  static const ERROR_NOT_SAME_MODEL =
      ErrorCode._internal(2, "ERROR_NOT_SAME_MODEL");
  static const ERROR_BROTHER_PRINTER_NOT_FOUND =
      ErrorCode._internal(3, "ERROR_BROTHER_PRINTER_NOT_FOUND");
  static const ERROR_PAPER_EMPTY = ErrorCode._internal(4, "ERROR_PAPER_EMPTY");
  static const ERROR_BATTERY_EMPTY =
      ErrorCode._internal(5, "ERROR_BATTERY_EMPTY");
  static const ERROR_COMMUNICATION_ERROR =
      ErrorCode._internal(6, "ERROR_COMMUNICATION_ERROR");
  static const ERROR_OVERHEAT = ErrorCode._internal(7, "ERROR_OVERHEAT");
  static const ERROR_PAPER_JAM = ErrorCode._internal(8, "ERROR_PAPER_JAM");
  static const ERROR_HIGH_VOLTAGE_ADAPTER =
      ErrorCode._internal(9, "ERROR_HIGH_VOLTAGE_ADAPTER");
  static const ERROR_CHANGE_CASSETTE =
      ErrorCode._internal(10, "ERROR_CHANGE_CASSETTE");
  static const ERROR_FEED_OR_CASSETTE_EMPTY =
      ErrorCode._internal(11, "ERROR_FEED_OR_CASSETTE_EMPTY");
  static const ERROR_SYSTEM_ERROR =
      ErrorCode._internal(12, "ERROR_SYSTEM_ERROR");
  static const ERROR_NO_CASSETTE = ErrorCode._internal(13, "ERROR_NO_CASSETTE");
  static const ERROR_WRONG_CASSETTE_DIRECT =
      ErrorCode._internal(14, "ERROR_WRONG_CASSETTE_DIRECT");
  static const ERROR_CREATE_SOCKET_FAILED =
      ErrorCode._internal(15, "ERROR_CREATE_SOCKET_FAILED");
  static const ERROR_CONNECT_SOCKET_FAILED =
      ErrorCode._internal(16, "ERROR_CONNECT_SOCKET_FAILED");
  static const ERROR_GET_OUTPUT_STREAM_FAILED =
      ErrorCode._internal(17, "ERROR_GET_OUTPUT_STREAM_FAILED");
  static const ERROR_GET_INPUT_STREAM_FAILED =
      ErrorCode._internal(18, "ERROR_GET_INPUT_STREAM_FAILED");
  static const ERROR_CLOSE_SOCKET_FAILED =
      ErrorCode._internal(19, "ERROR_CLOSE_SOCKET_FAILED");
  static const ERROR_OUT_OF_MEMORY =
      ErrorCode._internal(20, "ERROR_OUT_OF_MEMORY");
  static const ERROR_SET_OVER_MARGIN =
      ErrorCode._internal(21, "ERROR_SET_OVER_MARGIN");
  static const ERROR_NO_SD_CARD = ErrorCode._internal(22, "ERROR_NO_SD_CARD");
  static const ERROR_FILE_NOT_SUPPORTED =
      ErrorCode._internal(23, "ERROR_FILE_NOT_SUPPORTED");
  static const ERROR_EVALUATION_TIMEUP =
      ErrorCode._internal(24, "ERROR_EVALUATION_TIMEUP");
  static const ERROR_WRONG_CUSTOM_INFO =
      ErrorCode._internal(25, "ERROR_WRONG_CUSTOM_INFO");
  static const ERROR_NO_ADDRESS = ErrorCode._internal(26, "ERROR_NO_ADDRESS");
  static const ERROR_NOT_MATCH_ADDRESS =
      ErrorCode._internal(27, "ERROR_NOT_MATCH_ADDRESS");
  static const ERROR_FILE_NOT_FOUND =
      ErrorCode._internal(28, "ERROR_FILE_NOT_FOUND");
  static const ERROR_TEMPLATE_FILE_NOT_MATCH_MODEL =
      ErrorCode._internal(29, "ERROR_TEMPLATE_FILE_NOT_MATCH_MODEL");
  static const ERROR_TEMPLATE_NOT_TRANS_MODEL =
      ErrorCode._internal(30, "ERROR_TEMPLATE_NOT_TRANS_MODEL");
  static const ERROR_COVER_OPEN = ErrorCode._internal(31, "ERROR_COVER_OPEN");
  static const ERROR_WRONG_LABEL = ErrorCode._internal(32, "ERROR_WRONG_LABEL");
  static const ERROR_PORT_NOT_SUPPORTED =
      ErrorCode._internal(33, "ERROR_PORT_NOT_SUPPORTED");
  static const ERROR_WRONG_TEMPLATE_KEY =
      ErrorCode._internal(34, "ERROR_WRONG_TEMPLATE_KEY");
  static const ERROR_BUSY = ErrorCode._internal(35, "ERROR_BUSY");
  static const ERROR_TEMPLATE_NOT_PRINT_MODEL =
      ErrorCode._internal(36, "ERROR_TEMPLATE_NOT_PRINT_MODEL");
  static const ERROR_CANCEL = ErrorCode._internal(37, "ERROR_CANCEL");
  static const ERROR_PRINTER_SETTING_NOT_SUPPORTED =
      ErrorCode._internal(38, "ERROR_PRINTER_SETTING_NOT_SUPPORTED");
  static const ERROR_INVALID_PARAMETER =
      ErrorCode._internal(39, "ERROR_INVALID_PARAMETER");
  static const ERROR_INTERNAL_ERROR =
      ErrorCode._internal(40, "ERROR_INTERNAL_ERROR");
  static const ERROR_TEMPLATE_NOT_CONTROL_MODEL =
      ErrorCode._internal(41, "ERROR_TEMPLATE_NOT_CONTROL_MODEL");
  static const ERROR_TEMPLATE_NOT_EXIST =
      ErrorCode._internal(42, "ERROR_TEMPLATE_NOT_EXIST");
  static const ERROR_BUFFER_FULL = ErrorCode._internal(44, "ERROR_BUFFER_FULL");
  static const ERROR_TUBE_EMPTY = ErrorCode._internal(45, "ERROR_TUBE_EMPTY");
  static const ERROR_TUBE_RIBBON_EMPTY =
      ErrorCode._internal(46, "ERROR_TUBE_RIBBON_EMPTY");
  static const ERROR_UPDATE_FRIM_NOT_SUPPORTED =
      ErrorCode._internal(47, "ERROR_UPDATE_FRIM_NOT_SUPPORTED");
  static const ERROR_OS_VERSION_NOT_SUPPORTED =
      ErrorCode._internal(48, "ERROR_OS_VERSION_NOT_SUPPORTED");
  static const ERROR_RESOLUTION_MODE =
      ErrorCode._internal(49, "ERROR_RESOLUTION_MODE");
  static const ERROR_POWER_CABLE_UNPLUGGING =
      ErrorCode._internal(50, "ERROR_POWER_CABLE_UNPLUGGING");
  static const ERROR_BATTERY_TROUBLE =
      ErrorCode._internal(51, "ERROR_BATTERY_TROUBLE");
  static const ERROR_UNSUPPORTED_MEDIA =
      ErrorCode._internal(52, "ERROR_UNSUPPORTED_MEDIA");
  static const ERROR_TUBE_CUTTER = ErrorCode._internal(53, "ERROR_TUBE_CUTTER");
  static const ERROR_UNSUPPORTED_TWO_COLOR =
      ErrorCode._internal(54, "ERROR_UNSUPPORTED_TWO_COLOR");
  static const ERROR_UNSUPPORTED_MONO_COLOR =
      ErrorCode._internal(55, "ERROR_UNSUPPORTED_MONO_COLOR");
  static const ERROR_MINIMUM_LENGTH_LIMIT =
      ErrorCode._internal(56, "ERROR_MINIMUM_LENGTH_LIMIT");
  static const ERROR_WORKPATH_NOT_SET =
      ErrorCode._internal(57, "ERROR_WORKPATH_NOT_SET");
  // Another_Brother specific error. Sent when the Android device does not have storage permissions granted.
  static const ERROR_STORAGE_PERMISSION_NOT_GRANTED =
      ErrorCode._internal(9999, "ERROR_STORAGE_PERMISSION_NOT_GRANTED");

  static final _values = [
    ERROR_NONE,
    ERROR_NOT_SAME_MODEL,
    ERROR_BROTHER_PRINTER_NOT_FOUND,
    ERROR_PAPER_EMPTY,
    ERROR_BATTERY_EMPTY,
    ERROR_COMMUNICATION_ERROR,
    ERROR_OVERHEAT,
    ERROR_PAPER_JAM,
    ERROR_HIGH_VOLTAGE_ADAPTER,
    ERROR_CHANGE_CASSETTE,
    ERROR_FEED_OR_CASSETTE_EMPTY,
    ERROR_SYSTEM_ERROR,
    ERROR_NO_CASSETTE,
    ERROR_WRONG_CASSETTE_DIRECT,
    ERROR_CREATE_SOCKET_FAILED,
    ERROR_CONNECT_SOCKET_FAILED,
    ERROR_GET_OUTPUT_STREAM_FAILED,
    ERROR_GET_INPUT_STREAM_FAILED,
    ERROR_CLOSE_SOCKET_FAILED,
    ERROR_OUT_OF_MEMORY,
    ERROR_SET_OVER_MARGIN,
    ERROR_NO_SD_CARD,
    ERROR_FILE_NOT_SUPPORTED,
    ERROR_EVALUATION_TIMEUP,
    ERROR_WRONG_CUSTOM_INFO,
    ERROR_NO_ADDRESS,
    ERROR_NOT_MATCH_ADDRESS,
    ERROR_FILE_NOT_FOUND,
    ERROR_TEMPLATE_FILE_NOT_MATCH_MODEL,
    ERROR_TEMPLATE_NOT_TRANS_MODEL,
    ERROR_COVER_OPEN,
    ERROR_WRONG_LABEL,
    ERROR_PORT_NOT_SUPPORTED,
    ERROR_WRONG_TEMPLATE_KEY,
    ERROR_BUSY,
    ERROR_TEMPLATE_NOT_PRINT_MODEL,
    ERROR_CANCEL,
    ERROR_PRINTER_SETTING_NOT_SUPPORTED,
    ERROR_INVALID_PARAMETER,
    ERROR_INTERNAL_ERROR,
    ERROR_TEMPLATE_NOT_CONTROL_MODEL,
    ERROR_TEMPLATE_NOT_EXIST,
    ERROR_BUFFER_FULL,
    ERROR_TUBE_EMPTY,
    ERROR_TUBE_RIBBON_EMPTY,
    ERROR_UPDATE_FRIM_NOT_SUPPORTED,
    ERROR_OS_VERSION_NOT_SUPPORTED,
    ERROR_RESOLUTION_MODE,
    ERROR_POWER_CABLE_UNPLUGGING,
    ERROR_BATTERY_TROUBLE,
    ERROR_UNSUPPORTED_MEDIA,
    ERROR_TUBE_CUTTER,
    ERROR_UNSUPPORTED_TWO_COLOR,
    ERROR_UNSUPPORTED_MONO_COLOR,
    ERROR_MINIMUM_LENGTH_LIMIT,
    ERROR_WORKPATH_NOT_SET,
    ERROR_STORAGE_PERMISSION_NOT_GRANTED
  ];

  int getId() {
    return _id;
  }

  String getName() {
    return _name;
  }

  static int getItemId(index) {
    if (index < 0 || index > _values.length) {
      return ERROR_INTERNAL_ERROR.getId();
    }

    return _values[index].getId();
  }

  static ErrorCode valueFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      ErrorCode num = _values[i];
      if (num.getId() == id) {
        return num;
      }
    }
    return ERROR_INTERNAL_ERROR;
  }

  static ErrorCode valueFromName(String name) {
    for (int i = 0; i < _values.length; ++i) {
      ErrorCode num = _values[i];
      if (num.getName() == name) {
        return num;
      }
    }
    return ERROR_INTERNAL_ERROR;
  }

  static int ordinalFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      ErrorCode num = _values[i];
      if (num.getId() == id) {
        return i;
      }
    }
    return -1;
  }

  static ErrorCode fromMap(Map<dynamic, dynamic> map) {
    //int id = map["id"];
    String name = map["name"];
    return ErrorCode.valueFromName(name);
  }

  Map<String, dynamic> toMap() {
    return {"id": _id, "name": _name};
  }

  static List<ErrorCode> getValues() => List.from(_values);
}

class Msg {
  final int _id;

  const Msg._internal(this._id);

  static const MESSAGE_START_COMMUNICATION = Msg._internal(1);
  static const MESSAGE_START_CONNECT = Msg._internal(2);
  static const MESSAGE_END_CONNECTED = Msg._internal(3);
  static const MESSAGE_START_GET_OUTPUT_STREAM = Msg._internal(4);
  static const MESSAGE_END_GET_OUTPUT_STREAM = Msg._internal(5);
  static const MESSAGE_START_GET_INPUT_STREAM = Msg._internal(6);
  static const MESSAGE_END_GET_INPUT_STREAM = Msg._internal(7);
  static const MESSAGE_START_SEND_STATUS_REQUEST = Msg._internal(8);
  static const MESSAGE_END_SEND_STATUS_REQUEST = Msg._internal(9);
  static const MESSAGE_START_READ_PRINTER_STATUS = Msg._internal(10);
  static const MESSAGE_END_READ_PRINTER_STATUS = Msg._internal(11);
  static const MESSAGE_START_CREATE_DATA = Msg._internal(12);
  static const MESSAGE_END_CREATE_DATA = Msg._internal(13);
  static const MESSAGE_START_SEND_DATA = Msg._internal(14);
  static const MESSAGE_END_SEND_DATA = Msg._internal(15);
  static const MESSAGE_START_SEND_TEMPLATE = Msg._internal(16);
  static const MESSAGE_END_SEND_TEMPLATE = Msg._internal(17);
  static const MESSAGE_START_SOCKET_CLOSE = Msg._internal(18);
  static const MESSAGE_END_SOCKET_CLOSE = Msg._internal(19);
  static const MESSAGE_END_COMMUNICATION = Msg._internal(20);
  static const MESSAGE_PRINT_COMPLETE = Msg._internal(21);
  static const MESSAGE_PRINT_ERROR = Msg._internal(22);
  static const MESSAGE_PAPER_EMPTY = Msg._internal(23);
  static const MESSAGE_START_COOLING = Msg._internal(24);
  static const MESSAGE_END_COOLING = Msg._internal(25);
  static const MESSAGE_PREPARATION = Msg._internal(26);
  static const MESSAGE_WAIT_PEEL = Msg._internal(27);
  static const MESSAGE_START_UPDATE_BLUETOOTH_SETTING = Msg._internal(28);
  static const MESSAGE_END_UPDATE_BLUETOOTH_SETTING = Msg._internal(29);
  static const MESSAGE_START_GET_BLUETOOTH_SETTING = Msg._internal(30);
  static const MESSAGE_END_GET_BLUETOOTH_SETTING = Msg._internal(31);
  static const MESSAGE_START_GET_TEMPLATE_LIST = Msg._internal(32);
  static const MESSAGE_END_GET_TEMPLATE_LIST = Msg._internal(33);
  static const MESSAGE_START_REMOVE_TEMPLATE_LIST = Msg._internal(34);
  static const MESSAGE_END_REMOVE_TEMPLATE_LIST = Msg._internal(35);
  static const MESSAGE_CANCEL = Msg._internal(36);
  static const MESSAGE_START_TRANSFER_FIRM = Msg._internal(37);
  static const MESSAGE_END_TRANSFER_FIRM = Msg._internal(38);
  static const MESSAGE_ERROR = Msg._internal(255);

  static final _values = [
    MESSAGE_START_COMMUNICATION,
    MESSAGE_START_CONNECT,
    MESSAGE_END_CONNECTED,
    MESSAGE_START_GET_OUTPUT_STREAM,
    MESSAGE_END_GET_OUTPUT_STREAM,
    MESSAGE_START_GET_INPUT_STREAM,
    MESSAGE_END_GET_INPUT_STREAM,
    MESSAGE_START_SEND_STATUS_REQUEST,
    MESSAGE_END_SEND_STATUS_REQUEST,
    MESSAGE_START_READ_PRINTER_STATUS,
    MESSAGE_END_READ_PRINTER_STATUS,
    MESSAGE_START_CREATE_DATA,
    MESSAGE_END_CREATE_DATA,
    MESSAGE_START_SEND_DATA,
    MESSAGE_END_SEND_DATA,
    MESSAGE_START_SEND_TEMPLATE,
    MESSAGE_END_SEND_TEMPLATE,
    MESSAGE_START_SOCKET_CLOSE,
    MESSAGE_END_SOCKET_CLOSE,
    MESSAGE_END_COMMUNICATION,
    MESSAGE_PRINT_COMPLETE,
    MESSAGE_PRINT_ERROR,
    MESSAGE_PAPER_EMPTY,
    MESSAGE_START_COOLING,
    MESSAGE_END_COOLING,
    MESSAGE_PREPARATION,
    MESSAGE_WAIT_PEEL,
    MESSAGE_START_UPDATE_BLUETOOTH_SETTING,
    MESSAGE_END_UPDATE_BLUETOOTH_SETTING,
    MESSAGE_START_GET_BLUETOOTH_SETTING,
    MESSAGE_END_GET_BLUETOOTH_SETTING,
    MESSAGE_START_GET_TEMPLATE_LIST,
    MESSAGE_END_GET_TEMPLATE_LIST,
    MESSAGE_START_REMOVE_TEMPLATE_LIST,
    MESSAGE_END_REMOVE_TEMPLATE_LIST,
    MESSAGE_CANCEL,
    MESSAGE_START_TRANSFER_FIRM,
    MESSAGE_END_TRANSFER_FIRM,
    MESSAGE_ERROR
  ];

  int getId() {
    return _id;
  }

  static int getItemId(index) {
    if (index < 0 || index > _values.length) {
      return MESSAGE_ERROR.getId();
    }

    return _values[index].getId();
  }

  static Msg valueFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      Msg num = _values[i];
      if (num.getId() == id) {
        return num;
      }
    }
    return MESSAGE_ERROR;
  }

  static int ordinalFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      Msg num = _values[i];
      if (num.getId() == id) {
        return i;
      }
    }
    return -1;
  }

  static Msg fromMap(Map<dynamic, dynamic> map) {
    int id = map["id"];
    return Msg.valueFromID(id);
  }

  Map<String, dynamic> toMap() {
    return {"id": _id};
  }
}

class PrinterSettingItem {
  final int _id;
  final String _name;
  const PrinterSettingItem._internal(this._id, this._name);

  static const NET_BOOTMODE = PrinterSettingItem._internal(1, "NET_BOOTMODE");
  static const NET_INTERFACE = PrinterSettingItem._internal(2, "NET_INTERFACE");
  static const NET_IPV4_BOOTMETHOD =
      PrinterSettingItem._internal(5, "NET_IPV4_BOOTMETHOD");
  static const NET_STATIC_IPV4ADDRESS =
      PrinterSettingItem._internal(6, "NET_STATIC_IPV4ADDRESS");
  static const NET_SUBNETMASK =
      PrinterSettingItem._internal(7, "NET_SUBNETMASK");
  static const NET_GATEWAY = PrinterSettingItem._internal(8, "NET_GATEWAY");
  static const NET_DNS_IPV4_BOOTMETHOD =
      PrinterSettingItem._internal(9, "NET_DNS_IPV4_BOOTMETHOD");
  static const NET_PRIMARY_DNS_IPV4ADDRESS =
      PrinterSettingItem._internal(10, "NET_PRIMARY_DNS_IPV4ADDRESS");
  static const NET_SECOND_DNS_IPV4ADDRESS =
      PrinterSettingItem._internal(11, "NET_SECOND_DNS_IPV4ADDRESS");
  static const NET_USED_IPV6 = PrinterSettingItem._internal(3, "NET_USED_IPV6");
  static const NET_PRIORITY_IPV6 =
      PrinterSettingItem._internal(4, "NET_PRIORITY_IPV6");
  static const NET_IPV6_BOOTMETHOD =
      PrinterSettingItem._internal(12, "NET_IPV6_BOOTMETHOD");
  static const NET_STATIC_IPV6ADDRESS =
      PrinterSettingItem._internal(13, "NET_STATIC_IPV6ADDRESS");
  static const NET_PRIMARY_DNS_IPV6ADDRESS =
      PrinterSettingItem._internal(14, "NET_PRIMARY_DNS_IPV6ADDRESS");
  static const NET_SECOND_DNS_IPV6ADDRESS =
      PrinterSettingItem._internal(15, "NET_SECOND_DNS_IPV6ADDRESS");
  static const NET_IPV6ADDRESS_LIST =
      PrinterSettingItem._internal(16, "NET_IPV6ADDRESS_LIST");
  static const NET_COMMUNICATION_MODE =
      PrinterSettingItem._internal(17, "NET_COMMUNICATION_MODE");
  static const NET_SSID = PrinterSettingItem._internal(18, "NET_SSID");
  static const NET_CHANNEL = PrinterSettingItem._internal(19, "NET_CHANNEL");
  static const NET_AUTHENTICATION_METHOD =
      PrinterSettingItem._internal(20, "NET_AUTHENTICATION_METHOD");
  static const NET_ENCRYPTIONMODE =
      PrinterSettingItem._internal(21, "NET_ENCRYPTIONMODE");
  static const NET_WEPKEY = PrinterSettingItem._internal(22, "NET_WEPKEY");
  static const NET_PASSPHRASE =
      PrinterSettingItem._internal(23, "NET_PASSPHRASE");
  static const NET_USER_ID = PrinterSettingItem._internal(24, "NET_USER_ID");
  static const NET_PASSWORD = PrinterSettingItem._internal(25, "NET_PASSWORD");
  static const NET_NODENAME = PrinterSettingItem._internal(26, "NET_NODENAME");
  static const WIRELESSDIRECT_KEY_CREATE_MODE =
      PrinterSettingItem._internal(27, "WIRELESSDIRECT_KEY_CREATE_MODE");
  static const WIRELESSDIRECT_SSID =
      PrinterSettingItem._internal(28, "WIRELESSDIRECT_SSID");
  static const WIRELESSDIRECT_NETWORK_KEY =
      PrinterSettingItem._internal(29, "WIRELESSDIRECT_NETWORK_KEY");
  static const BT_ISDISCOVERABLE =
      PrinterSettingItem._internal(30, "BT_ISDISCOVERABLE");
  static const BT_DEVICENAME =
      PrinterSettingItem._internal(31, "BT_DEVICENAME");
  static const BT_BOOTMODE = PrinterSettingItem._internal(34, "BT_BOOTMODE");
  static const PRINT_JPEG_HALFTONE =
      PrinterSettingItem._internal(37, "PRINT_JPEG_HALFTONE");
  static const PRINT_JPEG_SCALE =
      PrinterSettingItem._internal(38, "PRINT_JPEG_SCALE");
  static const PRINT_DENSITY =
      PrinterSettingItem._internal(39, "PRINT_DENSITY");
  static const PRINT_SPEED = PrinterSettingItem._internal(40, "PRINT_SPEED");
  static const PRINTER_POWEROFFTIME =
      PrinterSettingItem._internal(35, "PRINTER_POWEROFFTIME");
  static const PRINTER_POWEROFFTIME_BATTERY =
      PrinterSettingItem._internal(36, "PRINTER_POWEROFFTIME_BATTERY");
  static const BT_AUTO_CONNECTION =
      PrinterSettingItem._internal(44, "BT_AUTO_CONNECTION");
  static const RESET = PrinterSettingItem._internal(254, "RESET");
  static const UNSUPPORTED = PrinterSettingItem._internal(255, "UNSUPPORTED");

  static final _values = [
    NET_BOOTMODE,
    NET_INTERFACE,
    NET_IPV4_BOOTMETHOD,
    NET_STATIC_IPV4ADDRESS,
    NET_SUBNETMASK,
    NET_GATEWAY,
    NET_DNS_IPV4_BOOTMETHOD,
    NET_PRIMARY_DNS_IPV4ADDRESS,
    NET_SECOND_DNS_IPV4ADDRESS,
    NET_USED_IPV6,
    NET_PRIORITY_IPV6,
    NET_IPV6_BOOTMETHOD,
    NET_STATIC_IPV6ADDRESS,
    NET_PRIMARY_DNS_IPV6ADDRESS,
    NET_SECOND_DNS_IPV6ADDRESS,
    NET_IPV6ADDRESS_LIST,
    NET_COMMUNICATION_MODE,
    NET_SSID,
    NET_CHANNEL,
    NET_AUTHENTICATION_METHOD,
    NET_ENCRYPTIONMODE,
    NET_WEPKEY,
    NET_PASSPHRASE,
    NET_USER_ID,
    NET_PASSWORD,
    NET_NODENAME,
    WIRELESSDIRECT_KEY_CREATE_MODE,
    WIRELESSDIRECT_SSID,
    WIRELESSDIRECT_NETWORK_KEY,
    BT_ISDISCOVERABLE,
    BT_DEVICENAME,
    BT_BOOTMODE,
    PRINT_JPEG_HALFTONE,
    PRINT_JPEG_SCALE,
    PRINT_DENSITY,
    PRINT_SPEED,
    PRINTER_POWEROFFTIME,
    PRINTER_POWEROFFTIME_BATTERY,
    BT_AUTO_CONNECTION,
    RESET,
    UNSUPPORTED
  ];

  int getId() {
    return _id;
  }

  String getName() {
    return _name;
  }

  static int getItemId(index) {
    if (index < 0 || index > _values.length) {
      return UNSUPPORTED.getId();
    }

    return _values[index].getId();
  }

  static PrinterSettingItem valueFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      PrinterSettingItem num = _values[i];
      if (num.getId() == id) {
        return num;
      }
    }
    return UNSUPPORTED;
  }

  static PrinterSettingItem valueFromName(String name) {
    for (int i = 0; i < _values.length; ++i) {
      PrinterSettingItem num = _values[i];
      if (num.getName() == name) {
        return num;
      }
    }
    return UNSUPPORTED;
  }

  static int ordinalFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      PrinterSettingItem num = _values[i];
      if (num.getId() == id) {
        return i;
      }
    }
    return -1;
  }

  static PrinterSettingItem fromMap(Map<dynamic, dynamic> map) {
    //int id = map["id"];
    String name = map["name"];
    return PrinterSettingItem.valueFromName(name);
  }

  Map<String, dynamic> toMap() {
    return {"id": _id, "name": _name};
  }

  @override
  String toString() {
    return _name;
  }
}

class PrintQuality {
  final int _id;
  final String _name;

  const PrintQuality._internal(this._id, this._name);

  static const LOW_RESOLUTION = PrintQuality._internal(1, "LOW_RESOLUTION");
  static const NORMAL = PrintQuality._internal(2, "NORMAL");
  static const DOUBLE_SPEED = PrintQuality._internal(3, "DOUBLE_SPEED");
  static const HIGH_RESOLUTION = PrintQuality._internal(4, "HIGH_RESOLUTION");

  static final _values = [
    LOW_RESOLUTION,
    NORMAL,
    DOUBLE_SPEED,
    HIGH_RESOLUTION
  ];

  int getId() {
    return _id;
  }

  String getName() {
    return _name;
  }

  static PrintQuality valueFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      PrintQuality num = _values[i];
      if (num.getId() == id) {
        return num;
      }
    }
    return NORMAL;
  }

  static PrintQuality fromMap(Map<dynamic, dynamic> map) {
    int id = map["id"];
    //String name = map["name"];
    return PrintQuality.valueFromID(id);
  }

  Map<String, dynamic> toMap() {
    return {"id": _id, "name": _name};
  }
}

class PjPaperKind {
  final int _id;
  final String _name;

  const PjPaperKind._internal(this._id, this._name);

  static const PJ_ROLL = PjPaperKind._internal(1, "PJ_ROLL");
  static const PJ_CUT_PAPER = PjPaperKind._internal(2, "PJ_CUT_PAPER");

  static final _values = [PJ_ROLL, PJ_CUT_PAPER];

  int getId() {
    return _id;
  }

  String getName() {
    return _name;
  }

  static PjPaperKind valueFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      PjPaperKind num = _values[i];
      if (num.getId() == id) {
        return num;
      }
    }
    return PJ_ROLL;
  }

  static PjPaperKind fromMap(Map<dynamic, dynamic> map) {
    int id = map["id"];
    //String name = map["name"];
    return PjPaperKind.valueFromID(id);
  }

  Map<String, dynamic> toMap() {
    return {"id": _id, "name": _name};
  }
}

class Margin {
  final int top;
  final int left;

  const Margin({this.top = 0, this.left = 0});

  static Margin fromMap(Map<dynamic, dynamic> map) {
    return Margin(top: map["top"], left: map["left"]);
  }

  Map<String, dynamic> toMap() {
    return {"top": top, "left": left};
  }
}

class PrinterInfo {
  Model printerModel = Model.PJ_663;
  Port port;
  String ipAddress;
  String macAddress;
  String _localName;
  String _lastConnectedAddress;
  Orientation orientation;
  int numberOfCopies;
  PrintMode printMode;
  double scaleValue;
  Halftone halftone;
  int thresholdingValue;
  Align align;
  VAlign valign;
  Margin margin;
  bool skipStatusCheck;
  CheckPrintEnd checkPrintEnd;
  String savePrnPath;
  bool overwrite;
  bool enabledTethering;
  bool softFocusing;
  bool trimTapeAfterData;
  bool rawMode;
  PaperSize paperSize;
  String customPaper;
  ACustomPaper? binCustomPaper;

  CustomPaperInfo? customPaperInfo;
  int labelNameIndex;
  ALabelName _labelName;
  bool pjCarbon;
  int pjDensity;
  PjFeedMode pjFeedMode;
  int pjSpeed;
  Align paperPosition;
  int customPaperWidth;
  int customPaperLength;
  int customFeed;
  PjRollCase rollPrinterCase;
  int rjDensity;
  bool rotate180;
  bool peelMode;
  bool isAutoCut;
  bool isCutAtEnd;
  bool isSpecialTape;
  bool isHalfCut;
  bool mode9;
  PrintQuality printQuality;
  bool mirrorPrint;
  TimeoutSetting timeout = new TimeoutSetting();
  bool dashLine;
  bool isLabelEndCut;
  bool isCutMark;
  int labelMargin;
  String workPath;
  PjPaperKind pjPaperKind;
  bool useLegacyHalftoneEngine;
  bool banishMargin;
  bool useCopyCommandInTemplatePrint;

  int? dpi;

  PrinterInfo(
      {Model? printerModel,
      this.port = Port.BLUETOOTH,
      this.ipAddress = "",
      this.macAddress = "",
      localName = "",
      lastConnectedAddress = "",
      this.paperSize = PaperSize.A4,
      this.orientation = Orientation.PORTRAIT,
      this.numberOfCopies = 1,
      this.halftone = Halftone.PATTERNDITHER,
      this.printMode = PrintMode.FIT_TO_PAGE,
      this.align = Align.LEFT,
      this.valign = VAlign.TOP,
      this.margin = const Margin(top: 0, left: 0),
      this.pjCarbon = false,
      this.pjDensity = 5,
      this.pjFeedMode = PjFeedMode.PJ_FEED_MODE_FIXEDPAGE,
      this.customPaperWidth = 0,
      this.customPaperLength = 0,
      this.customFeed = 0,
      this.rjDensity = 0,
      this.rotate180 = false,
      this.peelMode = false,
      this.mirrorPrint = false,
      this.paperPosition = Align.CENTER,
      this.isAutoCut = true,
      this.isCutAtEnd = true,
      this.mode9 = true,
      this.skipStatusCheck = false,
      this.checkPrintEnd = CheckPrintEnd.CPE_CHECK,
      this.rollPrinterCase = PjRollCase.PJ_ROLLCASE_OFF,
      this.pjSpeed = 2,
      this.thresholdingValue = 127,
      //this.timeout = new TimeoutSetting(),
      this.dashLine = false,
      this.savePrnPath = "",
      this.overwrite = true,
      this.isHalfCut = false,
      this.isSpecialTape = false,
      this.labelNameIndex = -1,
      this.customPaper = "",
      this.binCustomPaper = null,
      this.customPaperInfo = null,
      this.isLabelEndCut = false,
      this.printQuality = PrintQuality.NORMAL,
      this.labelMargin = 0,
      this.scaleValue = 1.0,
      this.isCutMark = false,
      this.softFocusing = false,
      this.trimTapeAfterData = false,
      this.enabledTethering = false,
      this.rawMode = false,
      this.workPath = "",
      this.pjPaperKind = PjPaperKind.PJ_CUT_PAPER,
      this.useLegacyHalftoneEngine = false,
      this.banishMargin = false,
      this.useCopyCommandInTemplatePrint = false})
      : this.printerModel = printerModel == null ? Model.PJ_663 : printerModel,
        this._lastConnectedAddress = "",
        this._localName = "",
        _labelName = QL700.W62;

  String getLastConnectedAddress() {
    return this._lastConnectedAddress;
  }

  void setLastConnectedAddress(String setAddress) {
    this._lastConnectedAddress = setAddress;
  }

  String getLocalName() {
    return this._localName;
  }

  void setLocalName(String setName) {
    if (setName != this._localName) {
      this._localName = setName;
      this._lastConnectedAddress = "";
    }
  }

  ACustomPaper? getCustomPaper() => binCustomPaper;

  static PrinterInfo fromMap(Map<dynamic, dynamic> map) {
    Model model = Model.fromMap(map["printerModel"]);
    TimeoutSetting timeout = TimeoutSetting.fromMap(map["timeout"]);
    PrinterInfo info = PrinterInfo(
        printerModel: model,
        port: Port.fromMap(map["port"]),
        ipAddress: map["ipAddress"],
        macAddress: map["macAddress"],
        localName: map["localName"],
        lastConnectedAddress: map["lastConnectedAddress"],
        paperSize: PaperSize.fromMap(map["paperSize"]),
        orientation: Orientation.fromMap(map["orientation"]),
        numberOfCopies: map["numberOfCopies"],
        halftone: Halftone.fromMap(map["halftone"]),
        printMode: PrintMode.fromMap(map["printMode"]),
        align: Align.fromMap(map["align"]),
        valign: VAlign.fromMap(map["valign"]),
        margin: Margin.fromMap(map["margin"]),
        pjCarbon: map["pjCarbon"],
        pjDensity: map["pjDensity"],
        pjFeedMode: PjFeedMode.fromMap(map["pjFeedMode"]),
        customPaperWidth: map["customPaperWidth"],
        customPaperLength: map["customPaperLength"],
        customFeed: map["customFeed"],
        rjDensity: map["rjDensity"],
        rotate180: map["rotate180"],
        peelMode: map["peelMode"],
        mirrorPrint: map["mirrorPrint"],
        paperPosition: Align.fromMap(map["paperPosition"]),
        isAutoCut: map["isAutoCut"],
        isCutAtEnd: map["isCutAtEnd"],
        mode9: map["mode9"],
        skipStatusCheck: map["skipStatusCheck"],
        checkPrintEnd: CheckPrintEnd.fromMap(map["checkPrintEnd"]),
        rollPrinterCase: PjRollCase.fromMap(map["rollPrinterCase"]),
        pjSpeed: map["pjSpeed"],
        thresholdingValue: map["thresholdingValue"],
        //this.timeout = new TimeoutSetting(),
        dashLine: map["dashLine"],
        savePrnPath: map["savePrnPath"],
        overwrite: map["overwrite"],
        isHalfCut: map["isHalfCut"],
        isSpecialTape: map["isSpecialTape"],
        labelNameIndex: map["labelNameIndex"],
        customPaper: map["customPaper"],
        //binCustomPaper: map["binCustomPaper"],
        customPaperInfo: CustomPaperInfo.fromMap(map["customPaperInfo"]),
        isLabelEndCut: map["isLabelEndCut"],
        printQuality: PrintQuality.fromMap(map["printQuality"]),
        labelMargin: map["labelMargin"],
        scaleValue: map["scaleValue"],
        isCutMark: map["isCutMark"],
        softFocusing: map["softFocusing"],
        trimTapeAfterData: map["trimTapeAfterData"],
        enabledTethering: map["enabledTethering"],
        rawMode: map["rawMode"],
        workPath: map["workPath"],
        pjPaperKind: PjPaperKind.fromMap(map["pjPaperKind"]),
        useLegacyHalftoneEngine: map["useLegacyHalftoneEngine"],
        banishMargin: map["banishMargin"],
        useCopyCommandInTemplatePrint: map["useCopyCommandInTemplatePrint"]);
    info.timeout = timeout;
    return info;
  }

  Map<String, dynamic> toMap() {
    return {
      "printerModel": printerModel.toMap(),
      "port": port.toMap(),
      "ipAddress": ipAddress,
      "macAddress": macAddress,
      "localName": _localName,
      "lastConnectedAddress": _lastConnectedAddress,
      "paperSize": paperSize.toMap(),
      "orientation": orientation.toMap(),
      "numberOfCopies": numberOfCopies,
      "halftone": halftone.toMap(),
      "printMode": printMode.toMap(),
      "align": align.toMap(),
      "valign": valign.toMap(),
      "margin": margin.toMap(),
      "pjCarbon": pjCarbon,
      "pjDensity": pjDensity,
      "pjFeedMode": pjFeedMode.toMap(),
      "customPaperWidth": customPaperWidth,
      "customPaperLength": customPaperLength,
      "customFeed": customFeed,
      "rjDensity": rjDensity,
      "rotate180": rotate180,
      "peelMode": peelMode,
      "mirrorPrint": mirrorPrint,
      "paperPosition": paperPosition.toMap(),
      "isAutoCut": isAutoCut,
      "isCutAtEnd": isCutAtEnd,
      "mode9": mode9,
      "skipStatusCheck": skipStatusCheck,
      "checkPrintEnd": checkPrintEnd.toMap(),
      "rollPrinterCase": rollPrinterCase.toMap(),
      "pjSpeed": pjSpeed,
      "thresholdingValue": thresholdingValue,
      "timeout": timeout.toMap(),
      "dashLine": dashLine,
      "savePrnPath": savePrnPath,
      "overwrite": overwrite,
      "isHalfCut": isHalfCut,
      "isSpecialTape": isSpecialTape,
      "labelNameIndex": labelNameIndex,
      "customPaper": customPaper,
      "binCustomPaper": binCustomPaper != null ? binCustomPaper?.toMap() : null,
      "customPaperInfo": this.customPaperInfo?.toMap(),
      "isLabelEndCut": isLabelEndCut,
      "printQuality": printQuality.toMap(),
      "labelMargin": labelMargin,
      "scaleValue": scaleValue,
      "isCutMark": isCutMark,
      "softFocusing": softFocusing,
      "trimTapeAfterData": trimTapeAfterData,
      "enabledTethering": enabledTethering,
      "rawMode": rawMode,
      "workPath": workPath,
      "pjPaperKind": pjPaperKind.toMap(),
      "useLegacyHalftoneEngine": useLegacyHalftoneEngine,
      "banishMargin": banishMargin,
      "useCopyCommandInTemplatePrint": useCopyCommandInTemplatePrint,
      "labelName": _labelName.toMap()
    };
  }

  /*
  CustomPaperInfo? getCustomPaperInfo() {
    return this.customPaperInfo;
  }*/
}

class BatteryTernary {
  final int _id;
  final String _name;

  const BatteryTernary._internal(this._id, this._name);

  static const Yes = BatteryTernary._internal(1, "Yes");
  static const No = BatteryTernary._internal(0, "No");
  static const Unknown = BatteryTernary._internal(-1, "Unknown");

  static final _values = [Yes, No, Unknown];

  int getId() {
    return _id;
  }

  String getName() {
    return _name;
  }

  static int getItemId(index) {
    if (index < 0 || index > _values.length) {
      return Unknown.getId();
    }

    return _values[index].getId();
  }

  static BatteryTernary valueFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      BatteryTernary num = _values[i];
      if (num.getId() == id) {
        return num;
      }
    }
    return Unknown;
  }

  static BatteryTernary valueFromName(String name) {
    for (int i = 0; i < _values.length; ++i) {
      BatteryTernary num = _values[i];
      if (num.getName() == name) {
        return num;
      }
    }
    return Unknown;
  }

  static int ordinalFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      BatteryTernary num = _values[i];
      if (num.getId() == id) {
        return i;
      }
    }
    return -1;
  }

  static BatteryTernary fromMap(Map<dynamic, dynamic> map) {
    //int id = map["id"];
    String name = map["name"];
    return BatteryTernary.valueFromName(name);
  }

  Map<String, dynamic> toMap() {
    return {"id": this._id, "name": this._name};
  }
}

class PrinterStatus {
  Uint8List _statusBytes;
  ErrorCode errorCode;

  /** @deprecated */
  int batteryLevel;
  int batteryResidualQuantityLevel;
  int maxOfBatteryResidualQuantityLevel;
  BatteryTernary isACConnected;
  BatteryTernary isBatteryMounted;
  LabelColor labelColor = LabelColor.UNSUPPORT;
  LabelColor labelFontColor = LabelColor.UNSUPPORT;
  int labelId;
  int labelType;

  PrinterStatus(
      {Uint8List? statusBytes,
      this.errorCode = ErrorCode.ERROR_NONE,
      this.labelId = -1,
      this.labelType = -1,
      this.isACConnected = BatteryTernary.Unknown,
      this.isBatteryMounted = BatteryTernary.Unknown,
      this.batteryLevel = -1,
      this.batteryResidualQuantityLevel = -1,
      this.maxOfBatteryResidualQuantityLevel = -1})
      : this._statusBytes =
            statusBytes == null ? new Uint8List(32) : statusBytes;

  ErrorCode getLastError() {
    return this.errorCode;
  }

  Uint8List getStatusBytes() => _statusBytes;

  static PrinterStatus fromMap(Map<dynamic, dynamic> map) {
    return PrinterStatus(
        statusBytes: map["statusBytes"],
        errorCode: ErrorCode.fromMap(map["errorCode"]),
        labelId: map["labelId"],
        labelType: map["labelType"],
        isACConnected: BatteryTernary.fromMap(map["isACConnected"]),
        isBatteryMounted: BatteryTernary.fromMap(map["isBatteryMounted"]),
        batteryLevel: map["batteryLevel"],
        batteryResidualQuantityLevel: map["batteryResidualQuantityLevel"],
        maxOfBatteryResidualQuantityLevel:
            map["maxOfBatteryResidualQuantityLevel"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "errorCode": errorCode.toMap(),
      "labelId": labelId,
      "labelType": labelType,
      "isACConnected": isACConnected.toMap(),
      "isBatteryMounted": isBatteryMounted.toMap(),
      "batteryLevel": batteryLevel,
      "batteryResidualQuantityLevel": batteryResidualQuantityLevel,
      "maxOfBatteryResidualQuantityLevel": maxOfBatteryResidualQuantityLevel
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

class TimeoutSetting {
  int processTimeoutSec = -1;
  int sendTimeoutSec = 90;
  int receiveTimeoutSec = 180;
  int closeWaitMSec = 500;
  int connectionWaitMSec = 500;
  int closeWaitDisusingStatusCheckSec = 3;

  TimeoutSetting(
      {this.processTimeoutSec = -1,
      this.sendTimeoutSec = 90,
      this.receiveTimeoutSec = 180,
      this.closeWaitMSec = 500,
      this.connectionWaitMSec = 500,
      this.closeWaitDisusingStatusCheckSec = 3});

  static TimeoutSetting fromMap(Map<dynamic, dynamic> map) {
    return TimeoutSetting(
        processTimeoutSec: map["processTimeoutSec"],
        sendTimeoutSec: map["sendTimeoutSec"],
        receiveTimeoutSec: map["receiveTimeoutSec"],
        closeWaitMSec: map["closeWaitMSec"],
        connectionWaitMSec: map["connectionWaitMSec"],
        closeWaitDisusingStatusCheckSec:
            map["closeWaitDisusingStatusCheckSec"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "processTimeoutSec": processTimeoutSec,
      "sendTimeoutSec": sendTimeoutSec,
      "receiveTimeoutSec": receiveTimeoutSec,
      "closeWaitMSec": closeWaitMSec,
      "connectionWaitMSec": connectionWaitMSec,
      "closeWaitDisusingStatusCheckSec": closeWaitDisusingStatusCheckSec
    };
  }
}

class PrinterSpec {
  final int seriesId;
  final int modelId;
  final int usdId;
  final int headpin;
  final int tubeHeadpin;
  final int xDpi;
  final int yDpi;
  final bool printerCase;
  final String modelName;

  const PrinterSpec(
      {this.modelId = 0,
      this.seriesId = 0,
      this.usdId = 0,
      this.headpin = 0,
      this.xDpi = 0,
      this.yDpi = 0,
      this.printerCase = false,
      this.tubeHeadpin = 0,
      this.modelName = ""});

  static PrinterSpec fromMap(Map<dynamic, dynamic> map) {
    return PrinterSpec(
        modelId: map["modelId"],
        seriesId: map["seriesId"],
        usdId: map["usdId"],
        headpin: map["headpin"],
        xDpi: map["xDpi"],
        yDpi: map["yDpi"],
        printerCase: map["printerCase"],
        tubeHeadpin: map["tubeHeadpin"],
        modelName: map["modelName"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "modelId": modelId,
      "seriesId": seriesId,
      "usdId": usdId,
      "headpin": headpin,
      "xDpi": xDpi,
      "yDpi": yDpi,
      "printerCase": printerCase,
      "tubeHeadpin": tubeHeadpin,
      "modelName": modelName
    };
  }
}

class TemplateInfo {
  final int key;
  final int fileSize;
  final int checksum;
  final DateTime modifiedDate;
  final String fileName;
  final int modifiedDateRaw;

  TemplateInfo(
      {this.key = 0,
      this.fileSize = 0,
      this.checksum = 0,
      Uint8List? modifiedDate,
      this.fileName = "",
      this.modifiedDateRaw = 0})
      : this.modifiedDate = modifiedDate != null
            ? Printer.getDate(modifiedDate)
            : new DateTime(0);

  static TemplateInfo fromMap(Map<dynamic, dynamic> map) {
    return TemplateInfo(
        key: map["key"],
        fileSize: map["fileSize"],
        checksum: map["checksum"],
        modifiedDate: map["modifiedDate"],
        fileName: map["fileName"],
        modifiedDateRaw: map["modifiedDateRaw"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "key": key,
      "fileSize": fileSize,
      "checksum": checksum,
      "modifiedDate": modifiedDate,
      "fileName": fileName,
      "modifiedDateRaw": modifiedDateRaw
    };
  }

  @override
  String toString() {
    return "key $key, fileSize $fileSize, "
        "checksum  $checksum, "
        "modifiedDate $modifiedDate, fileName $fileName, "
        "modifiedDateRaw  $modifiedDateRaw";
  }
}

class Paper {
  int mPaperId;
  double mPaperWidth;
  double mPaperHeight;
  int mImageAreaWidthDot;
  int mImageAreaHeightDot;
  int mPhysicalOffsetXDot;
  int mPhysicalOffsetYDot;
  int mLabelWidth;
  int mLabelLength;
  int mPinOffsetLeft;
  int mPinOffsetRight;
  int mLabelType;
  String mPaperName;
  String mPaperNameInch;
  int mPaperWidthDot;
  int mPaperHeightDot;

  Paper(
      {int paperId = 0,
      double paperWidth = 0,
      double paperHeight = 0,
      int paperWidthDot = 0,
      int paperHeightDot = 0,
      int leftMarginDot = 0,
      int rightMarginDot = 0,
      int imageAreaWidthDot = 0,
      int imageAreaHeightDot = 0,
      int labelWidth = 0,
      int labelLength = 0,
      int pinOffsetLeft = 0,
      int pinOffsetRight = 0,
      int labelType = 0,
      String paperName = "",
      String paperNameInch = ""})
      : this.mPaperId = paperId,
        this.mPaperWidth = paperWidth,
        this.mPaperHeight = paperHeight,
        this.mPhysicalOffsetXDot = leftMarginDot,
        this.mPhysicalOffsetYDot = rightMarginDot,
        this.mImageAreaWidthDot = imageAreaWidthDot,
        this.mImageAreaHeightDot = imageAreaHeightDot,
        this.mLabelWidth = labelWidth,
        this.mLabelLength = labelLength,
        this.mPinOffsetLeft = pinOffsetLeft,
        this.mPinOffsetRight = pinOffsetRight,
        this.mLabelType = labelType,
        this.mPaperName = paperName,
        this.mPaperNameInch = paperNameInch,
        this.mPaperWidthDot = paperWidthDot,
        this.mPaperHeightDot = paperHeightDot;

  static Paper fromMap(Map<dynamic, dynamic> map) {
    return Paper(
        paperId: map["paperId"],
        paperWidth: map["paperWidth"],
        paperHeight: map["paperHeight"],
        paperWidthDot: map["paperWidthDot"],
        paperHeightDot: map["paperHeightDot"],
        leftMarginDot: map["leftMarginDot"],
        rightMarginDot: map["rightMarginDot"],
        imageAreaWidthDot: map["imageAreaWidthDot"],
        imageAreaHeightDot: map["imageAreaHeightDot"],
        labelWidth: map["labelWidth"],
        labelLength: map["labelLength"],
        pinOffsetLeft: map["pinOffsetLeft"],
        pinOffsetRight: map["pinOffsetRight"],
        labelType: map["labelType"],
        paperName: map["paperName"],
        paperNameInch: map["paperNameInch:"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "paperId": mPaperId,
      "paperWidth": mPaperWidth,
      "paperHeight": mPaperHeight,
      "paperWidthDot": mPaperWidthDot,
      "paperHeightDot": mPaperHeightDot,
      "leftMarginDot": mPhysicalOffsetXDot,
      "rightMarginDot": mPhysicalOffsetYDot,
      "imageAreaWidthDot": mImageAreaWidthDot,
      "imageAreaHeightDot": mImageAreaHeightDot,
      "labelWidth": mLabelWidth,
      "labelLength": mLabelLength,
      "pinOffsetLeft": mPinOffsetLeft,
      "pinOffsetRight": mPinOffsetRight,
      "labelType": mLabelType,
      "paperName": mPaperName,
      "paperNameInch": mPaperNameInch
    };
  }
}

class LabelParam {
  int headPinNum = 0;
  int labelWidth;
  int labelLength;
  double paperWidth;
  double paperLength;
  int imageAreaWidth;
  int imageAreaLength;
  int pinOffsetLeft;
  int pinOffsetRight;
  int physicalOffsetX;
  int physicalOffsetY;
  int labelType;
  bool isAutoCut = false;
  bool isEndCut = false;
  bool isHalfCut = false;
  bool isSpecialTape = false;
  bool isCutMark = false;
  int tubeHeadPinNum = 0;
  String paperName;
  String paperNameInch;
  int paperID;

  LabelParam(
      {int labelWidth = 0,
      int labelLength = 0,
      double paperWidth = 0,
      double paperLength = 0,
      int imageAreaWidth = 0,
      int imageAreaLength = 0,
      int pinOffsetLeft = 0,
      int pinOffsetRight = 0,
      int physicalOffsetX = 0,
      int physicalOffsetY = 0,
      int labelType = 0,
      int paperID = 0,
      String paperName = "",
      String paperNameInch = ""})
      : this.labelWidth = labelWidth,
        this.labelLength = labelLength,
        this.paperWidth = paperWidth,
        this.paperLength = paperLength,
        this.imageAreaWidth = imageAreaWidth,
        this.imageAreaLength = imageAreaLength,
        this.pinOffsetLeft = pinOffsetLeft,
        this.pinOffsetRight = pinOffsetRight,
        this.physicalOffsetX = physicalOffsetX,
        this.physicalOffsetY = physicalOffsetY,
        this.labelType = labelType,
        this.paperName = paperName,
        this.paperNameInch = paperNameInch,
        this.paperID = paperID;

  static LabelParam fromMap(Map<dynamic, dynamic> map) {
    return LabelParam(
        labelWidth: map["labelWidth"],
        labelLength: map["labelLength"],
        paperWidth: map["paperWidth"],
        paperLength: map["paperLength"],
        imageAreaWidth: map["imageAreaWidth"],
        imageAreaLength: map["imageAreaLength"],
        pinOffsetLeft: map["pinOffsetLeft"],
        pinOffsetRight: map["pinOffsetRight"],
        physicalOffsetX: map["physicalOffsetX"],
        physicalOffsetY: map["physicalOffsetY"],
        labelType: map["labelType"],
        paperID: map["paperID"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "labelWidth": labelWidth,
      "labelLength": labelLength,
      "paperWidth": paperWidth,
      "paperLength": paperLength,
      "imageAreaWidth": imageAreaWidth,
      "imageAreaLength": imageAreaLength,
      "pinOffsetLeft": pinOffsetLeft,
      "pinOffsetRight": pinOffsetRight,
      "physicalOffsetX": physicalOffsetX,
      "physicalOffsetY": physicalOffsetY,
      "labelType": labelType,
      "paperID": paperID
    };
  }

  @override
  String toString() {
    return "{headPinNum $headPinNum, "
        "labelWidth $labelWidth, "
        "labelLength $labelLength, "
        "paperWidth $paperWidth, "
        "paperLength $paperLength, "
        "imageAreaWidth $imageAreaWidth, "
        "imageAreaLength $imageAreaLength, "
        "pinOffsetLeft $pinOffsetLeft, "
        "pinOffsetRight $pinOffsetRight,"
        "physicalOffsetX $physicalOffsetX, "
        "physicalOffsetY $physicalOffsetY,"
        "labelType $labelType,"
        "isAutoCut $isAutoCut, "
        "isEndCut  $isEndCut,"
        "isHalfCut  $isHalfCut, "
        "isSpecialTape $isSpecialTape,"
        "isCutMark $isCutMark,"
        "tubeHeadPinNum $tubeHeadPinNum, "
        "paperName $paperName, "
        "paperNameInch $paperNameInch, "
        "paperID $paperID}";
  }
}

class HealthStatus {
  final int _id;
  final String _name;
  const HealthStatus._internal(this._id, this._name);

  static const Excellent = HealthStatus._internal(0, "Excellent");
  static const Good = HealthStatus._internal(1, "Good");
  static const ReplaceSoon = HealthStatus._internal(2, "ReplaceSoon");
  static const ReplaceBattery = HealthStatus._internal(3, "ReplaceBattery");
  static const NotInstalled = HealthStatus._internal(4, "NotInstalled");

  static final List<HealthStatus> _values = [
    Excellent,
    Good,
    ReplaceSoon,
    ReplaceBattery,
    NotInstalled
  ];

  int getId() {
    return _id;
  }

  String getName() {
    return _name;
  }

  static HealthStatus valueFromID(int id) {
    for (int i = 0; i < _values.length; ++i) {
      HealthStatus num = _values[i];
      if (num.getId() == id) {
        return num;
      }
    }
    return NotInstalled;
  }

  static HealthStatus valueFromName(String name) {
    for (int i = 0; i < _values.length; ++i) {
      HealthStatus num = _values[i];
      if (num.getName() == name) {
        return num;
      }
    }
    return NotInstalled;
  }

  static HealthStatus fromMap(Map<dynamic, dynamic> map) {
    //int id = map["id"];
    String name = map["name"];
    return HealthStatus.valueFromName(name);
  }

  Map<String, dynamic> toMap() {
    return {"id": this._id, "name": this._name};
  }

  @override
  String toString() {
    return _name;
  }
}

class BatteryInfo {
  final int batteryChargeLevel;
  final int batteryHealthLevel;
  final HealthStatus batteryHealthStatus;

  BatteryInfo(
      {int chargeLevel = -1,
      int healthLevel = -1,
      HealthStatus healthStatus = HealthStatus.NotInstalled})
      : this.batteryChargeLevel = chargeLevel,
        this.batteryHealthLevel = healthLevel,
        this.batteryHealthStatus = healthStatus;

  static BatteryInfo fromMap(Map<dynamic, dynamic> map) {
    return BatteryInfo(
        chargeLevel: map["chargeLevel"],
        healthLevel: map["healthLevel"],
        healthStatus: HealthStatus.fromMap(map["healthStatus"]));
  }

  Map<String, dynamic> toMap() {
    return {
      "chargeLevel": this.batteryChargeLevel,
      "healthLevel": this.batteryHealthLevel,
      "healthStatus": this.batteryHealthStatus.toMap()
    };
  }

  @override
  String toString() {
    return "chargeLevel: $batteryChargeLevel, healthLevel: $batteryHealthLevel, healthStatus: $batteryHealthStatus";
  }
}

class NetPrinter implements ABrotherPrinter {
  String modelName;
  String serNo;
  String ipAddress;
  String macAddress;
  String nodeName;
  String location;

  NetPrinter(
      {this.modelName = "",
      this.serNo = "",
      this.ipAddress = "",
      this.macAddress = "",
      this.nodeName = "",
      this.location = ""});

  static NetPrinter fromMap(Map<dynamic, dynamic> map) {
    return NetPrinter(
        modelName: map["modelName"],
        serNo: map["serNo"],
        ipAddress: map["ipAddress"],
        macAddress: map["macAddress"],
        nodeName: map["nodeName"],
        location: map["location"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "modelName": modelName,
      "serNo": serNo,
      "ipAddress": ipAddress,
      "macAddress": macAddress,
      "nodeName": nodeName,
      "location": location
    };
  }

  @override
  String toString() {
    return "{modelName: $modelName, serNo: $serNo, ipAddress: $ipAddress, macAddress:$macAddress, nodeName: $nodeName, location: $location}";
  }

  @override
  String getName() => modelName;
}

class PaperKind {
  final String _name;

  const PaperKind._internal(this._name);

  static const ROLL = PaperKind._internal("ROLL");
  static const DIE_CUT = PaperKind._internal("DIE_CUT");
  static const MARKED_ROLL = PaperKind._internal("MARKED_ROLL");

  static final _values = [ROLL, DIE_CUT, MARKED_ROLL];

  static PaperKind fromName(String name) {
    int var2 = _values.length;

    for (int var3 = 0; var3 < var2; ++var3) {
      PaperKind d = _values[var3];
      if (d._name == name) {
        return d;
      }
    }

    return ROLL;
  }

  static PaperKind fromMap(Map<dynamic, dynamic> map) {
    String name = map["name"];
    return PaperKind.fromName(name);
  }

  Map<String, dynamic> toMap() {
    return {"name": _name};
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

class Unit {
  final String _name;
  const Unit._internal(this._name);

  static const Inch = Unit._internal("Inch");
  static const Mm = Unit._internal("Mm");

  static final _values = [Inch, Mm];

  static Unit fromName(String name) {
    int var2 = _values.length;

    for (int var3 = 0; var3 < var2; ++var3) {
      Unit d = _values[var3];
      if (d._name == name) {
        return d;
      }
    }

    return Mm;
  }

  static Unit fromMap(Map<dynamic, dynamic> map) {
    String name = map["name"];
    return Unit.fromName(name);
  }

  Map<String, dynamic> toMap() {
    return {"name": _name};
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

class CustomPaperInfo {
  final Model printerModel;
  final PaperKind paperKind;
  final Unit unit;
  final double tapeWidth;
  final double tapeLength;
  final double rightMargin;
  final double leftMargin;
  final double topMargin;
  final double bottomMargin;
  final double labelPitch;
  final double markPosition;
  final double markHeight;

  CustomPaperInfo._internal(
      this.printerModel,
      this.paperKind,
      this.unit,
      this.tapeWidth,
      this.tapeLength,
      this.rightMargin,
      this.leftMargin,
      this.topMargin,
      this.bottomMargin,
      this.labelPitch,
      this.markPosition,
      this.markHeight);

  static CustomPaperInfo newCustomRollPaper(
      Model printerModel,
      Unit unit,
      double tapeWidth,
      double rightMargin,
      double leftMargin,
      double topMargin) {
    return new CustomPaperInfo._internal(printerModel, PaperKind.ROLL, unit,
        tapeWidth, 0.0, rightMargin, leftMargin, topMargin, 0.0, 0.0, 0.0, 0.0);
  }

  static CustomPaperInfo newCustomDiaCutPaper(
      Model printerModel,
      Unit unit,
      double tapeWidth,
      double tapeLength,
      double rightMargin,
      double leftMargin,
      double topMargin,
      double bottomMargin,
      double labelPitch) {
    return new CustomPaperInfo._internal(
        printerModel,
        PaperKind.DIE_CUT,
        unit,
        tapeWidth,
        tapeLength,
        rightMargin,
        leftMargin,
        topMargin,
        bottomMargin,
        labelPitch,
        0.0,
        0.0);
  }

  static CustomPaperInfo newCustomMarkRollPaper(
      Model printerModel,
      Unit unit,
      double tapeWidth,
      double tapeLength,
      double rightMargin,
      double leftMargin,
      double topMargin,
      double bottomMargin,
      double markPosition,
      double markHeight) {
    return new CustomPaperInfo._internal(
        printerModel,
        PaperKind.MARKED_ROLL,
        unit,
        tapeWidth,
        tapeLength,
        rightMargin,
        leftMargin,
        topMargin,
        bottomMargin,
        0.0,
        markPosition,
        markHeight);
  }

  static CustomPaperInfo? fromMap(Map<dynamic, dynamic>? map) {
    if (map == null) {
      return null;
    }

    return CustomPaperInfo._internal(
        Model.fromMap(map["printerModel"]),
        PaperKind.fromMap(map["paperKind"]),
        Unit.fromMap(map["unit"]),
        map["tapeWidth"],
        map["tapeLength"],
        map["rightMargin"],
        map["leftMargin"],
        map["topMargin"],
        map["bottomMargin"],
        map["labelPitch"],
        map["markPosition"],
        map["markHeight"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "printerModel": this.printerModel.toMap(),
      "paperKind": this.paperKind.toMap(),
      "unit": this.unit.toMap(),
      "tapeWidth": this.tapeWidth,
      "tapeLength": this.tapeLength,
      "rightMargin": this.rightMargin,
      "leftMargin": this.leftMargin,
      "topMargin": this.topMargin,
      "bottomMargin": this.bottomMargin,
      "labelPitch": this.labelPitch,
      "markPosition": this.markPosition,
      "markHeight": this.markHeight
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}

abstract class ABrotherPrinter {
  String getName();
}

class BLEPrinter implements ABrotherPrinter {
  final String localName;

  BLEPrinter({this.localName = ""});

  static BLEPrinter fromMap(Map<dynamic, dynamic> map) {
    return BLEPrinter(localName: map["localName"]);
  }

  Map<String, dynamic> toMap() {
    return {"localName": localName};
  }

  @override
  String toString() {
    return "{localName: $localName}";
  }

  @override
  int get hashCode => localName.hashCode;

  @override
  bool operator ==(Object other) =>
      other is BLEPrinter && localName == other.localName;

  @override
  String getName() => localName;
}

// TODO Integrate with new API getBluetoothPrinters(List<String> modelNames)
class BluetoothPrinter implements ABrotherPrinter {
  final String modelName;
  final String macAddress;

  BluetoothPrinter({this.modelName = "", this.macAddress = ""});

  static BluetoothPrinter fromMap(Map<dynamic, dynamic> map) {
    return BluetoothPrinter(
        modelName: map["modelName"], macAddress: map["macAddress"]);
  }

  Map<String, dynamic> toMap() {
    return {"modelName": modelName, "macAddress": macAddress};
  }

  @override
  String toString() {
    return toMap().toString();
  }

  @override
  int get hashCode => macAddress.hashCode;

  @override
  bool operator ==(Object other) =>
      other is BluetoothPrinter && macAddress == other.macAddress;

  @override
  String getName() => modelName;
}

class Printer {
  static const MethodChannel _channel = const MethodChannel('another_brother');

  static final int QUALITY = 100;
  static String bytePath = "";
  static String byteFilePath = "";
  static PrinterInfo mPrinterInfo = new PrinterInfo();
  static PrinterSpec mSpec = new PrinterSpec();
  static PrinterStatus mResult = new PrinterStatus();
  static bool mCancel = false;

  String mPrinterId = new DateTime.now().millisecondsSinceEpoch.toString();
  Paper mPaper = Paper();
  String charEncode = "";

  Printer();

  static PrinterInfo getUserPrinterInfo() {
    return mPrinterInfo;
  }

  static void setUserPrinterInfo(PrinterInfo mPrinterInfo) {
    Printer.mPrinterInfo = mPrinterInfo;
    mPrinterInfo._labelName = Printer.mPrinterInfo.printerModel
        .getLabelName(mPrinterInfo.labelNameIndex);
  }

  static DateTime getDate(Uint8List bytes) {
    BigInt bi = _readBytes(bytes);
    int pwdLastSet = bi.toInt();
    int javaTime = pwdLastSet - 116444736000000000;
    javaTime = (javaTime / 10000).toInt();
    return new DateTime(javaTime);
  }

  static BigInt _readBytes(Uint8List bytes) {
    BigInt read(int start, int end) {
      if (end - start <= 4) {
        int result = 0;
        for (int i = end - 1; i >= start; i--) {
          result = result * 256 + bytes[i];
        }
        return new BigInt.from(result);
      }
      int mid = start + ((end - start) >> 1);
      var result = read(start, mid) +
          read(mid, end) * (BigInt.one << ((mid - start) * 8));
      return result;
    }

    return read(0, bytes.length);
  }

  /// Print the image file or print data file (.prn) using print settings set by setPrinterInfo.
  ///
  /// [filepath] The image (.jpg/.jpeg, .bmp, .png) file path or print data (.prn) path to be printed.
  Future<PrinterStatus> printFile(String filepath) async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
      "filePath": filepath
    };

    final Map resultMap = await _channel.invokeMethod("printFile", params);
    print("Received Result: $resultMap");

    PrinterStatus status = PrinterStatus.fromMap(resultMap);

    return status;
  }

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  // Print the text using print settings.
  Future<PrinterStatus> printText(Paragraph paragraph,
      {Offset offset = Offset.zero,
      Color background = const Color(0xFFFFFFFF)}) async {
    PictureRecorder recorder = PictureRecorder();
    Canvas c = Canvas(recorder);
    Paint paint = new Paint()..color = background;

    double height = offset.dy + paragraph.height;

    // TODO Move to constant
    if (height < 100) {
      height = 100;
    }

    c.drawRect(Rect.fromLTWH(0, 0, offset.dx + paragraph.width, height), paint);
    c.drawParagraph(paragraph, offset);
    var picture = await recorder
        .endRecording()
        .toImage(offset.dx.toInt() + paragraph.width.toInt(), height.toInt());

    return printImage(picture);
  }

  /// Print the image using print settings set by setPrinterInfo.
  Future<PrinterStatus> printImage(Image image) async {
    var imageBytes = await image.toByteData(format: ImageByteFormat.png);
    if (imageBytes == null) {
      return PrinterStatus(errorCode: ErrorCode.ERROR_UNSUPPORTED_MEDIA);
    }

    var outByteArray = Uint8List(imageBytes.lengthInBytes);
    for (int i = 0; i < imageBytes.lengthInBytes; i++) {
      outByteArray[i] = imageBytes.getUint8(i);
    }

    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
      "imageBytes": outByteArray
    };

    final Map resultMap = await _channel.invokeMethod("printImage", params);

    print("Print Result: ${resultMap} ");

    PrinterStatus status = PrinterStatus.fromMap(resultMap);

    return status;
  }

  /// Print the image files using print settings set by setPrinterInfo.
  Future<PrinterStatus> printFileList(List<String> fileList) async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
      "filePathList": fileList
    };

    final Map resultMap = await _channel.invokeMethod("printFileList", params);
    PrinterStatus status = PrinterStatus.fromMap(resultMap);

    return status;
  }

  /// Print the pdf file using print settings set by setPrinterInfo. Available on Android 5.0 or later.
  Future<PrinterStatus> printPdfFile(String filepath, int pagenum) async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
      "filePath": filepath,
      "pagenum": pagenum
    };

    final Map resultMap = await _channel.invokeMethod("printPdfFile", params);
    PrinterStatus status = PrinterStatus.fromMap(resultMap);

    return status;
  }

  /*
  /// Same functionality as printPdfFile. Available on less than Android 6.0.
  Future<PrinterStatus> printPDF(String filepath, int pagenum) async {

    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
      "filePath" : filepath,
      "pagenum" : pagenum
    };

    final Map resultMap = await _channel.invokeMethod("printPDF", params);
    PrinterStatus status = PrinterStatus.fromMap(resultMap);

    return status;

  }


  /// Same functionality as getPDFFilePages. Available on less than Android 6.0.
  Future<int> getPDFPages(String filepath) async {

    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
      "filePath" : filepath
    };

    final int pages = await _channel.invokeMethod("getPDFPages", params);

    return pages;
  }
  */

  /// Get the page count of the specified pdf file. Available on Android 5.0 or later.
  Future<int> getPdfFilePages(String filepath) async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
      "filePath": filepath
    };

    final int pages = await _channel.invokeMethod("getPDFFilePages", params);

    return pages;
  }

  /// Transfers a P-touch Template file to the printer.
  /// The template file (*.pdz, *.blf) is created by P-touch Transfer Manager,
  /// a Windows application. For Bluetooth and USB transfers, use pdz files.
  /// For all interface, use blf files.
  Future<PrinterStatus> transfer(String filepath) async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
      "filePath": filepath,
    };

    final Map resultMap = await _channel.invokeMethod("transfer", params);
    PrinterStatus status = PrinterStatus.fromMap(resultMap);

    return status;
  }

  Future<PrinterStatus> updateFirm(String filepath) async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
      "filePath": filepath,
    };

    final Map resultMap = await _channel.invokeMethod("updateFirm", params);
    PrinterStatus status = PrinterStatus.fromMap(resultMap);

    return status;
  }

  /// Send the database data described in .csv format. In addition,
  /// Updates the database for printers that have templates and databases
  /// created and linked by P-touch Editor.
  //
  //.csv data format restrictions :
  //
  //the delimiter is ,(connma) only
  //Alphanumeric & symbol in ASCII only
  //
  // This method is supported by the following printers.
  //
  //PT-E550W
  Future<PrinterStatus> sendDatabase(String filepath) async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
      "filePath": filepath,
    };

    final Map resultMap = await _channel.invokeMethod("sendDatabase", params);
    PrinterStatus status = PrinterStatus.fromMap(resultMap);

    return status;
  }

  /// Send the binary file containing the command. Since the status check is
  /// not performed, it is sent even if the printer specified by printerModel
  /// is different from the actually connected printer.
  Future<PrinterStatus> sendBinaryFile(String filepath) async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
      "filePath": filepath,
    };

    final Map resultMap = await _channel.invokeMethod("sendBinaryFile", params);
    PrinterStatus status = PrinterStatus.fromMap(resultMap);

    return status;
  }

  /// Send the binary data containing the command. Since the status check
  /// is not performed, it is sent even if the printer specified by
  /// printerModel is different from the actually connected printer.
  Future<PrinterStatus> sendBinary(Uint8List data) async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
      "data": data,
    };

    final Map resultMap = await _channel.invokeMethod("sendBinary", params);
    PrinterStatus status = PrinterStatus.fromMap(resultMap);

    return status;
  }

  Future<String> getFirmVersion() async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
    };

    final String firmVersion =
        await _channel.invokeMethod("getFirmVersion", params);

    return firmVersion;
  }

  Future<String> getMediaVersion() async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
    };

    final String mediaVersion =
        await _channel.invokeMethod("getMediaVersion", params);

    return mediaVersion;
  }

  Future<String> getSerialNumber() async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
    };

    final String serialNumber =
        await _channel.invokeMethod("getSerialNumber", params);

    return serialNumber;
  }

  Future<int> getBatteryWeak() async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
    };

    final int batteryWeak =
        await _channel.invokeMethod("getBatteryWeak", params);

    return batteryWeak;
  }

  Future<int> getBootMode() async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
    };

    final int bootMode = await _channel.invokeMethod("getBootMode", params);

    return bootMode;
  }

  Future<String> getFirmFileVer(String filePath) async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
      "filePath": filePath,
    };

    final String firmFileVersion =
        await _channel.invokeMethod("getFirmFileVer", params);

    return firmFileVersion;
  }

  Future<String> getMediaFileVer(String filePath) async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
      "filePath": filePath,
    };

    final String mediaFileVersion =
        await _channel.invokeMethod("getMediaFileVer", params);

    return mediaFileVersion;
  }

  /// Removes templates from the printer.
  Future<PrinterStatus> removeTemplate(List<int> keyList) async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
      "keyList": keyList,
    };

    final Map resultMap = await _channel.invokeMethod("removeTemplate", params);
    PrinterStatus status = PrinterStatus.fromMap(resultMap);

    return status;
  }

  /// Gets a list of the templates that have been downloaded to the printer.
  Future<PrinterStatus> getTemplateList(List<TemplateInfo> outTmplList) async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
    };

    final Map resultMap =
        await _channel.invokeMethod("getTemplateList", params);
    PrinterStatus status = PrinterStatus.fromMap(resultMap["printerStatus"]);

    final List<dynamic> templates = resultMap["templateList"];
    templates.forEach((element) {
      outTmplList.add(TemplateInfo.fromMap(element));
    });

    return status;
  }

  /// Set PrinterInfo object to specify the printer and print settings.
  Future<bool> setPrinterInfo(PrinterInfo printerInfo, {int? dpi}) async {
    mPrinterInfo = printerInfo;
    mPrinterInfo._labelName =
        mPrinterInfo.printerModel.getLabelName(mPrinterInfo.labelNameIndex);
    return true;
  }

  /// Get the printer information which is currently set.
  Future<PrinterInfo> getPrinterInfo() async {
    return mPrinterInfo;
  }

  /// Retrieves the printer status.
  Future<PrinterStatus> getPrinterStatus() async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
    };

    final Map resultMap =
        await _channel.invokeMethod("getPrinterStatus", params);
    PrinterStatus status = PrinterStatus.fromMap(resultMap);

    return status;
  }

  /// Update printer settings. See Printer Configurations for available values.
  /// Some settings are not applied until the printer is restarted. Restart
  /// the printer, then confirm the values are properly applied via
  /// getPrinterSettings after the restart.
  Future<PrinterStatus> updatePrinterSettings(
      Map<PrinterSettingItem, String> settings) async {
    final Map<Map<String, dynamic>, String> dartSettings =
        settings.map((key, value) => new MapEntry(key.toMap(), value));
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
      "settings": dartSettings
    };

    final Map resultMap =
        await _channel.invokeMethod("updatePrinterSettings", params);
    PrinterStatus status = PrinterStatus.fromMap(resultMap);

    return status;
  }

  /// Get printer settings. See Printer Configurations for available values.
  Future<PrinterStatus> getPrinterSettings(List<PrinterSettingItem> keys,
      Map<PrinterSettingItem, String> outValues) async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
      "keys":
          keys.map((printerSettingItem) => printerSettingItem.toMap()).toList()
    };

    final Map resultMap =
        await _channel.invokeMethod("getPrinterSettings", params);
    PrinterStatus status = PrinterStatus.fromMap(resultMap["printerStatus"]);
    Map<dynamic, dynamic> values = resultMap["values"];

    values.forEach((key, value) {
      outValues.putIfAbsent(PrinterSettingItem.fromMap(key), () => value);
    });

    return status;
  }

  /// Retrieves the system report of the printer like self-print contents.
  /// Available if port is other than Port.NET.
  Future<String> getSystemReport() async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
    };

    final String systemReport =
        await _channel.invokeMethod("getSystemReport", params);

    return systemReport;
  }

  /// Retrieves the battery information of the printer.
  Future<BatteryInfo> getBatteryInfo() async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
    };

    final Map resultMap = await _channel.invokeMethod("getBatteryInfo", params);

    BatteryInfo info = BatteryInfo.fromMap(resultMap);
    return info;
  }

  /// Gets Bluetooth settings from the MW series. Refer to BluetoothPreference.
  Future<PrinterStatus> getBluetoothPreference(
      BluetoothPreference btPre) async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
    };

    final Map resultMap =
        await _channel.invokeMethod("getBluetoothPreference", params);

    PrinterStatus status = PrinterStatus.fromMap(resultMap["printerStatus"]);

    BluetoothPreference resultPrefs =
        BluetoothPreference.fromMap(resultMap["btPre"]);
    btPre.authMode = resultPrefs.authMode;
    btPre.enableSsp = resultPrefs.enableSsp;
    btPre.powerMode = resultPrefs.powerMode;

    return status;
  }

  /// Updates Bluetooth settings of the MW series. Refer to BluetoothPreference.
  /// This method does not check if the request has been reflected on the
  /// device. Please check using getBluetoothPreference if needed.
  Future<PrinterStatus> updateBluetoothPreference(
      BluetoothPreference btPre) async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
      "btPre": btPre.toMap()
    };

    final Map resultMap =
        await _channel.invokeMethod("updateBluetoothPreference", params);

    PrinterStatus status = PrinterStatus.fromMap(resultMap);
    return status;
  }

  /// Start creating the command and print data string for a P-touch Template.
  /// Specify a template and the character encoding.
  /// This function assumes the default P-touch Template settings.
  /// Your application may not be able to print if the printer's settings
  /// differ from the defaults. If necessary, use the P-touch Template
  /// Setting Tool to configure the printer.
  Future<bool> startPTTPrint(int key, String encode) async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
      "key": key,
      "encode": encode
    };

    final bool success = await _channel.invokeMethod("startPTTPrint", params);

    return success;
  }

  /// Replaces the next replaceable text in a P-touch Template.
  /// Text strings are replaced in order of small object number.
  Future<bool> replaceText(String data) async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
      "data": data
    };

    final bool success = await _channel.invokeMethod("replaceText", params);

    return success;
  }

  /// Replaces the text in an object of a P-touch Template, specified by
  /// its object number.
  Future<bool> replaceTextIndex(String data, int index) async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
      "data": data,
      "index": index
    };

    final bool success =
        await _channel.invokeMethod("replaceTextIndex", params);

    return success;
  }

  /// Replaces the text in an object of a P-touch Template,
  /// specified by the object's name.
  Future<bool> replaceTextName(String data, String objectName) async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
      "data": data,
      "objectName": objectName
    };

    final bool success = await _channel.invokeMethod("replaceTextName", params);

    return success;
  }

  /// Transmits command and print data used to print a P-touch Template.
  Future<PrinterStatus> flushPTTPrint() async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
    };

    final Map resultMap = await _channel.invokeMethod("flushPTTPrint", params);
    PrinterStatus status = PrinterStatus.fromMap(resultMap);

    return status;
  }

  /// Discover printers of the given model that are connected to the
  /// same network.
  Future<List<NetPrinter>> getNetPrinters(List<String> modelName) async {
    // TODO If on iOS don't call the platform, do it at the flutter layer.

    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
      "models": modelName,
    };

    final List<dynamic> resultList =
        await _channel.invokeMethod("getNetPrinters", params);

    final List<NetPrinter> outList =
        resultList.map((netPrinter) => NetPrinter.fromMap(netPrinter)).toList();
    return outList;
  }

  /// Returns the paried printers matching the model name specified.
  Future<List<BluetoothPrinter>> getBluetoothPrinters(
      List<String> modelName) async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
      "models": modelName,
    };

    final List<dynamic> resultList =
        await _channel.invokeMethod("getBluetoothPrinters", params);

    final List<BluetoothPrinter> outList = resultList
        .map((bluetoothPrinter) => BluetoothPrinter.fromMap(bluetoothPrinter))
        .toList();
    return outList;
  }

  Future<NetPrinter> getNetPrinterInfo(String ipAddress) async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
      "ipAddress": ipAddress,
    };

    final Map resultMap =
        await _channel.invokeMethod("getNetPrinterInfo", params);

    final NetPrinter outPrinter = NetPrinter.fromMap(resultMap);
    return outPrinter;
  }

  /// Get the detail information of the media (for QL, PT, TD and RJ series)
  /// specified by setPrinterInfo.
  Future<LabelParam> getLabelParam() async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
    };

    final Map resultMap = await _channel.invokeMethod("getLabelParam", params);

    final LabelParam outLabel = LabelParam.fromMap(resultMap);
    return outLabel;
  }

  /// Retrieves the label information from the printer.
  /// Available for QL and PT series only.
  Future<LabelInfo> getLabelInfo() async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
    };

    final Map resultMap = await _channel.invokeMethod("getLabelInfo", params);

    print("Label Info: $resultMap");

    final LabelInfo outLabel = LabelInfo.fromMap(resultMap);
    return outLabel;
  }

  /// Discover printers which are connectable via BLE. Available
  /// on Android 5.0 or later.
  Future<List<BLEPrinter>> getBLEPrinters(int timeout) async {
    // TODO Consider moving this to iOS side.
    if (Platform.isIOS) {
      //BLE Scanning
      //FlutterBluePlus? flutterBlue = FlutterBluePlus();

      // Start scanning
      FlutterBluePlus.startScan(
          withServices: [Guid("A76EB9E0-F3AC-4990-84CF-3A94D2426B2B")],
          timeout: Duration(seconds: timeout ~/ 1000));

      Set<BLEPrinter> foundDevices = {};
      // Listen to scan results
      FlutterBluePlus.scanResults.listen((results) {
        for (ScanResult r in results) {
          BLEPrinter found = BLEPrinter(localName: r.device.localName);
          if (!foundDevices.contains(found)) {
            foundDevices.add(found);
          }
        }
      });

      return await Future.delayed(
          Duration(seconds: timeout ~/ 1000), () => foundDevices.toList());
    }

    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
      "timeout": timeout,
    };

    final List<dynamic> resultList =
        await _channel.invokeMethod("getBLEPrinters", params);

    final List<BLEPrinter> outList =
        resultList.map((blePrinter) => BLEPrinter.fromMap(blePrinter)).toList();
    return outList;
  }

  /// Starts a communication with the printer.
  /// Note: This does not seem to impact whether a print will succeed or not
  /// on the Android side. Printing without calling this will still print.
  Future<bool> startCommunication() async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
    };

    final bool result =
        await _channel.invokeMethod("startCommunication", params);

    print("Print Result: ${result} ");
    return result;
  }

  /// Ends a communication with the printer.
  /// Note: This does not seem to impact printing.
  Future<bool> endCommunication() async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
    };

    final bool result = await _channel.invokeMethod("endCommunication", params);

    print("Print Result: ${result} ");
    return result;
  }

  /// Cancel printing. Invalid while sending data.
  Future<bool> cancel() async {
    var params = {
      "printerId": mPrinterId,
      "printInfo": mPrinterInfo.toMap(),
    };

    final bool result = await _channel.invokeMethod("cancel", params);
    return result;
  }
}
