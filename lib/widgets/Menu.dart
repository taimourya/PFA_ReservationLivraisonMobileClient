import 'package:client/widgets/DrawerMenu.dart';
import 'package:client/widgets/ItemsList.dart';
import 'package:client/widgets/Panier.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {

  @override
  _MenuState createState() {
    return _MenuState();
  }
}

class _MenuState extends State<Menu> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
        backgroundColor: Colors.green,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Panier()),
          );
        },
      ),
      drawer: DrawerMenu(),
      body: ItemsList("Menu")
    );
  }
}