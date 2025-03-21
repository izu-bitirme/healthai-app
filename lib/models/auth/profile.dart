class ProfileModel {
  int? id;
  String? email;
  String? full_name;
  String? bio;
  String? avatar;
  Map<String, dynamic>? relationships;

  ProfileModel.fromJson(Map json) {
    id = json['id'];
    email = json['email'];
    full_name = json['full_name'];
    bio = json['bio'];
    avatar = json['photo'];
    relationships = json['relationships'];
  }
}