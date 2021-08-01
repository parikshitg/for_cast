class City{
  final String name;
  final double temp;
  final String weather;

  City({
    this.name,
    this.temp,
    this.weather,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name:json['name'],
      temp: json['main']['temp'],
      weather: json['weather'][0]['main'],
    );
  }
}