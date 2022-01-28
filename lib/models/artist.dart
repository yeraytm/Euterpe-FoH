import 'dart:convert';

import 'package:collection/collection.dart';

class Artist {
  String profileImg;
  String name;
  List<String> albums;
  Artist({
    required this.profileImg,
    required this.name,
    required this.albums,
  });

  Artist copyWith({
    String? profileImg,
    String? name,
    List<String>? albums,
  }) {
    return Artist(
      profileImg: profileImg ?? this.profileImg,
      name: name ?? this.name,
      albums: albums ?? this.albums,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'profileImg': profileImg,
      'name': name,
      'albums': albums,
    };
  }

  factory Artist.fromMap(Map<String, dynamic> map) {
    return Artist(
      profileImg: map['profileImg'] ?? '',
      name: map['name'] ?? '',
      albums: (map['albums'] as List<dynamic>).cast<String>(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Artist.fromJson(String source) => Artist.fromMap(json.decode(source));

  @override
  String toString() =>
      'Artist(profileImg: $profileImg, name: $name, albums: $albums)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Artist &&
        other.profileImg == profileImg &&
        other.name == name &&
        listEquals(other.albums, albums);
  }

  @override
  int get hashCode => profileImg.hashCode ^ name.hashCode ^ albums.hashCode;
}
