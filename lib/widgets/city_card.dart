import 'package:flutter/material.dart';

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