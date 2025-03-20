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

class CompanyData {
  String id;
  String name;
  String email;
  Uint8List logo;
  bool isSelected;

  CompanyData({
    required this.id,
    required this.name,
    required this.email,
    required this.logo,
    this.isSelected = false,
  });

  // Convert JSON to OrganizationData object
  factory CompanyData.fromJson(Map<String, dynamic> json) {
    Uint8List? fileBytes;
    if (json['Customer_Logo'] != null && json['Customer_Logo']['data'] != null) {
      try {
        fileBytes = Uint8List.fromList(List<int>.from(json['Customer_Logo']['data']));
      } catch (e) {
        print("Error parsing logo bytes: $e");
      }
    }
    return CompanyData(
      id: json['Customer_id'].toString() ?? '',
      name: json['Customer_name'] ?? '',
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

class BranchData {
  String id;
  String name;
  String email;
  Uint8List logo;
  bool isSelected;

  BranchData({
    required this.id,
    required this.name,
    required this.email,
    required this.logo,
    this.isSelected = false,
  });

  // Convert JSON to OrganizationData object
  factory BranchData.fromJson(Map<String, dynamic> json) {
    Uint8List? fileBytes;
    if (json['Branch_Logo'] != null && json['Branch_Logo']['data'] != null) {
      try {
        fileBytes = Uint8List.fromList(List<int>.from(json['Branch_Logo']['data']));
      } catch (e) {
        print("Error parsing logo bytes: $e");
      }
    }
    return BranchData(
      id: json['Branch_id'].toString() ?? '',
      name: json['Branch_name'] ?? '',
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
