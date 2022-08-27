class User {
  String? userId;
  String? name;
  String? email;
  String? phone;
  int? role;
  bool? isVerified;
  String? accessToken;

  User(
      {this.userId,
      this.name,
      this.email,
      this.phone,
      this.role,
      this.isVerified,
      this.accessToken});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    role = json['role'];
    isVerified = json['isVerified'];
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['role'] = role;
    data['isVerified'] = isVerified;
    data['accessToken'] = accessToken;
    return data;
  }
}
