



import 'package:client/widgets/Panier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/DrawerMenu.dart';


class Item extends StatefulWidget {

  int itemId;

  Item(this.itemId);

  @override
  State<StatefulWidget> createState() {
    return StatItem();
  }
}

class StatItem extends State<Item> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Item info"),
        backgroundColor: Colors.green,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_shopping_cart),
        onPressed: () {
          //ajouter l'item au panier avant ...
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Panier()),
          );
        },
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Text(
                "Nom de l'item ID ${widget.itemId}",
                style: Theme.of(context).textTheme.headline4
            ),
            SizedBox(height: 35,),
            Text(
                "Categorie : ${"Food"}",
                style: Theme.of(context).textTheme.headline5
            ),
            SizedBox(height: 35,),
            Text(
                "Prix : ${"35"} DH",
                style: Theme.of(context).textTheme.headline5
            ),


          ],
        ),
      ),
    );
  }
}