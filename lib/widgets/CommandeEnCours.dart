


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/DrawerMenu.dart';
import 'package:client/widgets/LivraisonEnCours.dart';
import 'package:client/widgets/ReservationEnCours.dart';

class CommandeEnCours extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateCommandeEnCours();
  }


}

class _StateCommandeEnCours extends State<CommandeEnCours>{



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text("Settings"),
            bottom: TabBar(
              tabs: [
                Tab(text: "Livraison", icon: Icon(Icons.table_chart)),
                Tab(text: "Reservation", icon: Icon(Icons.table_chart)),
              ],
            ),
          ),
          drawer: DrawerMenu(),
          body: TabBarView(
            children: <Widget>[
              LivraisonEnCours(),
              ReservationEnCours(),
            ],
          ),
        )
    );
  }



}