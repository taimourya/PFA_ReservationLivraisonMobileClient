import 'package:client/widgets/Login.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/Home.dart';

// @dart=2.9
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Client',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Login(),
    );
  }
}