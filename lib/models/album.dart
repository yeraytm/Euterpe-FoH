import 'dart:convert';

class Album {
  String name;
  String artist;
  String image;
  List<int> songs;
  Album({
    required this.name,
    required this.artist,
    required this.image,
    required this.songs,
  });

  Album copyWith({
    String? name,
    String? artist,
    String? image,
    List<int>? songs,
  }) {
    return Album(
      name: name ?? this.name,
      artist: artist ?? this.artist,
      image: image ?? this.image,
      songs: songs ?? this.songs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'artist': artist,
      'image': image,
      'songs': songs,
    };
  }

  factory Album.fromMap(Map<String, dynamic> map) {
    return Album(
      name: map['name'] ?? '',
      artist: map['artist'] ?? '',
      image: map['image'] ?? '',
      songs: map['songs'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Album.fromJson(String source) => Album.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Album(name: $name, artists: $artist, image: $image, songs: $songs)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Album &&
        other.name == name &&
        other.artist == artist &&
        other.image == image &&
        other.songs == songs;
  }

  @override
  int get hashCode {
    return name.hashCode ^ artist.hashCode ^ image.hashCode ^ songs.hashCode;
  }
}
