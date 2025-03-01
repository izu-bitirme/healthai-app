class UserModel {
  int? id;
  String? email;
  String? password;
  String? firstname;
  String? lastname;

  UserModel.fromJson(Map json) {
    id = json['id'];
    email = json['email'];
    password = json['password'];
    firstname = json['firstname'];
    lastname = json['lastname'];
  }
}