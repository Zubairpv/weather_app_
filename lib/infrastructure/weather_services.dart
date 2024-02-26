import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_machine/domain/list_of_location.dart';
import 'package:weather_machine/domain/weather_model/weather_model.dart';
import 'package:weather_machine/infrastructure/location_services.dart';

import '../core/get_it_stup.dart';

abstract class WeatherDataServices {
  Future<WeatherModel> getData(LocationModel? locationModel);
}

class WeatherDataImpl implements WeatherDataServices {
  @override
  Future<WeatherModel> getData(LocationModel? locationModel) async {
    final dio = Dio();
    LocationServices locationService = locator<LocationServices>();

    Position position = await locationService.getPosition();

    debugPrint(position.latitude.toString());
    String uri;
    if (locationModel == null) {
      uri =
          'http://api.weatherapi.com/v1/current.json?key=fbe3727be200458abfe94212231704&q=${position.latitude},${position.longitude}&aqi=no';
    } else {
      uri =
          'http://api.weatherapi.com/v1/current.json?key=fbe3727be200458abfe94212231704&q=${locationModel.latitude},${locationModel.longitude}&aqi=no';
    }
    final response = await dio.get(uri);

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(response.data);
    } else {
      throw Exception('Failed to get data');
    }
  }
}
