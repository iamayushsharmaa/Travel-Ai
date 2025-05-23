class UserModel {
  final String uid;
  final String email;
  final String? password;
  final String? name;
  final String? profilePic;
  final bool isAuthenticated;

  UserModel({
    required this.uid,
    required this.email,
    required this.password,
    required this.name,
    required this.profilePic,
    required this.isAuthenticated,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'email': this.email,
      'password': this.password,
      'name': this.name,
      'profilePic': this.profilePic,
      'isAuthenticated': this.isAuthenticated,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      name: map['name'] as String,
      profilePic: map['profilePic'] as String,
      isAuthenticated: map['isAuthenticated'] as bool,
    );
  }

  @override
  String toString() {
    return 'UserModel{uid: $uid, email: $email, password: $password, name: $name, profilePic: $profilePic, isAuthenticated: $isAuthenticated}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          email == other.email &&
          password == other.password &&
          name == other.name &&
          profilePic == other.profilePic &&
          isAuthenticated == other.isAuthenticated;

  @override
  int get hashCode =>
      uid.hashCode ^
      email.hashCode ^
      password.hashCode ^
      name.hashCode ^
      profilePic.hashCode ^
      isAuthenticated.hashCode;
}
