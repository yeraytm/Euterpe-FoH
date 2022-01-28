import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutters_of_hamelin/models/song.dart';

class DatabaseService {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final users = FirebaseFirestore.instance.collection('Users');
  final songs = FirebaseFirestore.instance.collection('Songs');

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

  void addSongToPlaylist(String songId, String playlistId) async {
    users.doc(currentUser!.uid).collection('Playlists').doc(playlistId).update({
      'songs': FieldValue.arrayUnion([songId])
    });
  }

  void removeSongFromPlaylist(String songId, String playlistId) async {
    users.doc(currentUser!.uid).collection('Playlists').doc(playlistId).update({
      'songs': FieldValue.arrayRemove([songId])
    });
  }

  Future<List<String>> getSongsFromPlaylist(String playlistId) async {
    DocumentSnapshot playlistSnapshot = await users
        .doc(currentUser!.uid)
        .collection('Playlists')
        .doc(playlistId)
        .get();
    List<dynamic> songsSnapshots = playlistSnapshot.get('songs').map((song) {
      return song.toString();
    }).toList();
    List<String> songs = songsSnapshots.cast<String>();
    return songs;
  }
}
