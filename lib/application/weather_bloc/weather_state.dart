
import 'package:weather_machine/domain/weather_model/weather_model.dart';

abstract class WeatherState {
  const WeatherState();
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherModel model;

  const WeatherLoaded(this.model);
}

class WeatherLocalLoaded extends WeatherState {
  final WeatherModel model;

  const WeatherLocalLoaded(this.model);
}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);
}
