class MergedData {
  final String location;
  final String serviceType;
  final String serviceDescription;

  MergedData({
    required this.location,
    required this.serviceType,
    required this.serviceDescription,
  });

  factory MergedData.fromJson(Map<String, dynamic> json) {
    return MergedData(
      location: json['location'],
      serviceType: json['serviceType'],
      serviceDescription: json['serviceDescription'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'location': location,
      'serviceType': serviceType,
      'serviceDescription': serviceDescription,
    };
  }
}
