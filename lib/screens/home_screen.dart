import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/city_card.dart';
import '../classes/city.dart';
import '../config/data.dart';
import '../config/config.dart';
import './detail_screen.dart';
import '../utils/icon.dart';

List<City> cityList = [];

Future<List<City>> fetchCity() async {
  if (apiKey == ''){
    print('please use valid token!!');
    return cityList;
  }

  for (var i = 0; i < defaultCities.length; i++){
    var url = '$baseUrl?q=${defaultCities[i]}&appid=$apiKey&units=$unit';
    
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(),
                  ),
                );
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
                        return CityCard(
                          cityList[i].name, 
                          cityList[i].temp, 
                          getWeatherIcon(cityList[i].weather.toLowerCase()),
                          cityList[i].timezone,
                          cityList[i].country,
                        );
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
