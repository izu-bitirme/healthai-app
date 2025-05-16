class DoctorModel {
  late int id;
  late String username;
  late String? fullName;
  late String? specialty;
  late String? licenseNumber;
  late String? image;

  DoctorModel.fromJson(Map<String, dynamic> json)  {
    id = json['userId'];
    username = json['username'];
    fullName = json['full_name'];
    specialty = json['specialty'];
    licenseNumber = json['license_number'];
    image = json['avatar'];
  }

  static List<DoctorModel> fromJsonList(List<dynamic> list) {
    List<DoctorModel> result = [];
    for (var item in list) {
      result.add(DoctorModel.fromJson(item));
    }
    return result;
  } 
}
