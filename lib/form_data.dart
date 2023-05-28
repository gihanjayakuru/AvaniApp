class FormData {
  int id; // Add the id property

  String? location;
  String? filterClean;
  String? blowerCheck;
  String? indoorInspectCleanIduCoilFins;
  String? checkCleanDrainPlate;
  String? drainPumpCheck;
  String? checkPipingDuckInsulation;
  String? checkNoise;
  String? indoorHousingCondition;
  String? indoorPcbStatus;
/////////////////////////////////
  String? compressorNoise;
  String? fanNoise;
  String? outdoorInspectCleanIduCoilFins;
  String? outdoorPcbStatus;
  String? outdoorHousingCondition;
  //////////////////////
  String? acSlidinDoorOperation;
  String? thermostatSetting;
  String? drainLineClean;
  ////////////////////////////////////
  String? remark;
  String? date;
  String? technicianName;

  FormData({
    required this.id, //  Make the id property required
    this.location,
    this.filterClean,
    this.blowerCheck,
    this.indoorInspectCleanIduCoilFins,
    this.checkCleanDrainPlate,
    this.drainPumpCheck,
    this.checkPipingDuckInsulation,
    this.checkNoise,
    this.indoorHousingCondition,
    this.indoorPcbStatus,
    ////////////////////////////
    this.compressorNoise,
    this.fanNoise,
    this.outdoorInspectCleanIduCoilFins,
    this.outdoorPcbStatus,
    this.outdoorHousingCondition,
    ////////////////////////////////////
    this.acSlidinDoorOperation,
    this.thermostatSetting,
    this.drainLineClean,
    ////////////////////////////
    this.remark,
    this.date,
    this.technicianName,
  });

  // Add a factory constructor to create a FormData instance from a map
  factory FormData.fromMap(Map<String, dynamic> map) {
    return FormData(
      id: map['id'],
      location: map['location'],
      filterClean: map['filterClean'],
      blowerCheck: map['blowerCheck'],
      indoorInspectCleanIduCoilFins: map['indoorInspectCleanIduCoilFins'],
      checkCleanDrainPlate: map['checkCleanDrainPlate'],
      drainPumpCheck: map['drainPumpCheck'],
      checkPipingDuckInsulation: map['checkPipingDuckInsulation'],
      checkNoise: map['checkNoise'],
      indoorHousingCondition: map['indoorHousingCondition'],
      indoorPcbStatus: map['indoorPcbStatus'],
      //////////////////////////////////////////////
      compressorNoise: map['compressorNoise'],
      fanNoise: map['fanNoise'],
      outdoorInspectCleanIduCoilFins: map['outdoorInspectCleanIduCoilFins'],
      outdoorPcbStatus: map['outdoorPcbStatus'],
      outdoorHousingCondition: map['outdoorHousingCondition'],
      ///////////////////////////////////////////
      acSlidinDoorOperation: map['acSlidinDoorOperation'],
      thermostatSetting: map['thermostatSetting'],
      drainLineClean: map['drainLineClean'],
      /////////////////////////////////////////////
      remark: map['remark'],
      date: map['date'],
      technicianName: map['technicianName'],
    );
  }

  // Add a method to convert a FormData instance to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'location': location,
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
