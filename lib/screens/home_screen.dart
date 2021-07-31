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
        centerTitle: false,
        title: Text('ForCast', style: TextStyle(fontSize: 24, fontFamily: 'Ethnocentric',),),
        actions: [
            IconButton(
              onPressed: () {
                print("add button pressed");

                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => search_screen(),
                //   ),
                // );
              },
              icon: Icon(Icons.add),
              iconSize: 40,
            ),
          ],
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
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0), // if you need this
                        side: BorderSide(
                          color: Colors.grey.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                        children: [
                          Row(children: [ Text('06:00 PM', style: TextStyle(color: Colors.grey[600], fontSize:16))]),
                          SizedBox(height:8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [ 
                            Text(cities[i], style: TextStyle(fontSize:24.0,fontWeight: FontWeight.w400)),
                            Text('32°C', style: TextStyle(fontSize: 24.0),),
                          ]),
                        ],
                      ),
                    ),
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