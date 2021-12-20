import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutters_of_hamelin/assets.dart';
import 'package:flutters_of_hamelin/colors.dart';
import 'package:flutters_of_hamelin/data/data.dart';
import 'dart:ui';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

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
        slivers: [
          SliverFillRemaining(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _MainList(),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: _SongList(
                    title: 'Top Albums',
                  ),
                ),
                // _SongList(
                //   title: 'Recommended Songs',
                //   isVertical: true,
                // ),
                
              ],
            ),
          )
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
  const _SongList({Key? key, required this.title, this.isVertical = false})
      : super(key: key);
  final String title;
  final bool isVertical;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
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
        isVertical
            ? Expanded(
                child: ListView.builder(
                  
                    itemCount: songList.length,
                    itemBuilder: (context, index) => Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            image: DecorationImage(
                                image: AssetImage(songList[index].img),
                                fit: BoxFit.cover),
                          ),
                        )),
              )
            : SizedBox(
                height: 100,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: songList.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemBuilder: (context, index) => isVertical
                        ? Container()
                        : Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              image: DecorationImage(
                                  image: AssetImage(songList[index].img),
                                  fit: BoxFit.cover),
                            ),
                          )),
              ),
      ],
    );
  }
}
