import 'package:flutter/material.dart';
import 'package:flutters_of_hamelin/services/database.dart';

class PlaylistForm extends StatefulWidget {
  PlaylistForm({Key? key, required this.userUid}) : super(key: key);
  String userUid;

  @override
  _PlaylistFormState createState() => _PlaylistFormState();
}

class _PlaylistFormState extends State<PlaylistForm> {
  DatabaseService db = DatabaseService();
  final _formKey = GlobalKey<FormState>();
  late String _playlistName = 'My New Playlist';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text(
            'Update your brew settings.',
            style: TextStyle(fontSize: 18.0),
          ),
          const SizedBox(height: 20.0),
          TextFormField(
            initialValue: _playlistName,
            // decoration: textInputDecoration,
            validator: (val) => val!.isEmpty ? 'Please enter a name' : null,
            onChanged: (val) => setState(() => _playlistName = val),
          ),
          const SizedBox(height: 20.0),
          // dropdown
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (states) => Colors.pink[400]),
            ),
            child: const Text(
              'Update',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                db.createPlaylist(_playlistName, widget.userUid);
                Navigator.pop(context);
              }
            },
          )
        ],
      ),
    );
  }
}
