import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  Future testData() async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    var data = await db.collection('event-details').get();

    var details = data.docs.toList();

    details.forEach((document) {
      print(document.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    testData();
    return MaterialApp(
      title: 'Events',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Scaffold(),
    );
  }
}
