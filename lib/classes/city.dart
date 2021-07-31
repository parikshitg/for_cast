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