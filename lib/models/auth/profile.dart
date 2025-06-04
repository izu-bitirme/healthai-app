class ProfileModel {
  int? id;
  String? email;
  late String username;
  String? bio;
  late String avatar;
  String? role;
  int daysLeft = 90;

  ProfileModel({
    this.id,
    this.email,
    required this.username,
    this.bio,
    required this.avatar,
    this.role,
  });

  ProfileModel.fromJson(json) {
    id = json['user']['id'];
    email = json['user']['email'];
    username = json['user']['username'];
    bio = json['bio'];
    avatar = json['photo'];
    role = json['role'];
    daysLeft = json['days_left'];
    if (daysLeft <= 0) daysLeft = 1;
  }
}
