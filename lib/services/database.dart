import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutters_of_hamelin/models/song.dart';

class DatabaseService {
  final db = FirebaseFirestore.instance;
  final songs = FirebaseFirestore.instance.collection('Songs');
  final playlists = FirebaseFirestore.instance.collection('Playlists');

  Future<Song> getSongById(String id) async {
    DocumentSnapshot songSnapshot = await songs.doc(id).get();
    Map<String, dynamic> data = songSnapshot.data()! as Map<String, dynamic>;
    Song song = Song.fromMap(data);
    return song;
  }

  void createPlaylist(String name) {
    playlists.add({'name': name, 'songs': []});
  }

  void removePlaylistById(String id) {
    playlists.doc(id).delete();
  }
}
