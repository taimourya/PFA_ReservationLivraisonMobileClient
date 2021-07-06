import 'dart:convert';

import 'package:client/API/Host.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Paraignage extends StatefulWidget {
  @override
  _ParaignageState createState() {
    return _ParaignageState();
  }
}

class _ParaignageState extends State<Paraignage> {

  String codePromo = "";

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
    var url = Uri.parse("${Host.url}/user?id=$userId");
    http.get(url)
        .then((response) {
      print(response.body);
      setState(() {
        data = json.decode(response.body);
      });
    });
  }

  _useCodePromo() {
    http.post(
      Uri.parse('${Host.url}/client/use/codePromo'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Object>{
        "client_id": 1,
        "codePromo": this.codePromo
      }),
    ).then((response) {
      print(response.body);
      if(response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Code promo enregistrer !')));
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(height: 35,),
        Text(
            "Paraignage",
            style: Theme.of(context).textTheme.headline4
        ),
        SizedBox(height: 40,),
        Card(
          child: ListTile(
            trailing: IconButton(
              icon: Icon(Icons.share),
              onPressed: () {

              },
            ),
            title: Text('Votre code promos : ' + (data != null?data['codePromo'] : "")),
          ),
        ),

        SizedBox(height: 40,),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Entrer un code promos",
                    prefixIcon: Icon(Icons.verified_user_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vous devez saisire le code promos';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    this.setState(() {
                      this.codePromo = value;
                    });
                  },
                ),
              ),

              ElevatedButton(
                child: Text("Verifier"),
                onPressed: () {
                  _useCodePromo();
                },
              ),
            ],
          )
        ),
      ],
    );
  }
}