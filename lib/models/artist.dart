import 'dart:convert';

import 'package:collection/collection.dart';

class Artist {
  String id;
  String profileImg;
  String name;
  List<String> albums;
  Artist({
    required this.id,
    required this.profileImg,
    required this.name,
    required this.albums,
  });

  Artist copyWith({
    String? id,
    String? profileImg,
    String? name,
    List<String>? albums,
  }) {
    return Artist(
      id: id ?? this.id,
      profileImg: profileImg ?? this.profileImg,
      name: name ?? this.name,
      albums: albums ?? this.albums,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'profileImg': profileImg,
      'name': name,
      'albums': albums,
    };
  }

  factory Artist.fromMap(Map<String, dynamic> map) {
    return Artist(
      id: map['id'] ?? '',
      profileImg: map['profileImg'] ?? '',
      name: map['name'] ?? '',
      albums: (map['albums'] as List<dynamic>).cast<String>(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Artist.fromJson(String source) => Artist.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Artist(id: $id, profileImg: $profileImg, name: $name, albums: $albums)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Artist &&
        other.id == id &&
        other.profileImg == profileImg &&
        other.name == name &&
        listEquals(other.albums, albums);
  }

  @override
  int get hashCode {
    return id.hashCode ^ profileImg.hashCode ^ name.hashCode ^ albums.hashCode;
  }
}
