import 'dart:convert';

class Profile {
  String avatar;
  String banner;
  String name;
  String description;
  int followers;
  int following;
  Profile({
    required this.avatar,
    required this.banner,
    required this.name,
    required this.description,
    required this.followers,
    required this.following,
  });

  Profile copyWith({
    String? avatar,
    String? banner,
    String? name,
    String? description,
    String? artist,
    int? followers,
    int? following,
  }) {
    return Profile(
      avatar: avatar ?? this.avatar,
      banner: banner ?? this.banner,
      name: name ?? this.name,
      description: description ?? this.description,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'avatar': avatar,
      'banner': banner,
      'name': name,
      'description': description,
      'followers': followers,
      'following': following,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      avatar: map['avatar'] ?? '',
      banner: map['banner'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      followers: map['followers'] ?? 0,
      following: map['following'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Profile.fromJson(String source) =>
      Profile.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Song(avatar: $avatar, banner: $banner, name: $name, description: $description, followers: $followers, following: $following)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Profile &&
        other.avatar == avatar &&
        other.banner == banner &&
        other.name == name &&
        other.description == description &&
        other.followers == followers &&
        other.following == following;
  }

  @override
  int get hashCode {
    return avatar.hashCode ^
        banner.hashCode ^
        name.hashCode ^
        description.hashCode ^
        followers.hashCode ^
        following.hashCode;
  }
}
