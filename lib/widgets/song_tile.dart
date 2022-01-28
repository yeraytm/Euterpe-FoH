import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutters_of_hamelin/models/models.dart';
import 'package:flutters_of_hamelin/screens/screens.dart';

class SongTile extends StatefulWidget {
  const SongTile({
    Key? key,
    required this.song,
  }) : super(key: key);

  final Song song;

  @override
  State<SongTile> createState() => SongTileState();
}

class SongTileState extends State<SongTile> {
  String artistName = '';

  void getArtist() async {
    final doc = FirebaseFirestore.instance
        .collection('Artists')
        .doc(widget.song.artist);
    DocumentSnapshot documentSnapshot = await doc.get();
    setState(() {
      artistName = documentSnapshot.get('name');
    });
  }

  @override
  void initState() {
    getArtist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MusicPlayerScreen(song: widget.song)));
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  image: DecorationImage(
                    image: NetworkImage(widget.song.img),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.song.name,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    artistName,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.favorite_outline),
            onPressed: () {
              print('hello');
            },
          ),
        ],
      ),
    );
  }
}
