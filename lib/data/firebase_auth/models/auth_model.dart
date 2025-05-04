
class User{
  final String name;
  final String email;
  final String password;

  User(this.name, this.email, this.password);

  factory User.fromJson(Map<String, dynamic> json){
    return User(
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

