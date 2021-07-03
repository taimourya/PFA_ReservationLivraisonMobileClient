import 'dart:convert';

import 'package:client/API/Host.dart';
import 'package:client/widgets/DrawerMenu.dart';
import 'package:client/widgets/Home.dart';
import 'package:client/widgets/Localisation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Livraison extends StatefulWidget {

  LatLng latLng;

  Livraison(this.latLng);

  @override
  _LivraisonState createState() {
    return _LivraisonState();
  }
}

class _LivraisonState extends State<Livraison> {

  String total = "";

  Duration get loginTime => Duration(milliseconds: 100);
  late int userId;
  dynamic data;

  @override
  void initState() {
    super.initState();
    getSharedUserId();
    Future.delayed(loginTime).then((_) {
      _getTotalPanier();
    });
  }

  Future<void> getSharedUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('user_id');

    setState(() {
      userId = id == null? 0 : id;
    });
  }

  saveLivraison() {
    http.post(
      Uri.parse('http://${Host.url}:8080/commande/livraison'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Object>{
        "client_id": userId,
        "latitude": widget.latLng.latitude,
        "longitude": widget.latLng.longitude
      }),
    ).then((response) {
      if(response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Livraison en effecutué')));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
      else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(json.decode(response.body)['message'])));
      }
    });
  }

  _getTotalPanier() {
    var url = Uri.parse(
        "http://${Host.url}:8080/panier/total?client_id=${userId}"
    );
    http.get(url).then((response) {
      print(response.body);
      if(response.statusCode == 200) {
        setState(() {
          total = response.body;
        });
      }
    }).catchError((err) {
      print(err);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Livraison"),
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

          Text("Total elements : ${total} DH", style: Theme.of(context).textTheme.headline5,),
          SizedBox(height: 20,),
          Text("Reservation : ${'5'} DH", style: Theme.of(context).textTheme.headline5,),
          SizedBox(height: 20,),
          Text("Total : ${double.parse(total,(source) => 0) + 5 } DH", style: Theme.of(context).textTheme.headline5,),

          SizedBox(height: 50,),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if(widget.latLng.latitude != 0 && widget.latLng.longitude != 0)
                    {
                      saveLivraison();
                    }
                    else {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text("vous devez choisir le lieux de livraison")));
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