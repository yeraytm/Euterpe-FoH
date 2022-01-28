import 'dart:convert';

import 'package:collection/collection.dart';

class Album {
  String name;
  String image;
  List<String> songs;
  Album({
    required this.name,
    required this.image,
    required this.songs,
  });

  Album copyWith({
    String? name,
    String? image,
    List<String>? songs,
  }) {
    return Album(
      name: name ?? this.name,
      image: image ?? this.image,
      songs: songs ?? this.songs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'songs': songs,
    };
  }

  factory Album.fromMap(Map<String, dynamic> map) {
    return Album(
      name: map['name'] ?? '',
      image: map['img'] ?? '',
      songs: (map['songs'] as List).cast<String>(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Album.fromJson(String source) => Album.fromMap(json.decode(source));

  @override
  String toString() => 'Album(name: $name, image: $image, songs: $songs)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Album &&
        other.name == name &&
        other.image == image &&
        listEquals(other.songs, songs);
  }

  @override
  int get hashCode => name.hashCode ^ image.hashCode ^ songs.hashCode;
}
