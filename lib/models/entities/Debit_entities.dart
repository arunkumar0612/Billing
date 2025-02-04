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

class DebitGSTtotals {
  final String key;
  final String value;

  DebitGSTtotals({
    required this.key,
    required this.value,
  });

  factory DebitGSTtotals.fromJson(Map<String, dynamic> json) {
    return DebitGSTtotals(
      key: json['GST'] as String,
      value: json['total'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'GST': key,
      'total': value,
    };
  }
}
