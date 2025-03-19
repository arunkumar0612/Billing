import 'dart:typed_data';

class OrganizationData {
  String id;
  String name;
  String email;
  Uint8List logo;
  bool isSelected;

  OrganizationData({
    required this.id,
    required this.name,
    required this.email,
    required this.logo,
    this.isSelected = false,
  });

  // Convert JSON to OrganizationData object
  factory OrganizationData.fromJson(Map<String, dynamic> json) {
    Uint8List? fileBytes;
    if (json['Organization_Logo'] != null && json['Organization_Logo']['data'] != null) {
      try {
        fileBytes = Uint8List.fromList(List<int>.from(json['Organization_Logo']['data']));
      } catch (e) {
        print("Error parsing logo bytes: $e");
      }
    }
    return OrganizationData(
      id: json['Organization_id'].toString() ?? '',
      name: json['Organization_Name'] ?? '',
      email: json['Email_id'] ?? '',
      logo: fileBytes ?? Uint8List(0),
      isSelected: false,
    );
  }

  // Convert OrganizationData object to JSON
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'email': email,
      'logo': logo,
      'isSelected': isSelected,
    };
  }
}
