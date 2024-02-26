import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_machine/application/weather_bloc/weather_event.dart';
import 'package:weather_machine/infrastructure/weather_services.dart';
import '../../domain/weather_model/weather_model.dart';
import '../../infrastructure/weather_hive_service.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherDataServices weatherInfo;
  final WeatherHiveservices weatherHiveservices;
  WeatherBloc(this.weatherInfo, this.weatherHiveservices)
      : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        WeatherModel model = await weatherInfo.getData(event.locationModel);
        weatherHiveservices.addWeatherData(model);
        emit(WeatherLoaded(model));
      } catch (e) {
        WeatherModel? model = await weatherHiveservices.getWeatherData();
        if (model == null) {
          emit(WeatherError(e.toString()));
        } else {
          emit(WeatherLocalLoaded(model));
        }
      }
    });
  }
}
