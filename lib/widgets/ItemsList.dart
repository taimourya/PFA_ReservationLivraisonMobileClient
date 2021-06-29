



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/Item.dart';


class ItemsList extends StatefulWidget {

  String title = "";

  ItemsList(this.title);

  @override
  State<StatefulWidget> createState() {
    return StatItemList();
  }
}

class StatItemList extends State<ItemsList> {

  String searchText = "";
  final _formKey = GlobalKey<FormState>();

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
        Text(
          widget.title,
          style: TextStyle(
              fontSize: 20,
              color: Colors.black54
          ),
        ),
        SizedBox(height: 40,),
        Expanded(
          child: ListView.builder(

            itemCount: 15,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Icon(CupertinoIcons.eye),
                  title: Text('Item ${index}'),
                  trailing: Text("${"35"} DH"),
                  subtitle: Text("Par ${'MCDO'}"),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Item(index)),
                    );
                  },
                ),
              );
            },
          ),
        )

      ],
    );
  }
}