class MergedData {
  int id;
  final String location;
  final String serviceType;
  final String serviceDescription;
  final String createdDate;

  MergedData({
    required this.id,
    required this.location,
    required this.serviceType,
    required this.serviceDescription,
    required this.createdDate,
  });

  factory MergedData.fromJson(Map<String, dynamic> json) {
    return MergedData(
      id: json['id'], // Assign an empty string if the value is null
      location:
          json['location'] ?? '', // Assign an empty string if the value is null
      serviceType: json['serviceType'] ??
          '', // Assign an empty string if the value is null
      serviceDescription: json['serviceDescription'] ??
          '', // Assign an empty string if the value is null
      createdDate: json['createdDate'] ??
          '', // Assign an empty string if the value is null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'location': location,
      'serviceType': serviceType,
      'serviceDescription': serviceDescription,
      'createdDate': createdDate,
    };
  }
}
