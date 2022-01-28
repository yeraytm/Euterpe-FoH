import 'package:flutter/material.dart';
import 'package:flutters_of_hamelin/models/models.dart';

class AlbumInfo extends StatelessWidget {
  const AlbumInfo({
    Key? key,
    required this.album,
  }) : super(key: key);

  final Album album;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Album'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              width: 50,
              decoration: BoxDecoration(
                //borderRadius: const BorderRadius.all(Radius.circular(8)),
                image: DecorationImage(
                    image: NetworkImage(album.image), fit: BoxFit.cover),
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            sliver: SliverToBoxAdapter(child: _SongList()),
          )
        ],
      ),
    );
  }
}

class _SongList extends StatelessWidget {
  const _SongList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
    );
  }
}
