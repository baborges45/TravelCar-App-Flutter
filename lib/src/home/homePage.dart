import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:rotas_cars/src/model/car.dart';
import 'dart:convert';
import 'package:rotas_cars/src/controller/positionsCars.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePage createState() => _HomePage();

  fetchCars() {}
}

class _HomePage extends State<HomePage> {
  Future<List<Car>> _fetchCars() async {
    var data = await http
        .get("http://www15.itrack.com.br/recruitmentpositionapi/vehicles");

    var jsonData = json.decode(data.body);

    List<Car> cars = [];

    for (var u in jsonData) {
      Car car =
          Car(u["id"], u["name"], u["description"], u["brand"], u["model"]);

      cars.add(car);
    }
    print(cars.length);
    return cars;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Container(
        child: FutureBuilder(
          future: _fetchCars(),
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
                      // leading: CircleAvatar(
                      //   backgroundImage: NetworkImage(snapshot.data[id].picture),
                      // ),
                      title: Text(snapshot.data[id].name),
                      subtitle: Text(snapshot.data[id].model),
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    PositionCars(snapshot.data[id])));
                      },
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
