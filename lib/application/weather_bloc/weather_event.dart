import 'package:weather_machine/domain/list_of_location.dart';

abstract class WeatherEvent {
  const WeatherEvent();
}

class FetchWeather extends WeatherEvent {
  final LocationModel? locationModel;

  FetchWeather({required this.locationModel});
}
