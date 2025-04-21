class DoctorModel {
  late int id;
  late String username;
  late String? fullName;
  late String? specialty;
  late String? licenseNumber;

  DoctorModel.fromJson(json) {
    id = json['id'];
    username = json['username'];
    fullName = json['full_name'];
    specialty = json['specialty'];
    licenseNumber = json['license_number'];
  }
  static List<DoctorModel> fromJsonList(dynamic list) {
    List<DoctorModel> result = [];
    list.forEach((e) => result.add(DoctorModel.fromJson(e)));
    return result;
  } 
}
