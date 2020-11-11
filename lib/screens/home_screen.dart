import 'package:attendance/components/subject_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  static const String ID = 'HomeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var user = FirebaseAuth.instance.currentUser;
  var firestoreInstance = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Expanded(
          child: SubjectStream(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          try {
            firestoreInstance.collection('subjects').doc(user.uid).set(
              {
                'subjects': {
                  'Graphics': {
                    'total-class': 50,
                    'attended-class': 47,
                  }
                }
              },
              SetOptions(merge: true),
            );
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}
