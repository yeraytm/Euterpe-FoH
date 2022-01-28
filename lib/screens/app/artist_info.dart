import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutters_of_hamelin/assets.dart';
import 'package:flutters_of_hamelin/models/models.dart';
import 'package:flutters_of_hamelin/screens/screens.dart';
import 'package:flutters_of_hamelin/widgets/widgets.dart';

class ArtistInfo extends StatelessWidget {
  const ArtistInfo({Key? key, required this.artist}) : super(key: key);
  final Artist artist;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.banner),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      artist.name,
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(artist.profileImg),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          _SongList(
            title: '${artist.name}\'s Albums',
            artist: artist,
          ),
          SizedBox(
            height: 16,
          ),
          _MultipleTracksList(title: '${artist.name}\'s Songs', artist: artist),
        ],
      ),
    );
  }
}

class _SongList extends StatelessWidget {
  const _SongList({Key? key, required this.title, required this.artist})
      : super(key: key);
  final String title;
  final Artist artist;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 100,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Albums')
                  .where('artist', isEqualTo: artist.id)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }
                return ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    Album album = Album.fromMap(data);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AlbumInfo(
                                    album: album, albumId: document.id)));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          image: DecorationImage(
                              image: NetworkImage(album.image),
                              fit: BoxFit.cover),
                        ),
                      ),
                    );
                  }).toList(),
                );
              }),
        ),
      ],
    );
  }
}

class _MultipleTracksList extends StatelessWidget {
  const _MultipleTracksList(
      {Key? key, required this.title, required this.artist})
      : super(key: key);
  final String title;
  final Artist artist;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 232,
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Songs')
                  .where('artist', isEqualTo: artist.id)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading...');
                }
                return GridView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  scrollDirection: Axis.horizontal,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1 / 5,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    Song song = Song.fromMap(data);
                    return SongTile(
                      song: song,
                      songId: document.id,
                    );
                  }).toList(),
                );
              }),
        ),
      ],
    );
  }
}
