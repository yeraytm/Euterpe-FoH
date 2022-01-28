import 'package:flutters_of_hamelin/assets.dart';
import 'package:flutters_of_hamelin/models/models.dart';

final List<Song> songList = [
  //Song(img:Assets.arcaneCover,name: 'What Could Have Been',artist:'League of Legends', description:'',uri:'',isPlayable: '',isLocal: '',trackNumber:0,popularity:0),
  //Song(img:Assets.dojaCatCover,name: 'Woman',artist:'Doja Cat',description:'',uri:'',isPlayable: '',isLocal: '',trackNumber:0,popularity:0),
  Song(img:Assets.nickyNicoleCover,name: 'Baby',artist:'Nicky Nicole',song: ''),
];

final List<String> genreList = [
  'Rock',
  'Heavy',
  'Punk',
  'Reggae',
  'Rap',
  'Trap',
  'Reggaeton',
  'Classic'
];

final Profile profile = Profile(
    avatar: Assets.avatar,
    banner: Assets.banner,
    name: 'Mr. Jagger',
    description: 'A beautiful guy.',
    followers: 1000000,
    following: 500);