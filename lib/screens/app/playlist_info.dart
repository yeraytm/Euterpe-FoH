import 'package:flutter/material.dart';
import 'package:flutters_of_hamelin/data/data.dart';

class PlaylistInfo extends StatelessWidget {
  const PlaylistInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: _buildScreen(),
    );
  }
}

Widget _buildScreen() {
  TextStyle follStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  TextStyle numStyle = const TextStyle(
    fontSize: 14,
    color: Colors.white,
  );
  return ListView(
    children: [
      Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(profile.banner), fit: BoxFit.fitHeight)),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                image: DecorationImage(
                    image: AssetImage(songList.elementAt(0).img),
                    fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    ],
  );
}
