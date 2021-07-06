



import 'dart:convert';

import 'package:client/API/Host.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/Item.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Items extends StatefulWidget {

  int restaurantId;

  Items(this.restaurantId);

  @override
  State<StatefulWidget> createState() {
    return StatItem();
  }
}

class StatItem extends State<Items> {

  String searchText = "";
  final _formKey = GlobalKey<FormState>();


  dynamic data;

  Duration get loginTime => Duration(milliseconds: 100);
  late int userId;

  @override
  void initState() {
    super.initState();
    getSharedUserId();
    Future.delayed(loginTime).then((_) {
      _getMenu();
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

  void _getMenu() {
    var url = Uri.parse(
        "${Host.url}/restaurant/menu"
        "?restaurant_id=${widget.restaurantId}"
        "&mc=$searchText"
    );
    http.get(url)
        .then((response) {
      print(response.body);
      setState(() {
        data = json.decode(response.body);
      });
    })
        .catchError((err) {
      print(err);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10,),
        Form(
          child: Row(
            children: [
              SizedBox(width: 10,),
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    hintText: "Rechercher",
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'saisisez quelque chose';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    this.setState(() {
                      this.searchText = value;
                    });
                    _getMenu();
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {

                },
              )
            ],
          ),
        ),
        SizedBox(height: 35,),


        data!=null?(data.length == 0? Text("Aucun element trouver") : Text("")) : Text(""),


        Expanded(
          child: data == null? Container():ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Icon(CupertinoIcons.eye),
                  title: Text("${data[index]['name']}"),
                  trailing: Text("${data[index]['price']} DH"),
                  subtitle: Text("Par ${data[index]['restaurant']['name']}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Item(data[index]['id'])),
                    );
                  },
                ),
              );
            },
          ),
        ),

      ],
    );
  }
}