class FormData {
  String location;
  String filterClean;
  String blowerCheck;
  String inspectCleanIduCoilFins;
  String checkCleanDrainPlate;
  String drainPumpCheck;
  String checkPipingDuckInsulation;
  String checkNoise;
  String indoorHousingCondition;
  String pcbStatus;

  String acSlidinDoorOperation;
  String thermostatSetting;
  String drainLineClean;

  String compressorNoise;
  String fanNoise;
  String outdoorHousingCondition;
  String remark;
  String date;
  String technicianName;

  FormData({
    required this.location,
    required this.filterClean,
    required this.blowerCheck,
    required this.inspectCleanIduCoilFins,
    required this.checkCleanDrainPlate,
    required this.drainPumpCheck,
    required this.checkPipingDuckInsulation,
    required this.checkNoise,
    required this.indoorHousingCondition,
    required this.pcbStatus,
    required this.acSlidinDoorOperation,
    required this.thermostatSetting,
    required this.drainLineClean,
    required this.compressorNoise,
    required this.fanNoise,
    required this.outdoorHousingCondition,
    required this.remark,
    required this.date,
    required this.technicianName,
  });

  Map<String, dynamic> toJson() {
    return {
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
//  location: json['location'] ?? '',
//         filterClean: json['filterClean'] ?? '',
//         blowerCheck: json['blowerCheck'] ?? '',
//         inspectCleanIduCoilFins: json['inspectCleanIduCoilFins'] ?? '',
//         checkCleanDrainPlate: json['checkCleanDrainPlate'] ?? '',
//         drainPumpCheck: json['drainPumpCheck'] ?? '',
//         checkPipingDuckInsulation: json['checkPipingDuckInsulation'] ?? '',
//         checkNoise: json['checkNoise'] ?? '',
//         indoorHousingCondition: json['indoorHousingCondition'] ?? '',
//         pcbStatus: json['pcbStatus'] ?? '',
//         acSlidinDoorOperation: json['acSlidinDoorOperation'] ?? '',
//         thermostatSetting: json['thermostatSetting'] ?? '',
//         drainLineClean: json['drainLineClean'] ?? '',
//         compressorNoise: json['compressorNoise'] ?? '',
//         fanNoise: json['fanNoise'] ?? '',
//         outdoorHousingCondition: json['outdoorHousingCondition'] ?? '',
//         remark: json['remark'] ?? '',
//         date: json['date'] ?? '',
//         technicianName: json['technicianName'] ?? '',

  // factory FormData.fromJson(Map<String, dynamic> json) {
  //   return FormData(
  //     location: json['location'],
  //     filterClean: json['filterClean'],
  //     filterClean2: json['filterClean2'],
  //     blowerCheck: json['blowerCheck'],
  //     inspectCleanIduCoilFins: json['inspectCleanIduCoilFins'],
  //     checkCleanDrainPlate: json['checkCleanDrainPlate'],
  //     drainPumpCheck: json['drainPumpCheck'],
  //     checkPipingDuckInsulation: json['checkPipingDuckInsulation'],
  //     checkNoise: json['checkNoise'],
  //     indoorHousingCondition: json['indoorHousingCondition'],
  //     pcbStatus: json['pcbStatus'],
  //     acSlidinDoorOperation: json['acSlidinDoorOperation'],
  //     thermostatSetting: json['thermostatSetting'],
  //     drainLineClean: json['drainLineClean'],
  //     compressorNoise: json['compressorNoise'],
  //     fanNoise: json['fanNoise'],
  //     outdoorHousingCondition: json['outdoorHousingCondition'],
  //     remark: json['remark'],
  //     date: json['date'],
  //     technicianName: json['technicianName'],
  //   );
  // }
  factory FormData.fromJson(Map<String, dynamic> json) {
    try {
      return FormData(
        location: json['location'] ?? '',
        filterClean: json['filterClean'] ?? '',
        blowerCheck: json['blowerCheck'] ?? '',
        inspectCleanIduCoilFins: json['inspectCleanIduCoilFins'] ?? '',
        checkCleanDrainPlate: json['checkCleanDrainPlate'] ?? '',
        drainPumpCheck: json['drainPumpCheck'] ?? '',
        checkPipingDuckInsulation: json['checkPipingDuckInsulation'] ?? '',
        checkNoise: json['checkNoise'] ?? '',
        indoorHousingCondition: json['indoorHousingCondition'] ?? '',
        pcbStatus: json['pcbStatus'] ?? '',
        acSlidinDoorOperation: json['acSlidinDoorOperation'] ?? '',
        thermostatSetting: json['thermostatSetting'] ?? '',
        drainLineClean: json['drainLineClean'] ?? '',
        compressorNoise: json['compressorNoise'] ?? '',
        fanNoise: json['fanNoise'] ?? '',
        outdoorHousingCondition: json['outdoorHousingCondition'] ?? '',
        remark: json['remark'] ?? '',
        date: json['date'] ?? '',
        technicianName: json['technicianName'] ?? '',
      );
    } catch (e) {
      print('Error parsing FormData from JSON: $e');
      rethrow; // Rethrow the exception to propagate it further if needed
    }
  }
}
