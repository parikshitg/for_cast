import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/city_card.dart';

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
