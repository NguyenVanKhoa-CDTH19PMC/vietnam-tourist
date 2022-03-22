class User {
  int? id;
  String? name;
  String? email;
  String? birthday;
  String? sex;
  String? avatar;
  String? emailVerifiedAt;

  User(
      {this.id,
      this.name,
      this.email,
      this.birthday,
      this.sex,
      this.avatar,
      this.emailVerifiedAt});

  User.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.name = json["name"];
    this.email = json["email"];
    this.birthday = json["birthday"];
    this.sex = json["sex"];
    this.avatar = json["avatar"];
    this.emailVerifiedAt = json["email_verified_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["email"] = this.email;
    data["birthday"] = this.birthday;
    data["sex"] = this.sex;
    data["avatar"] = this.avatar;
    data["email_verified_at"] = this.emailVerifiedAt;

    return data;
  }
}

class SendAuth {
  late final String email;
  late final String password;
  SendAuth({required this.email, required this.password});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}

class RespAuth {
  String name = '';
  String token = '';

  RespAuth({required this.name, required this.token});

  RespAuth.fromJson(Map<String, dynamic> json) {
    // name = (json['name'] != null ? json['name'] : null);
    // token = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.name != null) {
      data['name'] = this.name;
    }
    data['token'] = this.token;
    return data;
  }
}

class RegisterAuth {
  late final String name;
  late final String email;
  late final String password;
  late final String passwordConfirmation;
  RegisterAuth(
      {required this.name,
      required this.email,
      required this.password,
      required this.passwordConfirmation});

  RegisterAuth.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['password_confirmation'] = this.passwordConfirmation;
    return data;
  }
}
