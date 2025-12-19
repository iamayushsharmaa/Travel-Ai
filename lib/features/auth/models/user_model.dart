class UserModel {
  final String uid;
  final String email;
  final String? name;
  final String? profilePic;
  final bool isAuthenticated;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.profilePic,
    required this.isAuthenticated,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'email': this.email,
      'name': this.name,
      'profilePic': this.profilePic,
      'isAuthenticated': this.isAuthenticated,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      name: map['name'] as String?,
      profilePic: map['profilePic'] as String?,
      isAuthenticated: map['isAuthenticated'] as bool,
    );
  }

  @override
  String toString() {
    return 'UserModel{uid: $uid, email: $email, name: $name, profilePic: $profilePic, isAuthenticated: $isAuthenticated}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          email == other.email &&
          name == other.name &&
          profilePic == other.profilePic &&
          isAuthenticated == other.isAuthenticated;

  @override
  int get hashCode =>
      uid.hashCode ^
      email.hashCode ^
      name.hashCode ^
      profilePic.hashCode ^
      isAuthenticated.hashCode;

  UserModel copyWith({
    String? uid,
    String? email,
    String? password,
    String? name,
    String? profilePic,
    bool? isAuthenticated,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }
}
