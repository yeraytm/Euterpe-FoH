import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutters_of_hamelin/assets.dart';
import 'package:flutters_of_hamelin/colors.dart';
import 'package:flutters_of_hamelin/data/data.dart';
import 'package:flutters_of_hamelin/models/models.dart';
import 'package:flutters_of_hamelin/screens/screens.dart';
import 'package:flutters_of_hamelin/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late ScrollController _homeScrollController;
  @override
  void initState() {
    super.initState();
    _homeScrollController = ScrollController()
      ..addListener(() {
        //context.read<AppBarCubit>().setOffset(_homeScrollController.offset);
      });
  }

  @override
  void dispose() {
    super.dispose();
    _homeScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          Assets.euterpeLogo,
          scale: 1.25,
        ),
        centerTitle: true,
      ),
      body: const CustomScrollView(
        // controller: _homeScrollController,
        slivers: [
          SliverToBoxAdapter(
            child: _MainList(),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            sliver: SliverToBoxAdapter(
              child: _SongList(
                title: 'Top Albums',
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            sliver: SliverToBoxAdapter(
              child: _MultipleTracksList(
                title: 'Fast Play',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MainList extends StatefulWidget {
  const _MainList({Key? key}) : super(key: key);

  @override
  State<_MainList> createState() => _MainListState();
}

class _MainListState extends State<_MainList> {
  final CarouselController _titleCarouselController = CarouselController();
  int _titleCurrentIndex = 1;
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    Widget _buildCarousels() {
      switch (_titleCurrentIndex) {
        case 0:
          return StreamBuilder(
              stream: db.collection('Albums').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading...');
                }

                return CarouselSlider(
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    height: 250,
                    viewportFraction: 0.5,
                  ),
                  items: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    Album album = Album.fromMap(data);
                    return AlbumCard(album: album);
                  }).toList(),
                );
              });
        case 1:
          return StreamBuilder(
              stream: db.collection('Songs').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading...');
                }

                return CarouselSlider(
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    height: 250,
                    viewportFraction: 0.5,
                  ),
                  items: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    Song song = Song.fromMap(data);
                    return SongCard(song: song);
                  }).toList(),
                );
              });
        case 2:
          return StreamBuilder(
              stream: db.collection('Artists').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading...');
                }

                return CarouselSlider(
                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    height: 250,
                    viewportFraction: 0.5,
                  ),
                  items: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    data['id'] = document.id;
                    Artist artist = Artist.fromMap(data);
                    return ArtistCard(artist: artist);
                  }).toList(),
                );
              });
        default:
          return Container();
      }
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: Column(
        children: [
          CarouselSlider(
            options: CarouselOptions(
                initialPage: _titleCurrentIndex,
                onPageChanged: (index, reason) {
                  setState(() {
                    _titleCurrentIndex = index;
                  });
                },
                height: 50,
                scrollDirection: Axis.horizontal,
                viewportFraction: 0.3,
                scrollPhysics: const NeverScrollableScrollPhysics()),
            carouselController: _titleCarouselController,
            items: [
              GestureDetector(
                onTap: () {
                  _titleCarouselController.jumpToPage(0);
                },
                child: Text(
                  "Albums",
                  style: TextStyle(
                      fontSize: _titleCurrentIndex == 0 ? 24 : 18,
                      fontWeight: _titleCurrentIndex == 0
                          ? FontWeight.w700
                          : FontWeight.w600),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _titleCarouselController.jumpToPage(1);
                },
                child: Text(
                  "Songs",
                  style: TextStyle(
                      fontFamily: GoogleFonts.nunito().fontFamily,
                      fontSize: _titleCurrentIndex == 1 ? 24 : 18,
                      fontWeight: _titleCurrentIndex == 1
                          ? FontWeight.w700
                          : FontWeight.w600),
                ),
              ),
              GestureDetector(
                onTap: () {
                  _titleCarouselController.jumpToPage(2);
                },
                child: Text(
                  "Artists",
                  style: TextStyle(
                      fontFamily: GoogleFonts.nunito().fontFamily,
                      fontSize: _titleCurrentIndex == 2 ? 24 : 18,
                      fontWeight: _titleCurrentIndex == 2
                          ? FontWeight.w700
                          : FontWeight.w600),
                ),
              ),
            ],
          ),
          _buildCarousels(),
        ],
      ),
    );
  }
}

class _SongList extends StatelessWidget {
  const _SongList({Key? key, required this.title}) : super(key: key);
  final String title;
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
              stream:
                  FirebaseFirestore.instance.collection('Albums').snapshots(),
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
                                builder: (context) => AlbumInfo(album: album)));
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
  const _MultipleTracksList({Key? key, required this.title}) : super(key: key);
  final String title;
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
              stream:
                  FirebaseFirestore.instance.collection('Songs').snapshots(),
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
