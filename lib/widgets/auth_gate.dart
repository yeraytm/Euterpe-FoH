import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutters_of_hamelin/screens/screens.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key, required this.app}) : super(key: key);
  final Widget app;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (!snapshot.hasData) {
          return const CustomSignInScreen();
        }
        return app;
      },
    );
  }
}
