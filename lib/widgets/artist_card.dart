import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutters_of_hamelin/models/models.dart';
import 'package:flutters_of_hamelin/screens/screens.dart';

import '../colors.dart';

class ArtistCard extends StatefulWidget {
  ArtistCard({Key? key, required this.artist}) : super(key: key);
  final Artist artist;

  @override
  State<ArtistCard> createState() => _ArtistCardState();
}

class _ArtistCardState extends State<ArtistCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Stack(
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: NetworkImage(widget.artist.profileImg),
            ),
            Positioned(
              bottom: 50,
              left: 45,
              right: 45,
              child: ClipOval(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            white.withOpacity(0.2),
                            white.withOpacity(0.1)
                          ],
                          begin: AlignmentDirectional.topStart,
                          end: AlignmentDirectional.bottomEnd,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(25)),
                      ),
                      child: Center(
                        child: Text(
                          widget.artist.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: white,
                          ),
                        ),
                      )),
                ),
              ),
            )
          ],
        ));
  }
}
