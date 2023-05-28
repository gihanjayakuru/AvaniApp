class MergedData {
  int id;
  final String location;
  final String beforeRoomTemperature;
  final String beforeSetPointTemperature;
  final String beforeSupplyGrillTemperature;
  final String beforeReturnGrillTemperature;
  final String beforeGasPressureLowSide;
  final String beforeGasPressureHighSide;
  final String beforeAmp;
  final String afterRoomTemperature;
  final String afterSetPointTemperature;
  final String afterSupplyGrillTemperature;
  final String afterReturnGrillTemperature;
  final String afterGasPressureLowSide;
  final String afterGasPressureHighSide;
  final String afterAmp;

  MergedData({
    required this.id,
    required this.location,
    required this.beforeRoomTemperature,
    required this.beforeSetPointTemperature,
    required this.beforeSupplyGrillTemperature,
    required this.beforeReturnGrillTemperature,
    required this.beforeGasPressureLowSide,
    required this.beforeGasPressureHighSide,
    required this.beforeAmp,
    required this.afterRoomTemperature,
    required this.afterSetPointTemperature,
    required this.afterSupplyGrillTemperature,
    required this.afterReturnGrillTemperature,
    required this.afterGasPressureLowSide,
    required this.afterGasPressureHighSide,
    required this.afterAmp,
  });

  factory MergedData.fromJson(Map<String, dynamic> json) {
    return MergedData(
      id: json['id'],
      // Assign an empty string if the value is null
      location: json['location'] ?? '',
      beforeRoomTemperature: json['beforeRoomTemperature'] ?? '',
      beforeSetPointTemperature: json['beforeSetPointTemperature'] ?? '',
      beforeSupplyGrillTemperature: json['beforeSupplyGrillTemperature'] ?? '',
      beforeReturnGrillTemperature: json['beforeReturnGrillTemperature'] ?? '',
      beforeGasPressureLowSide: json['beforeGasPressureLowSide'] ?? '',
      beforeGasPressureHighSide: json['beforeGasPressureHighSide'] ?? '',
      beforeAmp: json['beforeAmp'] ?? '',
      afterRoomTemperature: json['afterRoomTemperature'] ?? '',
      afterSetPointTemperature: json['afterSetPointTemperature'] ?? '',
      afterSupplyGrillTemperature: json['afterSupplyGrillTemperature'] ?? '',
      afterReturnGrillTemperature: json['afterReturnGrillTemperature'] ?? '',
      afterGasPressureLowSide: json['afterGasPressureLowSide'] ?? '',
      afterGasPressureHighSide: json['afterGasPressureHighSide'] ?? '',
      afterAmp: json['afterAmp'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'location': location,
      'beforeRoomTemperature': beforeRoomTemperature,
      'beforeSetPointTemperature': beforeSetPointTemperature,
      'beforeSupplyGrillTemperature': beforeSupplyGrillTemperature,
      'beforeReturnGrillTemperature': beforeReturnGrillTemperature,
      'beforeGasPressureLowSide': beforeGasPressureLowSide,
      'beforeGasPressureHighSide': beforeGasPressureHighSide,
      'beforeAmp': beforeAmp,
      'afterRoomTemperature': afterRoomTemperature,
      'afterSetPointTemperature': afterSetPointTemperature,
      'afterSupplyGrillTemperature': afterSupplyGrillTemperature,
      'afterReturnGrillTemperature': afterReturnGrillTemperature,
      'afterGasPressureLowSide': afterGasPressureLowSide,
      'afterGasPressureHighSide': afterGasPressureHighSide,
      'afterAmp': afterAmp,
    };
  }
}
