class FormData {
  String location;
  String indoorModel;
  String indoorModelNum;
  String indoorSerialNum;
  String indoorCapacity;
  String outdoorModel;
  String outdoorModelNum;
  String outdoorSerialNum;
  String outdoorCapacity;
  DateTime createdDate;
  // String additionalField1; // New additional field
  // String additionalField2; // New additional field

  FormData({
    required this.location,
    required this.indoorModel,
    required this.indoorModelNum,
    required this.indoorSerialNum,
    required this.indoorCapacity,
    required this.outdoorModel,
    required this.outdoorModelNum,
    required this.outdoorSerialNum,
    required this.outdoorCapacity,
    required this.createdDate,
    // required this.additionalField1,
    // required this.additionalField2,
  });

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'indoorModel': indoorModel,
      'indoorModelNum': indoorModelNum,
      'indoorSerialNum': indoorSerialNum,
      'indoorCapacity': indoorCapacity,
      'outdoorModel': outdoorModel,
      'outdoorModelNum': outdoorModelNum,
      'outdoorSerialNum': outdoorSerialNum,
      'outdoorCapacity': outdoorCapacity,
      'createdDate': createdDate.toIso8601String(),
      // 'additionalField1': additionalField1, // Serialize additional field
      // 'additionalField2': additionalField2, // Serialize additional field
    };
  }

  factory FormData.fromJson(Map<String, dynamic> json) {
    return FormData(
      location: json['location'],
      indoorModel: json['indoorModel'],
      indoorModelNum: json['indoorModelNum'],
      indoorSerialNum: json['indoorSerialNum'],
      indoorCapacity: json['indoorCapacity'],
      outdoorModel: json['outdoorModel'],
      outdoorModelNum: json['outdoorModelNum'],
      outdoorSerialNum: json['outdoorSerialNum'],
      outdoorCapacity: json['outdoorCapacity'],
      createdDate: DateTime.parse(json['createdDate']),
      // additionalField1:
      //     json['additionalField1'], // Deserialize additional field
      // additionalField2:
      //     json['additionalField2'], // Deserialize additional field
    );
  }
}
