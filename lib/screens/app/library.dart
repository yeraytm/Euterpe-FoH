import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutters_of_hamelin/data/data.dart';

class Library extends StatelessWidget {
  const Library({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle follStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );
    TextStyle numStyle = const TextStyle(
      fontSize: 14,
      color: Colors.white,
    );
    return Scaffold(
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(profile.banner), fit: BoxFit.fitHeight)),
            child: Column(
              children: [
                const SizedBox(height: 50),
                Text(
                  profile.name,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 25),
                CircleAvatar(
                  backgroundImage: AssetImage(profile.avatar),
                  radius: 50,
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Followers",
                          style: follStyle,
                        ),
                        Text(
                          '${profile.followers}',
                          style: numStyle,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Following",
                          style: follStyle,
                        ),
                        Text(
                          '${profile.following}',
                          style: numStyle,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),
          const SizedBox(height: 15),
          const _ArtistList(title: 'Artists'),
          const SizedBox(height: 15),
          const _GenreList(title: 'Genres'),
        ],
      ),
    );
  }
}

class _ArtistList extends StatelessWidget {
  const _ArtistList({Key? key, required this.title}) : super(key: key);
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
                shape: BoxShape.circle,
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

class _GenreList extends StatelessWidget {
  const _GenreList({Key? key, required this.title}) : super(key: key);
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
          height: 135,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: genreList.length ~/ 2,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              width: 200,
              child: Column(
                children: [
                  Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                    ),
                    child: Center(
                      child: Text(
                        genreList[index],
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                    ),
                    child: Center(
                      child: Text(genreList[index + genreList.length ~/ 2],
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
