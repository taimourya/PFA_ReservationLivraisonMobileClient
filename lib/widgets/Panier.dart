import 'dart:convert';

import 'package:client/API/Host.dart';
import 'package:client/widgets/ChoixTypeCommande.dart';
import 'package:client/widgets/DrawerMenu.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Panier extends StatefulWidget {

  @override
  _PanierState createState() {
    return _PanierState();
  }
}

class _PanierState extends State<Panier> {

  String total = "";

  dynamic data;
  Duration get loginTime => Duration(milliseconds: 100);
  late int userId;

  @override
  void initState() {
    super.initState();
    getSharedUserId();
    Future.delayed(loginTime).then((_) {
      _getPanier();
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
  _getPanier() {
    var url = Uri.parse(
        "${Host.url}/panier?client_id=${userId}&operation=get"
    );
    http.get(url).then((response) {
      print(response.body);
      if(response.statusCode == 200) {
        setState(() {
            data = json.decode(response.body);
            data = data['items'];
        });
        _getTotalPanier();
      }
    }).catchError((err) {
      print(err);

    });
  }

  _getTotalPanier() {
    var url = Uri.parse(
        "${Host.url}/panier/total?client_id=${userId}"
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

  _addQtnPanier(int itemId) {
    var url = Uri.parse(
        "${Host.url}/panier?client_id=${userId}&operation=add&buyable_id=$itemId"
    );
    http.get(url).then((response) {
      print(response.body);
      _getPanier();
    }).catchError((err) {
      print(err);

    });
  }
  _remQtnPanier(int itemId) {
    var url = Uri.parse(
        "${Host.url}/panier?client_id=${userId}&operation=rem&buyable_id=$itemId"
    );
    http.get(url).then((response) {
      print(response.body);
      _getPanier();
    }).catchError((err) {
      print(err);

    });
  }
  _delPanier(int itemId) {
    var url = Uri.parse(
        "${Host.url}/panier?client_id=${userId}&operation=del&buyable_id=$itemId"
    );
    http.get(url).then((response) {
      print(response.body);
      _getPanier();
    }).catchError((err) {
      print(err);

    });
  }

  _clearPanier(int itemId) {
    var url = Uri.parse(
        "${Host.url}/panier?client_id=${userId}&operation=clear"
    );
    http.get(url).then((response) {
      print(response.body);
      _getPanier();
    }).catchError((err) {
      print(err);

    });
  }

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

          data == null?
          Text("Panier vide")
            :
          Expanded(
            child: ListView.builder(

              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _delPanier(data[index]['id']);
                      },
                    ),
                    title: Text("${data[index]['name']}"),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("${data[index]['price']} DH"),
                        SizedBox(width: 20,),
                        Text("X ${data[index]['qtn']}"),
                        SizedBox(width: 20,),
                        IconButton(
                          icon: Icon(Icons.remove, color: Colors.red,),
                          onPressed: () {
                            _remQtnPanier(data[index]['id']);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.add, color: Colors.greenAccent,),
                          onPressed: () {
                            _addQtnPanier(data[index]['id']);
                          },
                        ),
                      ],
                    ),
                    subtitle: Text("Par ${data[index]['restaurantName']}"),
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 20,),
          Text("total : $total DH", style: Theme.of(context).textTheme.headline5,),
          SizedBox(height: 10,),
          Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    child: Text("Passer la commande"),
                    onPressed: () {
                      if(data != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChoixTypeCommande()),
                        );
                      }
                      else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('Le panier ne doit pas etre vide')));
                      }
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