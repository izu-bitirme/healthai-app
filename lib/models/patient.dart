class Patient {
  late double? height_before;
  late double? weight;

  Patient({required this.height_before, required this.weight});

  factory Patient.fromJson(Map<dynamic, dynamic> json) {
    return Patient(
      height_before: double.parse(json['height_before']),
      weight: double.parse(json['weight']),
    );
  }
}
