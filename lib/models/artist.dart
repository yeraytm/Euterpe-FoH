import 'dart:convert';

class Artist {
  String uuid;
  String email;
  String fullname;
  String username;
  String profileImg;
  String bio;
  Artist({
    required this.uuid,
    required this.email,
    required this.fullname,
    required this.username,
    required this.profileImg,
    required this.bio,
  });

  Artist copyWith({
    String? uuid,
    String? email,
    String? fullname,
    String? username,
    String? profileImg,
    String? bio,
  }) {
    return Artist(
      uuid: uuid ?? this.uuid,
      email: email ?? this.email,
      fullname: fullname ?? this.fullname,
      username: username ?? this.username,
      profileImg: profileImg ?? this.profileImg,
      bio: bio ?? this.bio,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'email': email,
      'fullname': fullname,
      'username': username,
      'profileImg': profileImg,
      'bio': bio,
    };
  }

  factory Artist.fromMap(Map<String, dynamic> map) {
    return Artist(
      uuid: map['uuid'] ?? '',
      email: map['email'] ?? '',
      fullname: map['fullname'] ?? '',
      username: map['username'] ?? '',
      profileImg: map['profileImg'] ?? '',
      bio: map['bio'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Artist.fromJson(String source) => Artist.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Artist(uuid: $uuid, email: $email, fullname: $fullname, username: $username, profileImg: $profileImg, bio: $bio)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Artist &&
      other.uuid == uuid &&
      other.email == email &&
      other.fullname == fullname &&
      other.username == username &&
      other.profileImg == profileImg &&
      other.bio == bio;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
      email.hashCode ^
      fullname.hashCode ^
      username.hashCode ^
      profileImg.hashCode ^
      bio.hashCode;
  }
}
