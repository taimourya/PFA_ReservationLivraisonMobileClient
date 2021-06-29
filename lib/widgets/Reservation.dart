import 'package:client/widgets/DrawerMenu.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';

class Reservation extends StatefulWidget {

  @override
  _ReservationState createState() {
    return _ReservationState();
  }
}

class _ReservationState extends State<Reservation> {



  String dateReservation = DateTime.now().toString();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
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

          Text("Total elements : ${'105'} DH", style: Theme.of(context).textTheme.headline5,),
          SizedBox(height: 20,),
          Text("Reservation : ${'5'} DH", style: Theme.of(context).textTheme.headline5,),
          SizedBox(height: 20,),
          Text("Total : ${'110'} DH", style: Theme.of(context).textTheme.headline5,),

          SizedBox(height: 50,),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Reservation le ${dateReservation}')));
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