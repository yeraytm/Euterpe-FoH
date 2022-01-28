import 'package:flutter/material.dart';

class AlbumInfo extends StatelessWidget {
  const AlbumInfo({Key? key}) : super(key: key);

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
  return Container();
}
