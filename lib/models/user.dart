import 'dart:convert';

class AppUser {
  String email;
  String fullname;
  String username;
  String profileImg;
  String bio;
  AppUser({
    required this.email,
    required this.fullname,
    required this.username,
    required this.profileImg,
    required this.bio,
  });

  AppUser copyWith({
    String? email,
    String? fullname,
    String? username,
    String? profileImg,
    String? bio,
  }) {
    return AppUser(
      email: email ?? this.email,
      fullname: fullname ?? this.fullname,
      username: username ?? this.username,
      profileImg: profileImg ?? this.profileImg,
      bio: bio ?? this.bio,
    );
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'email': email,
      'fullname': fullname,
      'username': username,
      'profileImg': profileImg,
      'bio': bio,
    };
  }

  factory AppUser.fromMap(Map<dynamic, dynamic> map) {
    return AppUser(
      email: map['email'] ?? '',
      fullname: map['fullname'] ?? '',
      username: map['username'] ?? '',
      profileImg: map['profileImg'] ?? '',
      bio: map['bio'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(Map<dynamic, dynamic> source) =>
      AppUser.fromMap(source);

  @override
  String toString() {
    return 'User( email: $email, fullname: $fullname, username: $username, profileImg: $profileImg, bio: $bio)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser &&
        other.email == email &&
        other.fullname == fullname &&
        other.username == username &&
        other.profileImg == profileImg &&
        other.bio == bio;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        fullname.hashCode ^
        username.hashCode ^
        profileImg.hashCode ^
        bio.hashCode;
  }
}
