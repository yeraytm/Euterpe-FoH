import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutters_of_hamelin/services/database.dart';
import 'package:flutters_of_hamelin/widgets/playlist_tile_selector.dart';

class PlaylistSelector extends StatefulWidget {
  PlaylistSelector({Key? key, required this.selectedSongId}) : super(key: key);
  String selectedSongId;

  @override
  _PlaylistSelectorState createState() => _PlaylistSelectorState();
}

class _PlaylistSelectorState extends State<PlaylistSelector> {
  DatabaseService db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select the playlist'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: db.users
                  .doc(db.currentUser!.uid)
                  .collection('Playlists')
                  .snapshots(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Text('Something went wrong.');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    List list = data['songs'];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: PlaylistTileSelector(
                        songId: list.isNotEmpty ? list[0] : null,
                        playlistTitle: data['name'],
                        playlistId: document.id,
                        selectedSongId: widget.selectedSongId,
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
