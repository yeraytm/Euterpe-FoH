import 'package:flutter/material.dart';
import 'package:flutters_of_hamelin/models/models.dart';
import 'package:flutters_of_hamelin/services/database.dart';

class PlaylistTileSelector extends StatefulWidget {
  const PlaylistTileSelector(
      {Key? key,
      required this.songId,
      required this.playlistTitle,
      required this.playlistId,
      required this.selectedSongId})
      : super(key: key);
  final String? songId;
  final String playlistTitle;
  final String playlistId;
  final String selectedSongId;

  @override
  State<PlaylistTileSelector> createState() => _PlaylistTileSelectorState();
}

class _PlaylistTileSelectorState extends State<PlaylistTileSelector> {
  DatabaseService db = DatabaseService();
  void _showAlertDialog(String playlistId) {
    String id = playlistId;
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Delete playlist'),
            content: const Text("This action can't be undone, are you sure?"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No')),
              TextButton(
                onPressed: () {
                  db.removePlaylistById(id, db.currentUser!.uid);
                  Navigator.pop(context);
                },
                child: const Text('Yes'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return widget.songId == null || widget.songId == ""
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                db.addSongToPlaylist(widget.selectedSongId, widget.playlistId);
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    widget.playlistTitle,
                    style: const TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                  const Expanded(child: SizedBox()),
                ],
              ),
            ),
          )
        : FutureBuilder(
            future: db.getSongById(widget.songId!),
            builder: (BuildContext context, AsyncSnapshot<Song> snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GestureDetector(
                  onTap: () {
                    db.addSongToPlaylist(
                        widget.selectedSongId, widget.playlistId);
                    Navigator.pop(context);
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.network(snapshot.data!.img),
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Text(
                        widget.playlistTitle,
                        style: const TextStyle(
                            fontSize: 18.0, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              );
            });
  }
}
