import 'package:flutter/material.dart';
import 'package:flutters_of_hamelin/models/models.dart';
import 'package:flutters_of_hamelin/services/database.dart';
import 'package:flutters_of_hamelin/widgets/widgets.dart';

class PlaylistSongs extends StatelessWidget {
  PlaylistSongs({
    Key? key,
    required this.playlistId,
  }) : super(key: key);
  DatabaseService db = DatabaseService();
  final String playlistId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Playlist Songs'), backgroundColor: Colors.black,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 232,
            child: FutureBuilder(
                future: db.getSongsFromPlaylist(playlistId),
                builder:
                    (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('Loading...');
                  }
                  return ListView(
                    children: snapshot.data!.map((String songId) {
                      return FutureBuilder(
                          future: db.getSongById(songId),
                          builder: (BuildContext context,
                              AsyncSnapshot<Song> snapshot) {
                            if (!snapshot.hasData) {
                              return const Text('Something went wrong.');
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SongTile(song: snapshot.data!, songId: songId),
                            );
                          });
                    }).toList(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
