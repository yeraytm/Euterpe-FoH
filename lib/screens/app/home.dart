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
                children: [
                  MainList(),
                ],
              ),
            )
          ],
        ));
  }
}

class MainList extends StatefulWidget {
  MainList({Key? key}) : super(key: key);

  @override
  State<MainList> createState() => _MainListState();
}

class _MainListState extends State<MainList> {
  final CarouselController _carouselController = CarouselController();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: CarouselSlider(
        options: CarouselOptions(
            initialPage: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
            height: 100,
            scrollDirection: Axis.horizontal,
            viewportFraction: 0.3,
            scrollPhysics: NeverScrollableScrollPhysics()),
        carouselController: _carouselController,
        items: [
          GestureDetector(
            onTap: () {
              _carouselController.jumpToPage(0);
            },
            child: Text(
              "Albums",
              style: TextStyle(
                  fontSize: _currentIndex == 0 ? 24 : 18,
                  fontWeight:
                      _currentIndex == 0 ? FontWeight.w700 : FontWeight.w600),
            ),
          ),
          GestureDetector(
            onTap: () {
              _carouselController.jumpToPage(1);
            },
            child: Text(
              "Songs",
              style: TextStyle(
                  fontSize: _currentIndex == 1 ? 24 : 18,
                  fontWeight:
                      _currentIndex == 1 ? FontWeight.w700 : FontWeight.w600),
            ),
          ),
          GestureDetector(
            onTap: () {
              _carouselController.jumpToPage(2);
            },
            child: Text(
              "Artists",
              style: TextStyle(
                  fontSize: _currentIndex == 2 ? 24 : 18,
                  fontWeight:
                      _currentIndex == 2 ? FontWeight.w700 : FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
