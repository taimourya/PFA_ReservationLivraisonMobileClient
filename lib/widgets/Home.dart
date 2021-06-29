

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/DrawerMenu.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.green,
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: Text("hello client"),
      ),
    );
  }

}