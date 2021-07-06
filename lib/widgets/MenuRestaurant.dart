import 'package:client/widgets/DrawerMenu.dart';
import 'package:client/widgets/ItemsList.dart';
import 'package:client/widgets/Panier.dart';
import 'package:client/widgets/items.dart';
import 'package:flutter/material.dart';

class MenuRestaurant extends StatefulWidget {


  String restaurant_name;
  int restaurant_id;

  MenuRestaurant(this.restaurant_name, this.restaurant_id);

  @override
  _MenuStateRestaurant createState() {
    return _MenuStateRestaurant();
  }
}

class _MenuStateRestaurant extends State<MenuRestaurant> {


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
      body: Items(widget.restaurant_id),
    );
  }
}