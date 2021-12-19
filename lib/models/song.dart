import 'dart:convert';

class Song {
  String img;
  String Name;
  String Description;
  String uri;
  String isPlayable;
  String isLocal;
  int track_number;
  int popularity;
  Song({
    required this.img,
    required this.Name,
    required this.Description,
    required this.uri,
    required this.isPlayable,
    required this.isLocal,
    required this.track_number,
    required this.popularity,
  });

  Song copyWith({
    String? img,
    String? Name,
    String? Description,
    String? uri,
    String? isPlayable,
    String? isLocal,
    int? track_number,
    int? popularity,
  }) {
    return Song(
      img: img ?? this.img,
      Name: Name ?? this.Name,
      Description: Description ?? this.Description,
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
      'Name': Name,
      'Description': Description,
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
      Name: map['Name'] ?? '',
      Description: map['Description'] ?? '',
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
    return 'Song(img: $img, Name: $Name, Description: $Description, uri: $uri, isPlayable: $isPlayable, isLocal: $isLocal, track_number: $track_number, popularity: $popularity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Song &&
      other.img == img &&
      other.Name == Name &&
      other.Description == Description &&
      other.uri == uri &&
      other.isPlayable == isPlayable &&
      other.isLocal == isLocal &&
      other.track_number == track_number &&
      other.popularity == popularity;
  }

  @override
  int get hashCode {
    return img.hashCode ^
      Name.hashCode ^
      Description.hashCode ^
      uri.hashCode ^
      isPlayable.hashCode ^
      isLocal.hashCode ^
      track_number.hashCode ^
      popularity.hashCode;
  }
}
