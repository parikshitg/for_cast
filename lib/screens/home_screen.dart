import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const cities = [
  'London', 
  'Delhi', 
  'Calcutta', 
  // 'Los-Angeles', 
  'Mumbai', 
  'Sydney', 
  'Tokyo', 
  'Rio',
  'Qatar', 
  'Berlin',
];

const apiKey = 'd6b07e0f9e70d25e32a75b4db5b5aac7';
const unit= 'metric';

class City{
  final String name;
  final double temp;

  City({
    this.name,
    this.temp,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name:json['name'],
      temp: json['main']['temp'],
    );
  }
}

List<City> cityList = [];

Future<List<City>> fetchCity() async {
  for (var i = 0; i < cities.length; i++){
    var url = 'https://api.openweathermap.org/data/2.5/weather?q=${cities[i]}&appid=$apiKey&units=$unit';
    
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw Exception('Failed to load album');
    }
    
    cityList.add(City.fromJson(jsonDecode(response.body)));
  }

  return cityList;
}

class HomeScreen extends StatefulWidget {
  
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<City>> futureCity;

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
              iconSize: 24.0,
            ),
          ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<List<City>>(
            future: futureCity,
            builder:(context, citys){
              if (!citys.hasData) {
                  return Center(child: CircularProgressIndicator());
              }
              return Column(
                children: [
                  Container(
                    child: ListView.builder(
                      itemCount: cityList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, i){
                        return CityCard(cityList[i].name, cityList[i].temp);
                      },
                    )
                  )
                ],
              );
            }
          )
        )
      )
    );
  }
}

class CityCard extends StatelessWidget {
  final String cityName;
  final double temp;

  CityCard(this.cityName, this.temp);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
        side: BorderSide(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
        children: [
          Row(children: [ Text('06:00 PM', style: TextStyle(color: Colors.grey[600], fontSize:16.0))]),
          SizedBox(height:8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ 
            Text(cityName, style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.w400)),
            Text('$temp°C', style: TextStyle(fontSize: 24.0),),
          ]),
        ],
      ),
    ),
    );
  }
}
