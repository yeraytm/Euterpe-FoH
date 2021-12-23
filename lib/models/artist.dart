import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Artist {
  String email;
  String fullname;
  String username;
  String profileImg;
  String bio;
  Artist({
    required this.email,
    required this.fullname,
    required this.username,
    required this.profileImg,
    required this.bio,
  });

  Artist copyWith({
    String? email,
    String? fullname,
    String? username,
    String? profileImg,
    String? bio,
  }) {
    return Artist(
      email: email ?? this.email,
      fullname: fullname ?? this.fullname,
      username: username ?? this.username,
      profileImg: profileImg ?? this.profileImg,
      bio: bio ?? this.bio,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'fullname': fullname,
      'username': username,
      'profileImg': profileImg,
      'bio': bio,
    };
  }

  factory Artist.fromMap(Map<dynamic, dynamic> map) {
    return Artist(
      email: map['email'] ?? '',
      fullname: map['fullname'] ?? '',
      username: map['username'] ?? '',
      profileImg: map['profileImg'] ?? '',
      bio: map['bio'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Artist.fromJson(Map<dynamic, dynamic> source) =>
      Artist.fromMap(source);

  @override
  String toString() {
    return 'Artist( email: $email, fullname: $fullname, username: $username, profileImg: $profileImg, bio: $bio)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Artist &&
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
