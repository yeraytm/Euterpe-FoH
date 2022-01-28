part of 'audio_player_cubit_cubit.dart';

@immutable
abstract class AudioPlayerCubitState {
  const AudioPlayerCubitState();
}

class AudioPlayerUnloaded extends AudioPlayerCubitState {
  const AudioPlayerUnloaded();
}

class AudioPlayerLoaded extends AudioPlayerCubitState {
  const AudioPlayerLoaded();
}

class AudioPlayerError extends AudioPlayerCubitState {
  const AudioPlayerError();
}


