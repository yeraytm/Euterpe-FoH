import 'dart:convert';

class Song {
  String img;
  String name;
  String description;
  String artist;
  String uri;
  String isPlayable;
  String isLocal;
  int trackNumber;
  int popularity;
  Song({
    required this.img,
    required this.name,
    required this.description,
    required this.artist,
    required this.uri,
    required this.isPlayable,
    required this.isLocal,
    required this.trackNumber,
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
    int? trackNumber,
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
      trackNumber: trackNumber ?? this.trackNumber,
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
      'track_number': trackNumber,
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
      trackNumber: map['track_number']?.toInt() ?? 0,
      popularity: map['popularity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Song.fromJson(String source) => Song.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Song(img: $img, name: $name, description: $description, artist: $artist, uri: $uri, isPlayable: $isPlayable, isLocal: $isLocal, track_number: $trackNumber, popularity: $popularity)';
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
      other.trackNumber == trackNumber &&
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
      trackNumber.hashCode ^
      popularity.hashCode;
  }
}
