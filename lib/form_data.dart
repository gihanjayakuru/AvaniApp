class FormData {
  int id; // Add the id property

  String? location;
  String? filterClean;
  String? blowerCheck;
  String? inspectCleanIduCoilFins;
  String? checkCleanDrainPlate;
  String? drainPumpCheck;
  String? checkPipingDuckInsulation;
  String? checkNoise;
  String? indoorHousingCondition;
  String? pcbStatus;
  String? acSlidinDoorOperation;
  String? thermostatSetting;
  String? drainLineClean;
  String? compressorNoise;
  String? fanNoise;
  String? outdoorHousingCondition;
  String? remark;
  String? date;
  String? technicianName;

  FormData({
    required this.id, //  Make the id property required
    this.location,
    this.filterClean,
    this.blowerCheck,
    this.inspectCleanIduCoilFins,
    this.checkCleanDrainPlate,
    this.drainPumpCheck,
    this.checkPipingDuckInsulation,
    this.checkNoise,
    this.indoorHousingCondition,
    this.pcbStatus,
    this.acSlidinDoorOperation,
    this.thermostatSetting,
    this.drainLineClean,
    this.compressorNoise,
    this.fanNoise,
    this.outdoorHousingCondition,
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
      inspectCleanIduCoilFins: map['inspectCleanIduCoilFins'],
      checkCleanDrainPlate: map['checkCleanDrainPlate'],
      drainPumpCheck: map['drainPumpCheck'],
      checkPipingDuckInsulation: map['checkPipingDuckInsulation'],
      checkNoise: map['checkNoise'],
      indoorHousingCondition: map['indoorHousingCondition'],
      pcbStatus: map['pcbStatus'],
      acSlidinDoorOperation: map['acSlidinDoorOperation'],
      thermostatSetting: map['thermostatSetting'],
      drainLineClean: map['drainLineClean'],
      compressorNoise: map['compressorNoise'],
      fanNoise: map['fanNoise'],
      outdoorHousingCondition: map['outdoorHousingCondition'],
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
      'inspectCleanIduCoilFins': inspectCleanIduCoilFins,
      'checkCleanDrainPlate': checkCleanDrainPlate,
      'drainPumpCheck': drainPumpCheck,
      'checkPipingDuckInsulation': checkPipingDuckInsulation,
      'checkNoise': checkNoise,
      'indoorHousingCondition': indoorHousingCondition,
      'pcbStatus': pcbStatus,
      'acSlidinDoorOperation': acSlidinDoorOperation,
      'thermostatSetting': thermostatSetting,
      'drainLineClean': drainLineClean,
      'compressorNoise': compressorNoise,
      'fanNoise': fanNoise,
      'outdoorHousingCondition': outdoorHousingCondition,
      'remark': remark,
      'date': date,
      'technicianName': technicianName,
    };
  }
}
