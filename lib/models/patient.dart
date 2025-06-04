class Patient {
  late double? height_before;
  late double? weight;

  Patient({required this.height_before, required this.weight});

  factory Patient.fromJson(Map<dynamic, dynamic> json) {
    return Patient(
      height_before:
          json['height_before'] != null
              ? double.parse(json['height_before'])
              : null,
      weight: json['weight'] != null ? double.parse(json['weight']) : null,
    );
  }
}
