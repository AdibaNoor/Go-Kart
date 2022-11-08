class Vehicle {
  String speed;
  String fuel;
  String temp;
  String loc;
  String id;
  DateTime dateTime;

  Vehicle(
      {required this.speed,
      required this.fuel,
      required this.temp,
      required this.loc,
      required this.id,
      required this.dateTime});

  static Vehicle fromJson(Map<String, dynamic> json) {
    return Vehicle(
        speed: json['speed'],
        fuel: json['fuel'],
        temp: json['temp'],
        loc: json['loc'],
        id: json['id'],
        dateTime: DateTime.parse(json['dateTime']));
  }
}
