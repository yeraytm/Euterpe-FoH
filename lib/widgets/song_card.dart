import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutters_of_hamelin/models/models.dart';
import 'package:flutters_of_hamelin/screens/screens.dart';

import '../colors.dart';

class SongCard extends StatefulWidget {
  SongCard({Key? key, required this.song}) : super(key: key);
  final Song song;

  @override
  State<SongCard> createState() => _SongCardState();
}

class _SongCardState extends State<SongCard> {
  String artistName = '';

  void getArtist() async {
    final doc = FirebaseFirestore.instance.collection('Artists').doc(widget.song.artist);
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
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                image: DecorationImage(
                    image: NetworkImage(widget.song.img), fit: BoxFit.cover),
              ),
            ),
            Positioned(
              bottom: 7,
              left: 7,
              right: 7,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          white.withOpacity(0.2),
                          white.withOpacity(0.1)
                        ],
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.song.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: white,
                              ),
                            ),
                            const SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              artistName,
                              style: const TextStyle(
                                fontSize: 12,
                                color: white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
