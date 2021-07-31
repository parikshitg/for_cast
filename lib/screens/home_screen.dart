import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const cities = [
  'Mumbai', 
  'Delhi', 
  'Calcutta', 
  'Los-Angeles', 
  'London', 
  'Sydney', 
  'Tokyo', 
  'Rio', 
  'Qatar', 
  'Berlin'
];

class City{
  final String base;
  final int visibility;
  final double temp;

  City({
    this.base,
    this.visibility,
    this.temp,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      base: json['base'],
      visibility: json['visibility'],
      temp: json['main']['temp'],
    );
  }
}

Future<City> fetchCity() async {
  var url = 'https://api.openweathermap.org/data/2.5/weather?q=London&appid=d6b07e0f9e70d25e32a75b4db5b5aac7&units=metric';
  
  final response = await http.get(Uri.parse(url));
  if (response.statusCode != 200) {
    throw Exception('Failed to load album');
  }

  return City.fromJson(jsonDecode(response.body));
}

class HomeScreen extends StatefulWidget {
  
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<City> futureCity;

  @override
  void initState() {
    super.initState();
    futureCity = fetchCity();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ForCast', style: TextStyle(fontSize: 28, fontFamily: 'Ethnocentric',),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: ListView.builder(
                  itemCount: cities.length,
                  shrinkWrap: true,
                  itemBuilder: (context, i){
                    return Card(

                      child: FutureBuilder<City>(
                        future: futureCity,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListTile(
                              title: Text(cities[i].toString()),
                              subtitle: Text(snapshot.data.temp.toString())
                            );
                          } else if (snapshot.hasError) {
                            print('${snapshot.error}');
                            // return Text('${snapshot.error}');
                          }

                          // By default, show a loading spinner.
                          return const CircularProgressIndicator();
                        },)
                    );
                  },
                )
              )
            ],
          ),
        )
      )
    );
  }
}