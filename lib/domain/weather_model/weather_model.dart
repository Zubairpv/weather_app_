import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'weather_model.g.dart';

@HiveType(typeId: 0)
class WeatherModel extends HiveObject {
  @HiveField(0)
  final String cityName;

  @HiveField(1)
  final String icon;

  @HiveField(2)
  final String condition;

  @HiveField(3)
  final double temp;

  @HiveField(4)
  final double wind;

  @HiveField(5)
  final int humidity;

  @HiveField(6)
  final String windDir;

  @HiveField(7)
  final double gust;

  @HiveField(8)
  final double uv;

  @HiveField(9)
  final double pressure;

  @HiveField(10)
  final double precipe;

  @HiveField(11)
  final String lastUpdate;

  WeatherModel({
    required this.cityName,
    required this.icon,
    required this.condition,
    required this.temp,
    required this.wind,
    required this.humidity,
    required this.windDir,
    required this.gust,
    required this.uv,
    required this.pressure,
    required this.precipe,
    required this.lastUpdate,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    debugPrint(json.toString());
    return WeatherModel(
      cityName: json['location']['name'] ?? "Unknown",
      icon: json['current']['condition']['icon'] ?? "Unknown",
      condition: json['current']['condition']['text'] ?? "Unknown",
      temp: double.parse(json['current']['temp_c']?.toString() ?? "0.0"),
      wind: double.parse(json['current']['wind_kph']?.toString() ?? "0.0"),
      humidity: json['current']['humidity'] ?? 0,
      windDir: json['current']['wind_dir'] ?? "Unknown",
      pressure:
          double.parse(json['current']['pressure_mb']?.toString() ?? "0.0"),
      precipe: double.parse(json['current']['precip_mm']?.toString() ?? "0.0"),
      lastUpdate: json['current']['last_updated'] ?? "Unknown",
      gust: double.parse(json['current']['gust_kph']?.toString() ?? "0.0"),
      uv: double.parse(json['current']['uv']?.toString() ?? "0.0"),
    );
  }
}
