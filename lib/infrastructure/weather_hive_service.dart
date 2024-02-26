import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_machine/domain/weather_model/weather_model.dart';

abstract class WeatherHiveservices {
  Future init();
  Future addWeatherData(WeatherModel model);
  Future<WeatherModel?> getWeatherData();
}

class WeatherHiveservicesImpl implements WeatherHiveservices {
  @override
  Future init() async {
    Hive.registerAdapter(WeatherModelAdapter());
    debugPrint('called');
  }

  @override
  Future addWeatherData(WeatherModel model) async {
    await Hive.openBox<WeatherModel>('weather');
    Box<WeatherModel> catBox = Hive.box<WeatherModel>('weather');
    await catBox.put("weatherData", model);
  }

  @override
  Future<WeatherModel?> getWeatherData() async {
    await Hive.openBox<WeatherModel>('weather');
    Box<WeatherModel> catBox = Hive.box<WeatherModel>('weather');
    WeatherModel? model = catBox.get("weatherData");
    return model;
  }
}
