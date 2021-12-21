import 'package:flutter/material.dart';
import 'package:flutters_of_hamelin/models/models.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palette_generator/palette_generator.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({Key? key, required this.song}) : super(key: key);
  final Song song;
  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  PaletteGenerator? _paletteGenerator;
  Future<void> _updatePaletteGenerator(String img) async {
    _paletteGenerator = await PaletteGenerator.fromImageProvider(
      AssetImage(img),
      maximumColorCount: 15,
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _updatePaletteGenerator(widget.song.img);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _paletteGenerator?.dominantColor?.color,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.song.artist,
          style: TextStyle(
              fontFamily: GoogleFonts.nunito().fontFamily, fontSize: 16),
        ),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz))],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.song.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: GoogleFonts.notoSans().fontFamily,
                  fontWeight: FontWeight.w700,
                  color: Colors.white),
            ),
            Text(
              widget.song.artist,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: GoogleFonts.notoSans().fontFamily,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            SizedBox(
              height: 16,
            ),
            SongImageCircle(imgUri: widget.song.img),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Icon(
                  Icons.block,
                  color: Colors.white,
                  size: 48,
                ),
                Icon(
                  Icons.skip_previous,
                  color: Colors.white,
                  size: 48,
                ),
                CircleAvatar(
                    radius: 36,
                    child: Icon(
                      Icons.play_arrow,
                      size: 48,
                    )),
                Icon(
                  Icons.skip_next,
                  color: Colors.white,
                  size: 48,
                ),
                Icon(
                  Icons.favorite_outline,
                  color: Colors.white,
                  size: 48,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class SongImageCircle extends StatelessWidget {
  const SongImageCircle({Key? key, required this.imgUri}) : super(key: key);
  final String imgUri;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.white,
      radius: 150,
      backgroundImage: AssetImage(imgUri),
    );
  }
}
