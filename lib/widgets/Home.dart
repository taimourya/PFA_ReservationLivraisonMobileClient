

import 'dart:async';

import 'package:client/widgets/Chat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/DrawerMenu.dart';
import 'package:http/http.dart' as http;
import 'package:client/API/Host.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home>{

  Timer? timerConversation;

  late int userId;


  @override
  void initState() {
    super.initState();
    getSharedUserId();
    timerConversation = Timer.periodic(Duration(seconds: 1), (Timer t) => checkConversation());
  }
  @override
  void dispose() {
    timerConversation?.cancel();
    super.dispose();
  }

  Future<void> getSharedUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getInt('user_id');
    print(id);
    setState(() {
      userId = id == null? 0 : id;
    });
  }

  void checkConversation() {
    var url = Uri.parse("${Host.url}/conversation/check?user_id=$userId");

    http.get(url).then((response) {
      //print(response.body);
      if(response.statusCode == 200) {
        setState(() {
          timerConversation?.cancel();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Chat()),
          );
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
        title: Text("Home"),
        backgroundColor: Colors.green,
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: Text("hello client"),
      ),
    );
  }
}