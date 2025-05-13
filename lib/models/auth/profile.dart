class ProfileModel {
  int? id;
  String? email;
  String? fullName;
  String? bio;
  String? avatar;
  Map<String, dynamic>? relationships;

  ProfileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    fullName = json['full_name'];
    bio = json['bio'];
    avatar = json['photo'];
    relationships = json['relationships'];
  }

  static List<ProfileModel> fromJsonList(dynamic list) {
    List<ProfileModel> result = [];
    for (var item in list) {
      result.add(ProfileModel.fromJson(item));
    }
    return result;
  }
}