import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_machine/application/search_bloc/search_bloc.dart';
import 'package:weather_machine/application/user_hive_bloc/user_hive_bloc_bloc.dart';
import 'package:weather_machine/infrastructure/user_hive_sevices.dart';
import 'package:weather_machine/infrastructure/weather_services.dart';
import 'package:weather_machine/core/routing/auto_route.dart';

import 'application/weather_bloc/weather_bloc.dart';
import 'application/weather_bloc/weather_event.dart';
import 'core/get_it_stup.dart';
import 'infrastructure/weather_hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

  setUp();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<WeatherBloc>(
        create: (BuildContext context) => WeatherBloc(
            locator<WeatherDataServices>(), locator<WeatherHiveservices>())
          ..add(FetchWeather(locationModel: null)),
      ),
      BlocProvider<UserHiveBloc>(
        create: (BuildContext context) =>
            (UserHiveBloc(locator<UserHiveServices>()))..add(FetchUser()),
      ),
      BlocProvider<SearchBloc>(
        create: (BuildContext context) => (SearchBloc())..add(InitEvent()),
      ),
    ],
    child: const MyApp(),
  ));
}

AppRouter appRouter = AppRouter();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserHiveBloc, UserHiveBlocState>(
      builder: (context, state) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: const Color(0xFFee7b64),
              scaffoldBackgroundColor: Colors.indigo.shade400),
          routerConfig: appRouter.config(),
        );
      },
    );
  }
}
