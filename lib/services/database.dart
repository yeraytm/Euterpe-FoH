import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutters_of_hamelin/models/song.dart';

class DatabaseService {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final users = FirebaseFirestore.instance.collection('Users');
  final songs = FirebaseFirestore.instance.collection('Songs');
  final playlists = FirebaseFirestore.instance.collection('Playlists');

  User? get currentUser {
    return auth.currentUser;
  }

  Future<Song> getSongById(String id) async {
    DocumentSnapshot songSnapshot = await songs.doc(id).get();
    Map<String, dynamic> data = songSnapshot.data()! as Map<String, dynamic>;
    Song song = Song.fromMap(data);
    return song;
  }

  void createPlaylist(String name, String userUid) {
    users.doc(userUid).collection('Playlists').add({'name': name, 'songs': []});
  }

  void removePlaylistById(String playlistUid, String userUid) {
    users.doc(userUid).collection('Playlists').doc(playlistUid).delete();
  }
}
