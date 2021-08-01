import 'package:flutter/material.dart';
import '../utils/time.dart';

class CityCard extends StatelessWidget {
  final String cityName;
  final double temp;
  final Icon weatherIcon;
  final int timezone;
  final String country;

  CityCard(this.cityName, this.temp, this.weatherIcon, this.timezone, this.country);

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ 
            Text('${getCityLocalTime(timezone)}', style: TextStyle(color: Colors.grey[600], fontSize:16.0)),
            weatherIcon,
          ]),
          SizedBox(height:8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [ 
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 0.0),
                    child:Text(cityName, style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.w400))
                  ),
                  Text('($country)', style: TextStyle(fontSize: 16.0, color: Colors.grey)),
                ]),
            Text('${temp.round()}°C', style: TextStyle(fontSize: 24.0),),
          ]),
        ],
      ),
    ),
    );
  }
}
