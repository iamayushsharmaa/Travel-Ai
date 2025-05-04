
class Auth{
  final String name;
  final String email;
  final String password;

  Auth(this.name, this.email, this.password);

  factory Auth.fromJson(Map<String, dynamic> json){
    return Auth(
      json['name'],
      json['email'],
      json['password']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'name': name,
      'email': email,
      'password': password
    };
  }
}

