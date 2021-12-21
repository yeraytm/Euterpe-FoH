import 'dart:convert';

import 'package:flutter/foundation.dart';

class Track {
  String uuid;
  List<String> artistsId;
  String albumId;
  String songUri;
  List<String> images;
  String name;
  Duration duration;
  DateTime releaseDate;
  String genre;
  Track({
    required this.uuid,
    required this.artistsId,
    required this.albumId,
    required this.songUri,
    required this.images,
    required this.name,
    required this.duration,
    required this.releaseDate,
    required this.genre,
  });

  Track copyWith({
    String? uuid,
    List<String>? artistsId,
    String? albumId,
    String? songUri,
    List<String>? images,
    String? name,
    Duration? duration,
    DateTime? releaseDate,
    String? genre,
  }) {
    return Track(
      uuid: uuid ?? this.uuid,
      artistsId: artistsId ?? this.artistsId,
      albumId: albumId ?? this.albumId,
      songUri: songUri ?? this.songUri,
      images: images ?? this.images,
      name: name ?? this.name,
      duration: duration ?? this.duration,
      releaseDate: releaseDate ?? this.releaseDate,
      genre: genre ?? this.genre,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'artistsId': artistsId,
      'albumId': albumId,
      'songUri': songUri,
      'images': images,
      'name': name,
      'duration': duration.toString(),
      'releaseDate': releaseDate.millisecondsSinceEpoch,
      'genre': genre,
    };
  }

  factory Track.fromMap(Map<String, dynamic> map) {
    return Track(
      uuid: map['uuid'] ?? '',
      artistsId: List<String>.from(map['artistsId']),
      albumId: map['albumId'] ?? '',
      songUri: map['songUri'] ?? '',
      images: List<String>.from(map['images']),
      name: map['name'] ?? '',
      duration: map['duration'] ?? '',
      releaseDate: DateTime.fromMillisecondsSinceEpoch(map['releaseDate']),
      genre: map['genre'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Track.fromJson(String source) => Track.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Track(uuid: $uuid, artistsId: $artistsId, albumId: $albumId, songUri: $songUri, images: $images, name: $name, duration: $duration, releaseDate: $releaseDate, genre: $genre)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Track &&
      other.uuid == uuid &&
      listEquals(other.artistsId, artistsId) &&
      other.albumId == albumId &&
      other.songUri == songUri &&
      listEquals(other.images, images) &&
      other.name == name &&
      other.duration == duration &&
      other.releaseDate == releaseDate &&
      other.genre == genre;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
      artistsId.hashCode ^
      albumId.hashCode ^
      songUri.hashCode ^
      images.hashCode ^
      name.hashCode ^
      duration.hashCode ^
      releaseDate.hashCode ^
      genre.hashCode;
  }
}
