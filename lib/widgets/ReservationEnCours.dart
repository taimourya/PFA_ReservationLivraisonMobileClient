


import 'dart:convert';

import 'package:client/API/Host.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReservationEnCours extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StateReservationEnCours();
  }

}

class _StateReservationEnCours extends State<ReservationEnCours>{

  dynamic data;

  Duration get loginTime => Duration(milliseconds: 100);
  late int userId;

  @override
  void initState() {
    super.initState();
    getSharedUserId();
    Future.delayed(loginTime).then((_) {
      _getReservationEnCours();
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

  void _getReservationEnCours() {
    var url = Uri.parse("http://${Host.url}:8080/client/reservationEnCours?client_id=$userId");
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
            "Reservation en cours",
            style: Theme.of(context).textTheme.headline4
        ),
        SizedBox(height: 40,),

        data!=null?(data.length == 0? Text("Aucun element trouver") : Text("")) : Text(""),

        Expanded(
          child: ListView.builder(

            itemCount: data!=null? data.length : 0,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Text("Reservation"),
                  trailing: Text(data[index]['restaurant']['name']),
                  title: Text("${DateFormat('yyyy-MM-dd :: HH:mm:ss').format(DateTime.parse(data[index]['date']))}"),
                  subtitle: Text(
                      "${DateFormat('yyyy-MM-dd :: HH:mm:ss').format(DateTime.parse(data[index]['dateReservation']))}"
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

}