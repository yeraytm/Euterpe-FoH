import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutters_of_hamelin/data/data.dart';
import 'package:flutters_of_hamelin/models/models.dart';
import 'package:flutters_of_hamelin/screens/app/playlist_form.dart';
import 'package:flutters_of_hamelin/screens/app/playlist_songs.dart';
import 'package:flutters_of_hamelin/services/database.dart';
import 'package:flutters_of_hamelin/widgets/playlist_tile.dart';

class Library extends StatelessWidget {
  Library({Key? key}) : super(key: key);
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    Widget _buildScreen(AppUser user) {
      TextStyle follStyle = const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      );
      TextStyle numStyle = const TextStyle(
        fontSize: 14,
        color: Colors.white,
      );
      return Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(profile.banner),
              fit: BoxFit.fitWidth,
            )),
            child: Column(
              children: [
                const SizedBox(height: 15),
                Text(
                  user.username,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 15),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(profile.avatar),
                  radius: 50,
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
          const SizedBox(height: 15),
          // const _ArtistList(title: 'Artists'),
          // const SizedBox(height: 15),
          // const _GenreList(title: 'Genres'),
          const _PlaylistList(title: 'My Playlists'),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(
                Icons.person_off,
                color: Colors.white,
              ),
              label: const Text(
                'Sign out',
                style: TextStyle(color: Colors.white),
              )),
        ],
        backgroundColor: Colors.black,
        title: const Text('Profile'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: db.collection('Users').doc(auth.currentUser!.uid).get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasData) {
              AppUser user = AppUser.fromMap(
                  snapshot.data!.data() as Map<String, dynamic>);
              return _buildScreen(user);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

// class _ArtistList extends StatelessWidget {
//   const _ArtistList({Key? key, required this.title}) : super(key: key);
//   final String title;
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Text(
//             title,
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 8,
//         ),
//         SizedBox(
//           height: 100,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: songList.length,
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             itemBuilder: (context, index) => Container(
//               margin: const EdgeInsets.symmetric(horizontal: 8.0),
//               width: 100,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 image: DecorationImage(
//                     image: AssetImage(songList[index].img), fit: BoxFit.cover),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

class _PlaylistList extends StatefulWidget {
  const _PlaylistList({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<_PlaylistList> createState() => _PlaylistListState();
}

class _PlaylistListState extends State<_PlaylistList> {
  final db = FirebaseFirestore.instance;
  void _showPlaylistPanel(String userUid) {
    String id = userUid;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: PlaylistForm(userUid: id),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    DatabaseService db = DatabaseService();
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Expanded(child: SizedBox()),
                TextButton.icon(
                  onPressed: () {
                    _showPlaylistPanel(db.currentUser!.uid);
                  },
                  icon: const Icon(Icons.add, color: Colors.black),
                  label: const Text(
                    'Create Playlist',
                    style: TextStyle(color: Colors.black),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: StreamBuilder(
              stream: db.users
                  .doc(db.currentUser!.uid)
                  .collection('Playlists')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const Text('Something went wrong.');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    List list = data['songs'];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: PlaylistTile(
                        songId: list.isNotEmpty ? list[0] : null,
                        // playlistTitle: data['name'],
                        playlistTitle: data['name'],
                        playlistId: document.id,
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
