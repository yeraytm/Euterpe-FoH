import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutters_of_hamelin/cubit/audio_player_cubit_cubit.dart';
import 'package:flutters_of_hamelin/models/models.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/percent_indicator.dart';

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
    context
        .read<AudioPlayerCubitCubit>()
        .openAudioPlayer(widget.song, artistName);
    setState(() {
      assetsAudioPlayer =
          context.read<AudioPlayerCubitCubit>().assetsAudioPlayer;
    });
    _updatePaletteGenerator(widget.song.img);
  }

  @override
  Widget build(BuildContext context) {
    String _printDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }

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
            StreamBuilder(
              stream: assetsAudioPlayer.currentPosition,
              builder: (context, AsyncSnapshot<Duration> asyncSnapshot) {
                if (asyncSnapshot.hasData) {
                  final Duration duration = asyncSnapshot.data!;
                  return PlayerBuilder.current(
                    player: assetsAudioPlayer,
                    builder: (context, playing) {
                      return CircularPercentIndicator(
                        arcType: ArcType.FULL,
                        arcBackgroundColor: Colors.white,
                        radius: 170,
                        lineWidth: 5.0,
                        percent: (duration.inSeconds /
                            playing.audio.duration.inSeconds),
                        center: SongImageCircle(imgUri: widget.song.img),
                        progressColor:
                            _paletteGenerator?.lightVibrantColor != null
                                ? _paletteGenerator?.lightVibrantColor?.color
                                : Colors.greenAccent,
                        backgroundColor: Colors.white,
                      );
                    },
                  );
                } else {
                  return SongImageCircle(imgUri: widget.song.img);
                }
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PlayerBuilder.currentPosition(
                        player: assetsAudioPlayer,
                        builder: (context, duration) {
                          return Text(
                            ' ${_printDuration(duration)} / ',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          );
                        }),
                    PlayerBuilder.current(
                        player: assetsAudioPlayer,
                        builder: (context, playing) {
                          return Text(_printDuration(playing.audio.duration),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16));
                        })
                  ],
                ),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    assetsAudioPlayer.playOrPause();
                  },
                  child: PlayerBuilder.isPlaying(
                      player: assetsAudioPlayer,
                      builder: (cotext, isPlaying) {
                        return CircleAvatar(
                            radius: 36,
                            backgroundColor:
                                _paletteGenerator?.lightVibrantColor != null
                                    ? _paletteGenerator
                                        ?.lightVibrantColor?.color
                                    : Colors.blue,
                            child: isPlaying
                                ? Icon(
                                    Icons.pause,
                                    size: 48,
                                    color: Colors.black,
                                  )
                                : Icon(
                                    Icons.play_arrow,
                                    size: 48,
                                    color: Colors.black,
                                  ));
                      }),
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
