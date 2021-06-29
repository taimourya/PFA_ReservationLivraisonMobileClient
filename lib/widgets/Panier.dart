import 'package:client/widgets/ChoixTypeCommande.dart';
import 'package:client/widgets/DrawerMenu.dart';
import 'package:flutter/material.dart';

class Panier extends StatefulWidget {

  @override
  _PanierState createState() {
    return _PanierState();
  }
}

class _PanierState extends State<Panier> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Colors.green,
      ),
      drawer: DrawerMenu(),
      body: Column(
        children: [
          SizedBox(height: 35,),
          Text(
              "Mon panier",
              style: Theme.of(context).textTheme.headline4
          ),
          SizedBox(height: 40,),
          Expanded(
            child: ListView.builder(

              itemCount: 3,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {

                      },
                    ),
                    title: Text('Item ${index}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("${"35"} DH"),
                        SizedBox(width: 20,),
                        Text("X ${1}"),
                        SizedBox(width: 20,),
                        IconButton(
                          icon: Icon(Icons.remove, color: Colors.red,),
                          onPressed: () {

                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.add, color: Colors.greenAccent,),
                          onPressed: () {

                          },
                        ),
                      ],
                    ),
                    subtitle: Text("Par ${'MCDO'}"),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20,),
          Text("total : ${'105'} DH", style: Theme.of(context).textTheme.headline5,),
          SizedBox(height: 10,),
          Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: Text("Passer la commande"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ChoixTypeCommande()),
                      );
                    },
                  ),
                ),
              ],
          ),
        ],
      )
    );
  }
}