import 'package:client/widgets/DrawerMenu.dart';
import 'package:client/widgets/Livraison.dart';
import 'package:client/widgets/Reservation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ChoixTypeCommande extends StatelessWidget {
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
              "Choix",
              style: Theme.of(context).textTheme.headline4
          ),
          SizedBox(height: 40,),
          Card(
            child: ListTile(
              leading: Icon(Icons.restaurant),
              title: Text("Reservation"),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Reservation()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.delivery_dining),
              title: Text("Livraison"),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Livraison(LatLng(0, 0))),
                );
              },
            ),
          ),
        ],
      )
    );
  }
}
