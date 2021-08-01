import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

Icon getWeatherIcon(weatherType){
  switch(weatherType){
    case 'haze':
      return Icon(WeatherIcons.day_haze, size: 16.0);
      break;
    case 'clear':
      return Icon(WeatherIcons.day_sunny, size: 16.0);
        break;
    case 'clouds':
      return Icon(WeatherIcons.cloudy, size: 16.0);
        break;
    case 'rain':
      return Icon(WeatherIcons.day_rain, size: 16.0);
        break;
    case 'mist':
      return Icon(WeatherIcons.cloudy_gusts, size: 16.0);
        break;
  }
  return Icon(WeatherIcons.day_sunny, size: 16.0);
}