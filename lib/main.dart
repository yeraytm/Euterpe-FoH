import 'package:flutter/material.dart';
import 'package:flutters_of_hamelin/screens/screens.dart';
void main() {
  runApp(Euterpe());
}

class Euterpe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNav(),
    );
  }
}
