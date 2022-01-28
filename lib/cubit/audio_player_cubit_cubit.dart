import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:bloc/bloc.dart';
import 'package:flutters_of_hamelin/models/models.dart';
import 'package:meta/meta.dart';

part 'audio_player_cubit_state.dart';

class AudioPlayerCubitCubit extends Cubit<AudioPlayerCubitState> {
  AudioPlayerCubitCubit() : super(const AudioPlayerUnloaded());
  final assetsAudioPlayer = AssetsAudioPlayer();

  void openAudioPlayer(Song song, String artistName) async {
    try {
      assetsAudioPlayer.stop();
      await assetsAudioPlayer.open(
          Audio.network(song.song,
              metas: Metas(
                  title: song.name,
                  artist: artistName,
                  image: MetasImage.network(song.img))),
          showNotification: true);
    } catch (t) {
      print(t);
      rethrow;
    }
  }

  void dispose() {
    assetsAudioPlayer.dispose();
    emit(const AudioPlayerUnloaded());
  }
}
