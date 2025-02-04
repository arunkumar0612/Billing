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

class CreditGSTtotals {
  final double gst;
  final double total;

  CreditGSTtotals({
    required this.gst,
    required this.total,
  });

  factory CreditGSTtotals.fromJson(Map<String, dynamic> json) {
    return CreditGSTtotals(
      gst: json['GST'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'GST': gst,
      'total': total,
    };
  }
}
