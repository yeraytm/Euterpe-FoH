import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutters_of_hamelin/assets.dart';
import 'package:flutters_of_hamelin/colors.dart';
import 'package:flutters_of_hamelin/cubit/cubits.dart';
import 'package:flutters_of_hamelin/data/data.dart';
import 'dart:ui';
import 'package:provider/src/provider.dart';

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
      body: CustomScrollView(
        // controller: _homeScrollController,
        slivers: [
          SliverToBoxAdapter(
            child: _MainList(),
          ),
          const SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            sliver: SliverToBoxAdapter(
              child: _SongList(
                title: 'Top Albums',
              ),
            ),
          ),
          const SliverPadding(
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
  _MainList({Key? key}) : super(key: key);

  @override
  State<_MainList> createState() => _MainListState();
}

class _MainListState extends State<_MainList> {
  final CarouselController _titleCarouselController = CarouselController();
  int _titleCurrentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                scrollPhysics: NeverScrollableScrollPhysics()),
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
                      fontSize: _titleCurrentIndex == 2 ? 24 : 18,
                      fontWeight: _titleCurrentIndex == 2
                          ? FontWeight.w700
                          : FontWeight.w600),
                ),
              ),
            ],
          ),
          CarouselSlider(
            options: CarouselOptions(
              enlargeCenterPage: true,
              height: 250,
              viewportFraction: 0.5,
            ),
            items: songList
                .map(
                  (song) => Builder(
                    builder: (context) {
                      return SizedBox(
                        // width: 185,
                        // height: 230,
                        child: Card(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16)),
                                  image: DecorationImage(
                                      image: AssetImage(song.img),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Positioned(
                                bottom: 7,
                                left: 5,
                                right: 5,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  child: BackdropFilter(
                                    filter:
                                        ImageFilter.blur(sigmaX: 3, sigmaY: 3),
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
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(8)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                song.name,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                  color: white,
                                                ),
                                              ),
                                              Text(
                                                song.artist,
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  color: white,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const CircleAvatar(
                                            radius: 16,
                                            child: Icon(Icons.play_arrow),
                                          )
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
                    },
                  ),
                )
                .toList(),
          ),
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
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: songList.length,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              width: 100,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                image: DecorationImage(
                    image: AssetImage(songList[index].img), fit: BoxFit.cover),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MultipleTracksList extends StatelessWidget {
  const _MultipleTracksList({Key? key, required this.title}) : super(key: key);
  final title;
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
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            scrollDirection: Axis.horizontal,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1 / 5,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: songList.length,
            itemBuilder: (context, index) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        width: 64,
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          image: DecorationImage(
                            image: AssetImage(songList[index].img),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            songList[index].name,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            songList[index].artist,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Icon(Icons.favorite_outline),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
