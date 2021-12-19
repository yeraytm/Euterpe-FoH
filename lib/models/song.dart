import 'dart:convert';

class Song {
  String img;
  String name;
  String description;
  String artist;
  String uri;
  String isPlayable;
  String isLocal;
  int track_number;
  int popularity;
  Song({
    required this.img,
    required this.name,
    required this.description,
    required this.artist,
    required this.uri,
    required this.isPlayable,
    required this.isLocal,
    required this.track_number,
    required this.popularity,
  });

  Song copyWith({
    String? img,
    String? name,
    String? description,
    String? artist,
    String? uri,
    String? isPlayable,
    String? isLocal,
    int? track_number,
    int? popularity,
  }) {
    return Song(
      img: img ?? this.img,
      name: name ?? this.name,
      description: description ?? this.description,
      artist: artist ?? this.artist,
      uri: uri ?? this.uri,
      isPlayable: isPlayable ?? this.isPlayable,
      isLocal: isLocal ?? this.isLocal,
      track_number: track_number ?? this.track_number,
      popularity: popularity ?? this.popularity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'img': img,
      'name': name,
      'description': description,
      'artist': artist,
      'uri': uri,
      'isPlayable': isPlayable,
      'isLocal': isLocal,
      'track_number': track_number,
      'popularity': popularity,
    };
  }

  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      img: map['img'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      artist: map['artist'] ?? '',
      uri: map['uri'] ?? '',
      isPlayable: map['isPlayable'] ?? '',
      isLocal: map['isLocal'] ?? '',
      track_number: map['track_number']?.toInt() ?? 0,
      popularity: map['popularity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Song.fromJson(String source) => Song.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Song(img: $img, name: $name, description: $description, artist: $artist, uri: $uri, isPlayable: $isPlayable, isLocal: $isLocal, track_number: $track_number, popularity: $popularity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Song &&
      other.img == img &&
      other.name == name &&
      other.description == description &&
      other.artist == artist &&
      other.uri == uri &&
      other.isPlayable == isPlayable &&
      other.isLocal == isLocal &&
      other.track_number == track_number &&
      other.popularity == popularity;
  }

  @override
  int get hashCode {
    return img.hashCode ^
      name.hashCode ^
      description.hashCode ^
      artist.hashCode ^
      uri.hashCode ^
      isPlayable.hashCode ^
      isLocal.hashCode ^
      track_number.hashCode ^
      popularity.hashCode;
  }
}
