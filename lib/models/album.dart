import 'dart:convert';

class Album {
  String name;
  String artist;
  String image;
  DateTime releaseDate;
  Album({
    required this.name,
    required this.artist,
    required this.image,
    required this.releaseDate,
  });

  Album copyWith({
    String? name,
    String? artist,
    String? image,
    DateTime? releaseDate,
  }) {
    return Album(
      name: name ?? this.name,
      artist: artist ?? this.artist,
      image: image ?? this.image,
      releaseDate: releaseDate ?? this.releaseDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'artist': artist,
      'image': image,
      'releaseDate': releaseDate,
    };
  }

  factory Album.fromMap(Map<String, dynamic> map) {
    return Album(
      name: map['name'] ?? '',
      artist: map['artist'] ?? '',
      image: map['image'] ?? '',
      releaseDate: map['releaseDate'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Album.fromJson(String source) => Album.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Album(name: $name, artist: $artist, image: $image, releaseDate: $releaseDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Album &&
        other.name == name &&
        other.artist == artist &&
        other.image == image &&
        other.releaseDate == releaseDate;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        artist.hashCode ^
        image.hashCode ^
        releaseDate.hashCode;
  }
}
