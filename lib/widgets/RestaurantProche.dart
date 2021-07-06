import 'dart:convert';

import 'package:client/API/Host.dart';
import 'package:client/widgets/DrawerMenu.dart';
import 'package:client/widgets/MenuRestaurant.dart';
import 'package:client/widgets/Panier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class RestaurantProche extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RestaurantProcheState();
  }
  
}
class RestaurantProcheState extends State<RestaurantProche>{

  var currentPosition;
  dynamic data;

  Duration get loginTime => Duration(milliseconds: 500);
  late int userId;

  @override
  void initState() {
    super.initState();
    getSharedUserId();
    getCurrentPosition();
    Future.delayed(loginTime).then((_) {
      _getRestaurants();
    });
  }

  Future<void> getSharedUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('user_id');
    print(id);
    setState(() {
      userId = id == null? 0 : id;
    });
  }
  void _getRestaurants() {
    print("$currentPosition");
    var url = Uri.parse(
        "${Host.url}/restaurant/proche"
            "?latitude=${currentPosition.latitude}"
            "&longitude=${currentPosition.longitude}"
    );

    http.get(url).then((response) {
      print(response.body);
      if(response.statusCode == 200) {
        setState(() {
          data = json.decode(response.body);
        });
      }
    }).catchError((err) {
      print(err);
    });
  }

  Future<void> getCurrentPosition() async {
    setState(() async{
      currentPosition = await Geolocator.getCurrentPosition();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurants"),
        backgroundColor: Colors.green,
      ),
      drawer: DrawerMenu(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Panier()),
          );
        },
      ),
      body: Column(
        children: [
          data==null? Container() :
          Expanded(
            child: ListView.builder(

              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Icon(CupertinoIcons.eye),
                    title: Text("${data[index]['name']}"),
                    trailing: Text("${data[index]['ville']}"),
                    subtitle: Text("${data[index]['adresse']}"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>
                            MenuRestaurant("${data[index]['name']}", data[index]['user_id'])),
                      );
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
  
}