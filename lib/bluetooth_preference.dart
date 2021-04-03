class AuthMode {
  final int _command;

  const AuthMode._internal(this._command);

  static const AUTH_NO_ENC_NO = AuthMode._internal(0);
  static const AUTH_OFF_ENC_OFF = AuthMode._internal(48);
  static const AUTH_ON_ENC_OFF = AuthMode._internal(50);
  static const AUTH_ON_ENC_ON = AuthMode._internal(51);
  static const NOCHANGE = AuthMode._internal(255);

  static final List<AuthMode> _values = [
    AUTH_NO_ENC_NO,
    AUTH_OFF_ENC_OFF,
    AUTH_ON_ENC_OFF,
    AUTH_ON_ENC_ON,
    NOCHANGE
  ];

  static AuthMode getAuthMode(int command) {
    List<AuthMode> values = _values;
    int length = values.length;

    for (int i = 0; i < length; ++i) {
      AuthMode mode = values[i];
      if (mode.getCommand() == command) {
        return mode;
      }
    }

    return NOCHANGE;
  }

  int getCommand() {
    return this._command;
  }

  static AuthMode fromMap(Map<dynamic, dynamic> map) {
    int id = map["command"];
    return AuthMode.getAuthMode(id);
  }

  Map<String, dynamic> toMap() {
    return {"command": this._command};
  }
}

class SSP {
  final int _command;

  const SSP._internal(this._command);

  static const ENABLE = SSP._internal(48);
  static const DISABLE = SSP._internal(49);
  static const NOCHANGE = SSP._internal(255);

  static final List<SSP> _values = [ENABLE, DISABLE, NOCHANGE];

  static SSP getSsp(int command) {
    List<SSP> var1 = _values;
    int var2 = var1.length;

    for (int var3 = 0; var3 < var2; ++var3) {
      SSP mode = var1[var3];
      if (mode.getCommand() == command) {
        return mode;
      }
    }

    return NOCHANGE;
  }

  int getCommand() {
    return this._command;
  }

  static SSP fromMap(Map<dynamic, dynamic> map) {
    int id = map["command"];
    return SSP.getSsp(id);
  }

  Map<String, dynamic> toMap() {
    return {"command": this._command};
  }
}

class PowerSaveMode {
  final int _command;

  const PowerSaveMode._internal(this._command);

  static const CONNECTION_MODE = PowerSaveMode._internal(0);
  static const STANDARD_MODE = PowerSaveMode._internal(1);
  static const ECO_MODE = PowerSaveMode._internal(2);
  static const PRE_CONNECTION_MODE = PowerSaveMode._internal(3);
  static const PRE_STANDARD_MODE = PowerSaveMode._internal(4);
  static const PRE_ECO_MODE = PowerSaveMode._internal(5);
  static const NOCHANGE = PowerSaveMode._internal(255);

  static final List<PowerSaveMode> _values = [
    CONNECTION_MODE,
    STANDARD_MODE,
    ECO_MODE,
    PRE_CONNECTION_MODE,
    PRE_STANDARD_MODE,
    PRE_ECO_MODE,
    NOCHANGE
  ];

  static PowerSaveMode getPowerSaveMode(int command) {
    List<PowerSaveMode> var1 = _values;
    int var2 = var1.length;

    for (int var3 = 0; var3 < var2; ++var3) {
      PowerSaveMode mode = var1[var3];
      if (mode.getCommand() == command) {
        return mode;
      }
    }

    return NOCHANGE;
  }

  int getCommand() {
    return this._command;
  }

  static PowerSaveMode fromMap(Map<dynamic, dynamic> map) {
    int id = map["command"];
    return PowerSaveMode.getPowerSaveMode(id);
  }

  Map<String, dynamic> toMap() {
    return {"command": this._command};
  }

}

class BluetoothPreference {
  SSP enableSsp;
  PowerSaveMode powerMode;
  AuthMode authMode;

  BluetoothPreference({this.enableSsp = SSP.NOCHANGE,
    this.powerMode = PowerSaveMode.NOCHANGE,
    this.authMode = AuthMode.AUTH_NO_ENC_NO});

  static BluetoothPreference fromMap(Map<dynamic, dynamic> map) {
    return BluetoothPreference(
      enableSsp: SSP.fromMap(map["enableSsp"]),
        powerMode: PowerSaveMode.fromMap(map["powerMode"]),
        authMode: AuthMode.fromMap(map["authMode"])
    );
  }

  Map<String, dynamic> toMap() {
    return
      {
        "enableSsp": enableSsp.toMap(),
      "powerMode": powerMode.toMap(),
        "authMode": authMode.toMap()
      };
  }

}