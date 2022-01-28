import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutters_of_hamelin/data/data.dart';
import 'package:flutters_of_hamelin/models/models.dart';
import 'package:flutters_of_hamelin/widgets/widgets.dart';

class AlbumInfo extends StatelessWidget {
  const AlbumInfo({
    Key? key,
    required this.album,
    required this.albumId,
  }) : super(key: key);

  final Album album;
  final String albumId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text(
          album.name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 250,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(album.image),
                            fit: BoxFit.cover)),
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.0)),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 164,
                          height: 164,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(album.image),
                                  fit: BoxFit.cover)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            sliver: SliverToBoxAdapter(
              child: _SongList(album: album),
            ),
          )
        ],
      ),
    );
  }
}

class _SongList extends StatefulWidget {
  _SongList({
    Key? key,
    required this.album,
  }) : super(key: key);

  Album album;
  final db = FirebaseFirestore.instance;

  @override
  State<_SongList> createState() => _SongListState();
}

class _SongListState extends State<_SongList> {
  List<Song> songs = List.empty();

  // void getSongsFromFirebase(List<QueryDocumentSnapshot> query) async {
  //   for (int i = 0; i < widget.album.songs.length; ++i) {
  //     DocumentSnapshot document;
  //     setState(() {
  //       Map<String, dynamic> data =
  //           document.get()data()! as Map<String, dynamic>;
  //       songs.add(Song.fromMap(data));
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.db.collection("Songs").get(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return ErrorWidget(snapshot.error!);
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          case ConnectionState.active:
          getSongsFromFirebase(snapshot.data!.docs);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: songs.length,
                    itemBuilder: (context, index) {
                      return SongTile(
                        song: songs[index],
                        songId: ,
                      );
                    },
                  ),
                ),
              ],
            );
          case ConnectionState.none:
            return ErrorWidget("The stream was wrong (connectionState.none)");
          case ConnectionState.done:
            return ErrorWidget("The stream has ended?!");
        }
      },
    );
  }
}
