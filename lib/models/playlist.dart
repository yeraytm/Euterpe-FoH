import 'dart:convert';

class Playlist {
  String name;
  String description;
  String img;
  String artist;
  int numFollowers;
  DateTime releaseDate;
  Playlist({
    required this.name,
    required this.description,
    required this.img,
    required this.artist,
    required this.numFollowers,
    required this.releaseDate,
  });

  Playlist copyWith({
    String? name,
    String? description,
    String? img,
    String? artist,
    int? numFollowers,
    DateTime? releaseDate,
  }) =>
      Playlist(
        name: name ?? this.name,
        description: description ?? this.description,
        img: img ?? this.img,
        artist: artist ?? this.artist,
        numFollowers: numFollowers ?? this.numFollowers,
        releaseDate: releaseDate ?? this.releaseDate,
      );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'img': img,
      'artist': artist,
      'numFollowers': numFollowers,
      'releaseDate': releaseDate,
    };
  }

  factory Playlist.fromMap(Map<String, dynamic> map) {
    return Playlist(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      img: map['img'] ?? '',
      artist: map['artist'] ?? '',
      numFollowers: map['numFollowers'] ?? '',
      releaseDate: map['releaseDate'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Playlist.fromJson(String source) =>
      Playlist.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Playlist(name: $name, description: $description, img: $img, artist: $artist, numFollowers: $numFollowers, releaseDate: $releaseDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Playlist &&
        other.name == name &&
        other.description == description &&
        other.img == img &&
        other.artist == artist &&
        other.numFollowers == numFollowers &&
        other.releaseDate == releaseDate;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        img.hashCode ^
        artist.hashCode ^
        numFollowers.hashCode ^
        releaseDate.hashCode;
  }
}
