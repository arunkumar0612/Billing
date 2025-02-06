// class ProductDetail {
//   String productName;
//   int productQuantity;

//   ProductDetail({required this.productName, required this.productQuantity});

//   // Convert ProductDetail to Map (useful for JSON serialization if needed)
//   Map<String, dynamic> toMap() {
//     return {
//       'productName': productName,
//       'productQuantity': productQuantity,
//     };
//   }

//   // Factory method to create ProductDetail from Map
//   factory ProductDetail.fromMap(Map<String, dynamic> map) {
//     return ProductDetail(
//       productName: map['productName'] ?? '',
//       productQuantity: map['productQuantity'] ?? 0,
//     );
//   }
// }

class Recommendation {
  final String key;
  final String value;

  Recommendation({
    required this.key,
    required this.value,
  });

  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      key: json['key'] as String,
      value: json['value'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
    };
  }
}

class Note {
  final String notename;

  Note({required this.notename});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      notename: json['notename'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notename': notename,
    };
  }
}
