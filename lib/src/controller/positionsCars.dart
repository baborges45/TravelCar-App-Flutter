import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:rotas_cars/src/model/Position.dart';
import 'package:rotas_cars/src/controller/Travel.dart';
import 'package:rotas_cars/src/model/car.dart';
import 'dart:convert';
//import 'mainscreen.dart';

class PositionCars extends StatefulWidget {
  final Car user;

  PositionCars(this.user);

  @override
  _PositionCarsState createState() => _PositionCarsState();
}

class _PositionCarsState extends State<PositionCars> {
  var travels = [];

  Future<List<Travel>> _fetchTravels() async {
    var data = await http.get(
        "http://www15.itrack.com.br/recruitmentpositionapi/vehicles/${widget.user.id}/positions");

    var jsonData = json.decode(data.body);

    List<Position> positions = [];

    for (var u in jsonData) {
      Position position = Position(
          u["id"],
          u["vehicleId"],
          u["datetime"],
          u["latitude"],
          u["longitude"],
          u["address"],
          u["ignition"],
          u["hodometro"]);

      positions.add(position);
    }

    var positionInitial;
    List<Travel> travels = [];

    for (var i = 0; i < positions.length; i++) {
      if (positionInitial == null && positions[i].ignition == true) {
        positionInitial = positions[i];
      } else if (positionInitial != null && positions[i].ignition == false) {
        travels.add(new Travel(positionInitial, positions[i]));
        positionInitial = null;
      }
    }
    if (positionInitial != null) {
      travels.add(new Travel(positionInitial, null));
      positionInitial = null;
    }
    return travels;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user.name),
      ),
      body: Container(
        child: FutureBuilder(
          future: _fetchTravels(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (snapshot.data == null) {
              return Container(child: Center(child: Text("Loading...")));
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int id) {
                  return Card(
                    child: ListTile(
                      title: Text(snapshot.data[id].toString()),
                      // subtitle: Text(snapshot.data[id].toString()),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
