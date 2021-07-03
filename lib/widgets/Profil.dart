import 'dart:convert';

import 'package:client/API/Host.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Profil extends StatefulWidget {

  @override
  _ProfilState createState() {
    return _ProfilState();
  }
}

class _ProfilState extends State<Profil> {

  dynamic data;

  Duration get loginTime => Duration(milliseconds: 100);
  late int userId;

  @override
  void initState() {
    super.initState();
    getSharedUserId();
    Future.delayed(loginTime).then((_) {
      _getProfil();
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

  void _getProfil() {
    var url = Uri.parse("http://${Host.url}:8080/user?id=$userId");
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
        SizedBox(height: 35,),
        Text(
            "Your Profil",
            style: Theme.of(context).textTheme.headline4
        ),
        SizedBox(height: 40,),
        Card(
          child: ListTile(
            title: Text('prenom : ' + (data != null?data['firstname'] : "")),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('nom : ' +  (data != null?data['lastname'] : "")),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('email : ' + (data != null?data['email'] : "")),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('ville : ' + (data != null?data['ville'] : "")),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('adresse : ' + (data != null?data['adresse'] : "")),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('telephone : ' + (data != null?data['phone'] : "")),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('cin : ' + (data != null?data['cin'] : "")),
          ),
        ),
        Card(
          child: ListTile(
            title: Text(
                'date naissance : ' +
                (data != null?DateFormat('yyyy-MM-dd').format(DateTime.parse(data['dateNaissance'])) : "")
            ),
          ),
        ),
      ],
    );
  }
}
