import 'dart:convert';

import 'package:client/API/Host.dart';
import 'package:client/widgets/DrawerMenu.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Reservation extends StatefulWidget {

  @override
  _ReservationState createState() {
    return _ReservationState();
  }
}

class _ReservationState extends State<Reservation> {



  String dateReservation = DateTime.now().toString();
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

  saveReservation() {
    http.post(
      Uri.parse('http://${Host.url}:8080/commande/reservation'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Object>{
        "client_id": userId,
        "dateReservation": DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(dateReservation))
      }),
    ).then((response) {
      if(response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Reservation effectuer')));
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
        title: Text("Reservation"),
        backgroundColor: Colors.green,
      ),
      drawer: DrawerMenu(),
      body: Column(
        children: <Widget>[
          SizedBox(height: 50,),
          DateTimePicker(
            type: DateTimePickerType.dateTimeSeparate,
            dateMask: 'd MMM, yyyy',
            initialValue: DateTime.now().toString(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            icon: Icon(Icons.event),
            dateLabelText: 'Date',
            timeLabelText: "Heurs",
            onChanged: (val) {
              setState(() {
                dateReservation = val;
              });
            },
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
                    saveReservation();
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