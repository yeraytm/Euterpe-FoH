import 'dart:convert';

import 'package:flutters_of_hamelin/models/models.dart';

class Playlist {
  String name;
  String description;
  int owner;
  String img;
  int numFollowers;
  List<int> followerList;
  List<int> songs;
  Playlist({
    required this.name,
    required this.description,
    required this.owner,
    required this.img,
    required this.numFollowers,
    required this.followerList,
    required this.songs,
  });

  Playlist copyWith({
    String? name,
    String? description,
    int? owner,
    String? img,
    int? numFollowers,
    List<int>? followerList,
    List<int>? songs,
  }) {
    return Playlist(
      name: name ?? this.name,
      description: description ?? this.description,
      owner: owner ?? this.owner,
      img: img ?? this.img,
      numFollowers: numFollowers ?? this.numFollowers,
      followerList: followerList ?? this.followerList,
      songs: songs ?? this.songs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'owner': owner,
      'img': img,
      'numFollowers': numFollowers,
      'followerList': followerList,
      'songs': songs,
    };
  }

  factory Playlist.fromMap(Map<String, dynamic> map) {
    return Playlist(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      owner: map['owner'] ?? '',
      img: map['img'] ?? '',
      numFollowers: map['numFollowers'] ?? '',
      followerList: map['followerList'] ?? '',
      songs: map['songs'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Playlist.fromJson(String source) =>
      Playlist.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Playlist(name: $name, description: $description, owner: $owner, img: $img, numFollowers: $numFollowers, followerList: $followerList, songs: $songs)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Playlist &&
        other.name == name &&
        other.description == description &&
        other.owner == owner &&
        other.img == img &&
        other.numFollowers == numFollowers &&
        other.followerList == followerList &&
        other.songs == songs;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        owner.hashCode ^
        img.hashCode ^
        numFollowers.hashCode ^
        followerList.hashCode ^
        songs.hashCode;
  }
}
