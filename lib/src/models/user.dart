class User {
  int? id;
  String? login;
  String? password;
  String? permission;

  User({this.id, this.login, this.password, this.permission});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    password = json['password'];
    permission = json['permission'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =   <String, dynamic>{};
    data['id'] = id;
    data['login'] = login;
    data['password'] = password;
    data['permission'] = permission;
    return data;
  }
  @override
  String toString() { 
    return "id:$id-login:$login-password:$password-permission:$permission";
  }
}