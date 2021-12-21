import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: (){
          db.collection('Artists').add({
            'email':'alex01avilarodriguez@gmail.com',
            'fullname':'Alex Avila Rodriguez',
            'username':'Omicrxn',
            'profileImg':'',
            'bio':'This is my bio',
          });
        },
        child: Text('Trying Firebase'),
      ),
    );
  }
}
