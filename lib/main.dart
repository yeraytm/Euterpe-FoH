import 'package:flutter/material.dart';
import 'package:flutters_of_hamelin/screens/screens.dart';
void main() {
  runApp(const Euterpe());
}

class Euterpe extends StatelessWidget {
  const Euterpe({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNav(),
    );
  }
}
