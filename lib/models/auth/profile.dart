class ProfileModel {
  int? id;
  String? email;
  String? username;
  String? bio;
  String? avatar;
  String? role;

  ProfileModel({
    this.id,
    this.email,
    this.username,
    this.bio,
    this.avatar,
    this.role,
  });

  ProfileModel.fromJson(json) {
    id = json['user']['id'];
    email = json['user']['email'];
    username = json['user']['username'];
    bio = json['bio'];
    avatar = json['photo'];
    role = json['role'];
  }
}
