import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutters_of_hamelin/assets.dart';
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
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
              child: SizedBox(
            height: 200,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(album.image), fit: BoxFit.cover)),
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                      child: Container(
                        decoration:
                            BoxDecoration(color: Colors.white.withOpacity(0.0)),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(album.name),
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(album.image),
                                fit: BoxFit.cover)),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
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
      height: 150,
      color: Colors.amber,
    );
  }
}
