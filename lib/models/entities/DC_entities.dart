class Recommendation {
  final String key;
  final String value;

  Recommendation({
    required this.key,
    required this.value,
  });

  // Factory method to create a Recommendation from JSON.
  factory Recommendation.fromJson(Map<String, dynamic> json) {
    return Recommendation(
      key: json['key'] as String,
      value: json['value'] as String,
    );
  }

  // Method to convert the Recommendation to JSON.
  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
    };
  }
}
