import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutters_of_hamelin/cubit/audio_player_cubit_cubit.dart';
import 'package:flutters_of_hamelin/data/data.dart';
import 'package:flutters_of_hamelin/models/models.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({Key? key, required this.song}) : super(key: key);
  final Song song;
  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  late final AssetsAudioPlayer assetsAudioPlayer;
  String artistName = '';
  PaletteGenerator? _paletteGenerator;

  Future<void> _updatePaletteGenerator(String img) async {
    _paletteGenerator = await PaletteGenerator.fromImageProvider(
      NetworkImage(img),
      maximumColorCount: 15,
    );
    setState(() {});
  }

  void getArtist() async {
    final doc = FirebaseFirestore.instance
        .collection('Artists')
        .doc(widget.song.artist);
    DocumentSnapshot documentSnapshot = await doc.get();
    setState(() {
      artistName = documentSnapshot.get('name');
    });
  }

  @override
  void initState() {
    super.initState();
    getArtist();
    context.read<AudioPlayerCubitCubit>().openAudioPlayer(widget.song,artistName);
    setState(() {
      assetsAudioPlayer = context.read<AudioPlayerCubitCubit>().assetsAudioPlayer;
    });
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
          artistName,
          style: TextStyle(
              fontFamily: GoogleFonts.nunito().fontFamily, fontSize: 16),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
        ],
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
              artistName,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: GoogleFonts.notoSans().fontFamily,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 16,
            ),
            SongImageCircle(imgUri: widget.song.img),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                GestureDetector(
                  onTap: () {
                    assetsAudioPlayer.playOrPause();
                  },
                  child: CircleAvatar(
                      radius: 36,
                      child: assetsAudioPlayer.isPlaying.value ? Icon(Icons.pause): Icon(
                        Icons.play_arrow,
                        size: 48,
                      )),
                ),
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
      backgroundImage: NetworkImage(imgUri),
    );
  }
}
