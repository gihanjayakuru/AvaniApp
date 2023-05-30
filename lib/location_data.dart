class LocationData {
  int id; // Add the id property

  String? location;
  /////indoor//////
  String? indoorModel;
  String? indoorModelNum;
  String? indoorSerialNum;
  String? indoorCapacity;
////outDoor///////
  String? outdoorModel;
  String? outdoorModelNum;
  String? outdoorSerialNum;
  String? outdoorCapacity;

  LocationData({
    required this.id, //  Make the id property required
    this.location,
    /////////////////
    this.indoorModel,
    this.indoorModelNum,
    this.indoorSerialNum,
    this.indoorCapacity,
    ///////////
    this.outdoorModel,
    this.outdoorModelNum,
    this.outdoorSerialNum,
    this.outdoorCapacity,
  });

  // Add a factory constructor to create a LocationData instance from a map
  factory LocationData.fromMap(Map<String, dynamic> map) {
    return LocationData(
      id: map['id'],
      location: map['location'],
      ///////
      indoorModel: map['indoorModel'],
      indoorModelNum: map['indoorModelNum'],
      indoorSerialNum: map['indoorSerialNum'],
      indoorCapacity: map['indoorCapacity'],
      //////
      outdoorModel: map['outdoorModel'],
      outdoorModelNum: map['outdoorModelNum'],
      outdoorSerialNum: map['outdoorSerialNum'],
      outdoorCapacity: map['outdoorCapacity'],
    );
  }

  // Add a method to convert a LocationData instance to a map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'location': location,
      /////
      'indoorModel': indoorModel,
      'indoorModelNum': indoorModelNum,
      'indoorSerialNum': indoorSerialNum,
      'indoorCapacity': indoorCapacity,
      //////
      'outdoorModel': outdoorModel,
      'outdoorModelNum': outdoorModelNum,
      'outdoorSerialNum': outdoorSerialNum,
      'outdoorCapacity': outdoorCapacity,
    };
  }
}
