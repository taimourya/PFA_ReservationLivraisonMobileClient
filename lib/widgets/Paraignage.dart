import 'package:flutter/material.dart';

class Paraignage extends StatefulWidget {
  @override
  _ParaignageState createState() {
    return _ParaignageState();
  }
}

class _ParaignageState extends State<Paraignage> {

  String codePromo = "";

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
            title: Text('Votre code promos : ' + " AAAABB15629"),
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

                },
              ),
            ],
          )
        ),
      ],
    );
  }
}