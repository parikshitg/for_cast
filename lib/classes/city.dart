class City{
  final String name;
  final double temp;
  final String weather;
  final int timezone;
  final String country;

  City({
    this.name,
    this.temp,
    this.weather,
    this.timezone,
    this.country,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name:json['name'],
      temp: json['main']['temp'],
      weather: json['weather'][0]['main'],
      timezone: json['timezone'],
      country: json['sys']['country'],
    );
  }
}