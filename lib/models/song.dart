import 'dart:convert';

class Song {
  String img;
  String name;
  String song;
  String artist;

  
  Song({
    required this.img,
    required this.name,
    required this.song,
    required this.artist,
  });

  Song copyWith({
    String? img,
    String? name,
    String? song,
    String? artist,
  }) {
    return Song(
      img: img ?? this.img,
      name: name ?? this.name,
      song: song ?? this.song,
      artist: artist ?? this.artist,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'img': img,
      'name': name,
      'song': song,
      'artist': artist,
    };
  }

  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      img: map['img'] ?? '',
      name: map['name'] ?? '',
      song: map['song'] ?? '',
      artist: map['artist'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Song.fromJson(String source) => Song.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Song(img: $img, name: $name, song: $song, artist: $artist)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Song &&
      other.img == img &&
      other.name == name &&
      other.song == song &&
      other.artist == artist;
  }

  @override
  int get hashCode {
    return img.hashCode ^
      name.hashCode ^
      song.hashCode ^
      artist.hashCode;
  }
}
