import 'package:client/widgets/DrawerMenu.dart';
import 'package:client/widgets/Localisation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Livraison extends StatefulWidget {

  LatLng latLng;

  Livraison(this.latLng);

  @override
  _LivraisonState createState() {
    return _LivraisonState();
  }
}

class _LivraisonState extends State<Livraison> {

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
          SizedBox(height: 50,),
          Row(
            children: [
              TextButton(
                child: Text(
                  "Localisation du lieux de la livraison",
                  style: TextStyle(color: Colors.blue, fontSize: 20),
                ),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Localisation()),
                  );
                },
              ),
              SizedBox(width: 20,),

              widget.latLng.latitude == 0?
                Icon(Icons.warning_amber_sharp, color: Colors.red,)
                :
                Icon(Icons.check, color: Colors.green,)
            ],
          ),

          SizedBox(height: 50,),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if(widget.latLng.latitude != 0 && widget.latLng.longitude != 0)
                    {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text('Livraison en ${widget.latLng}')));
                    }
                  },
                  child: Text('Valider'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}