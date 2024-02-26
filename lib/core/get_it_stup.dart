import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_machine/core/firebase_options.dart';
import 'package:weather_machine/infrastructure/auth_service.dart';
import 'package:weather_machine/infrastructure/location_services.dart';
import 'package:weather_machine/infrastructure/user_hive_sevices.dart';
import 'package:weather_machine/infrastructure/weather_services.dart';
import '../infrastructure/weather_hive_service.dart';

GetIt locator = GetIt.instance;
setUp() {
  locator.registerLazySingleton<WeatherDataServices>(() => WeatherDataImpl());
  locator.registerLazySingleton<LocationServices>(() => LocationServiceImpl());
  locator.registerLazySingleton<AuthService>(() => AuthServiceImpl());
  locator.registerLazySingleton<UserHiveServices>(() => UserHiveServicesImpl());
  locator.registerLazySingleton<WeatherHiveservices>(
      () => WeatherHiveservicesImpl());
  WeatherHiveservices weatherHiveservices = locator<WeatherHiveservices>();
  try {
    weatherHiveservices.init();
    locator<UserHiveServices>().init();
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    debugPrint('Error during userService initialization: $e');
  }
}
