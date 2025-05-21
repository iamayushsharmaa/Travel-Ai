
class UserModel{
  final String email;
  final String password;

  UserModel(this.email, this.password);

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      json['email'],
      json['password']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'email': email,
      'password': password
    };
  }
}

