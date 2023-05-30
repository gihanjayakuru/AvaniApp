class MergedData {
  int id;
  final String createdDate;
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
///////////////////////////////////////////////////////
  final String filterClean;
  final String blowerCheck;
  final String indoorInspectCleanIduCoilFins;
  final String checkCleanDrainPlate;
  final String drainPumpCheck;
  final String checkPipingDuckInsulation;
  final String checkNoise;
  final String indoorHousingCondition;
  final String indoorPcbStatus;
/////////////////////////////////
  final String compressorNoise;
  final String fanNoise;
  final String outdoorInspectCleanIduCoilFins;
  final String outdoorPcbStatus;
  final String outdoorHousingCondition;
  //////////////////////
  final String acSlidinDoorOperation;
  final String thermostatSetting;
  final String drainLineClean;
  ////////////////////////////////////
  final String remark;
  final String date;
  final String technicianName;

  MergedData({
    required this.id,
    required this.createdDate,
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
    ////////////////////
    required this.filterClean,
    required this.blowerCheck,
    required this.indoorInspectCleanIduCoilFins,
    required this.checkCleanDrainPlate,
    required this.drainPumpCheck,
    required this.checkPipingDuckInsulation,
    required this.checkNoise,
    required this.indoorHousingCondition,
    required this.indoorPcbStatus,
    ////////////////////////////
    required this.compressorNoise,
    required this.fanNoise,
    required this.outdoorInspectCleanIduCoilFins,
    required this.outdoorPcbStatus,
    required this.outdoorHousingCondition,
    ////////////////////////////////////
    required this.acSlidinDoorOperation,
    required this.thermostatSetting,
    required this.drainLineClean,
    ////////////////////////////
    required this.remark,
    required this.date,
    required this.technicianName,
  });

  factory MergedData.fromJson(Map<String, dynamic> json) {
    return MergedData(
      id: json['id'],
      // Assign an empty string if the value is null
      createdDate: json['createdDate'] ?? '',
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
      /////////////////////////
      filterClean: json['filterClean'] ?? '',
      blowerCheck: json['blowerCheck'] ?? '',
      indoorInspectCleanIduCoilFins:
          json['indoorInspectCleanIduCoilFins'] ?? '',
      checkCleanDrainPlate: json['checkCleanDrainPlate'] ?? '',
      drainPumpCheck: json['drainPumpCheck'] ?? '',
      checkPipingDuckInsulation: json['checkPipingDuckInsulation'] ?? '',
      checkNoise: json['checkNoise'] ?? '',
      indoorHousingCondition: json['indoorHousingCondition'] ?? '',
      indoorPcbStatus: json['indoorPcbStatus'] ?? '',
      //////////////////////////////////////////////
      compressorNoise: json['compressorNoise'] ?? '',
      fanNoise: json['fanNoise'] ?? '',
      outdoorInspectCleanIduCoilFins:
          json['outdoorInspectCleanIduCoilFins'] ?? '',
      outdoorPcbStatus: json['outdoorPcbStatus'] ?? '',
      outdoorHousingCondition: json['outdoorHousingCondition'] ?? '',
      ///////////////////////////////////////////
      acSlidinDoorOperation: json['acSlidinDoorOperation'] ?? '',
      thermostatSetting: json['thermostatSetting'] ?? '',
      drainLineClean: json['drainLineClean'] ?? '',
      /////////////////////////////////////////////
      remark: json['remark'] ?? '',
      date: json['date'] ?? '',
      technicianName: json['technicianName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdDate': createdDate,
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
      //////////////////////////////////////
      'filterClean': filterClean,
      'blowerCheck': blowerCheck,
      'indoorInspectCleanIduCoilFins': indoorInspectCleanIduCoilFins,
      'checkCleanDrainPlate': checkCleanDrainPlate,
      'drainPumpCheck': drainPumpCheck,
      'checkPipingDuckInsulation': checkPipingDuckInsulation,
      'checkNoise': checkNoise,
      'indoorHousingCondition': indoorHousingCondition,
      'indoorPcbStatus': indoorPcbStatus,
      /////////////////////////////////
      'compressorNoise': compressorNoise,
      'fanNoise': fanNoise,
      'outdoorInspectCleanIduCoilFins': outdoorInspectCleanIduCoilFins,
      'outdoorPcbStatus': outdoorPcbStatus,
      'outdoorHousingCondition': outdoorHousingCondition,
      ///////////////////////////////////////
      'acSlidinDoorOperation': acSlidinDoorOperation,
      'thermostatSetting': thermostatSetting,
      'drainLineClean': drainLineClean,
      ///////////////////////////
      'remark': remark,
      'date': date,
      'technicianName': technicianName,
    };
  }
}
