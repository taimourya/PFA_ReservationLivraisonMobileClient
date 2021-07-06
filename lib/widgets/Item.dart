



import 'dart:convert';

import 'package:client/API/Host.dart';
import 'package:client/widgets/Panier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/DrawerMenu.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class Item extends StatefulWidget {

  int itemId;

  Item(this.itemId);

  @override
  State<StatefulWidget> createState() {
    return StatItem();
  }
}

class StatItem extends State<Item> {


  dynamic data;

  Duration get loginTime => Duration(milliseconds: 100);
  late int userId;

  @override
  void initState() {
    super.initState();
    getSharedUserId();
    Future.delayed(loginTime).then((_) {
      _initItem();
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
  _initItem() {
    var url = Uri.parse(
        "${Host.url}/buyable?id=${widget.itemId}"
    );
    http.get(url).then((response) {
      print(response.body);
      setState(() {
        data = json.decode(response.body);
      });
    }).catchError((err) {
      print(err);

    });
  }

  _addPanier(int itemId) {
    var url = Uri.parse(
        "${Host.url}/panier?client_id=${userId}&operation=add&buyable_id=$itemId"
    );
    http.get(url).then((response) {
      print(response.body);
      if(response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Produit ajouter')));
      }
    }).catchError((err) {
      print(err);

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Item info"),
        backgroundColor: Colors.green,
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            child: Icon(Icons.add_shopping_cart),
            onPressed: () {
              _addPanier(widget.itemId);
            },
          ),
          SizedBox(width: 20,),
          FloatingActionButton(
            child: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Panier()),
              );
            },
          )
        ],
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50,),
            Text(
                "${data != null ? data['name']: '...'}",
                style: Theme.of(context).textTheme.headline4
            ),
            SizedBox(height: 35,),

            data != null? (data['category'] != null?
              Text(
                  "Categorie : ${data != null ? data['category']['name']: "..."}",
                  style: Theme.of(context).textTheme.headline5
              )
                  :
              Text("")
            )
                :
            Text(""),

            SizedBox(height: 35,),
            Text(
                "Prix : ${data != null ? data['price']: "..."} DH",
                style: Theme.of(context).textTheme.headline5
            ),


          ],
        ),
      ),
    );
  }
}