import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_machine/core/get_it_stup.dart';
import 'package:weather_machine/domain/weather_model/weather_model.dart';
import 'package:weather_machine/core/routing/auto_route.gr.dart';
import 'package:weather_machine/infrastructure/auth_service.dart';
import 'package:weather_machine/infrastructure/user_hive_sevices.dart';
import '../../application/weather_bloc/weather_bloc.dart';
import '../../application/weather_bloc/weather_state.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        child:
            BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
          if (state is WeatherLoading) {
            return Center(
                child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(30)),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    strokeWidth: 10,
                  ),
                  Text(
                    "Loading",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                ],
              ),
            ));
          } else if (state is WeatherError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else if (state is WeatherLoaded || state is WeatherLocalLoaded) {
            WeatherModel data = state is WeatherLoaded
                ? (state).model
                : (state as WeatherLocalLoaded).model;
            return SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      padding: EdgeInsets.only(top: size.height * .07),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(size.height * 0.03),
                            bottomRight: Radius.circular(size.height * 0.03)),
                        gradient: const LinearGradient(
                            colors: [Colors.purple, Colors.blue],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            stops: [0.2, 0.8]),
                      ),
                      child: Column(
                        children: [
                          if (state is WeatherLocalLoaded)
                            Text(
                              "data From Local",
                              style: GoogleFonts.mavenPro(
                                  color: Colors.white,
                                  fontSize: size.height * .040),
                            ),
                          Text(
                            data.cityName,
                            style: GoogleFonts.mavenPro(
                                color: Colors.white,
                                fontSize: size.height * .040),
                          ),
                          SizedBox(
                            height: size.height * .01,
                          ),
                          Text(
                            "${DateTime.now()}",
                            style: GoogleFonts.mavenPro(
                                color: Colors.white,
                                fontSize: size.height * .020),
                          ),
                          const Icon(
                            Icons.cloud,
                            color: Colors.white,
                          ),
                          Text(
                            data.condition,
                            style: GoogleFonts.hubballi(
                                color: Colors.white,
                                fontSize: size.height * .045,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '${data.temp}',
                            style: GoogleFonts.hubballi(
                                color: Colors.white,
                                fontSize: size.height * .060,
                                fontWeight: FontWeight.w800),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      '${data.wind}',
                                      style: GoogleFonts.hubballi(
                                          color: Colors.white,
                                          fontSize: size.height * .023,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Wind',
                                      style: GoogleFonts.mavenPro(
                                          color: Colors.white,
                                          fontSize: size.height * .020,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Column(
                                children: [
                                  Text(
                                    '${data.humidity}',
                                    style: GoogleFonts.hubballi(
                                        color: Colors.white,
                                        fontSize: size.height * .023,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Humidity',
                                    style: GoogleFonts.mavenPro(
                                        color: Colors.white,
                                        fontSize: size.height * .020,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                              Expanded(
                                  child: Column(
                                children: [
                                  Text(
                                    data.windDir,
                                    style: GoogleFonts.hubballi(
                                        color: Colors.white,
                                        fontSize: size.height * .023,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Wind Direction',
                                    style: GoogleFonts.mavenPro(
                                        color: Colors.white,
                                        fontSize: size.height * .018,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ))
                            ],
                          ),
                          SizedBox(
                            height: size.height * 0.02,
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.circle,
                                color: Colors.white,
                              ),
                              Icon(
                                Icons.circle,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                              Icon(
                                Icons.circle,
                                color: Colors.white,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Gust',
                            style: GoogleFonts.mavenPro(
                                color: Colors.white,
                                fontSize: size.height * .020),
                          ),
                          SizedBox(
                            height: size.height * .007,
                          ),
                          Text(
                            '${data.gust} kp/h',
                            style: GoogleFonts.mavenPro(
                                fontSize: size.height * .026,
                                color: Colors.white.withOpacity(0.5)),
                          ),
                          SizedBox(
                            height: size.height * .023,
                          ),
                          Text(
                            'Pressure',
                            style: GoogleFonts.mavenPro(
                                color: Colors.white,
                                fontSize: size.height * .020),
                          ),
                          SizedBox(
                            height: size.height * .007,
                          ),
                          Text(
                            '${data.pressure} hpa',
                            style: GoogleFonts.mavenPro(
                                fontSize: size.height * .026,
                                color: Colors.white.withOpacity(0.5)),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'UV',
                            style: GoogleFonts.mavenPro(
                                color: Colors.white,
                                fontSize: size.height * .020),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${data.uv}',
                            style: GoogleFonts.mavenPro(
                                fontSize: size.height * .026,
                                color: Colors.white.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Precipitation',
                            style: GoogleFonts.mavenPro(
                                color: Colors.white,
                                fontSize: size.height * .020),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${data.precipe} mm',
                            style: GoogleFonts.mavenPro(
                                fontSize: size.height * .026,
                                color: Colors.white.withOpacity(0.5)),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Wind',
                            style: GoogleFonts.mavenPro(
                                color: Colors.white,
                                fontSize: size.height * .020),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            '${data.wind}Km/h',
                            style: GoogleFonts.mavenPro(
                                fontSize: size.height * .026,
                                color: Colors.white.withOpacity(0.5)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Last Update',
                            style: GoogleFonts.mavenPro(
                                color: Colors.white,
                                fontSize: size.height * .020),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            data.lastUpdate,
                            style: GoogleFonts.mavenPro(
                                fontSize: size.height * .020,
                                color: const Color.fromARGB(255, 12, 124, 36)
                                    .withOpacity(0.5)),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.circle,
                        color: Colors.white,
                      ),
                      Icon(
                        Icons.circle,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      Icon(
                        Icons.circle,
                        color: Colors.white,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.router.push(const ListRoute());
                        },
                        child: Column(
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              child: Icon(Icons.list),
                            ),
                            Text(
                              "List",
                              style: GoogleFonts.mavenPro(
                                  fontSize: size.height * .020,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          locator<UserHiveServices>().removeData();
                          locator<AuthService>().logoutUser();
                          context.router.push(const LoginORregister());
                        },
                        child: Column(
                          children: [
                            const CircleAvatar(
                              radius: 30,
                              child: Icon(Icons.logout),
                            ),
                            Text(
                              "Logout",
                              style: GoogleFonts.mavenPro(
                                  fontSize: size.height * .020,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          } else {
            return const Text("bloc error");
          }
        }),
      ),
    );
  }
}
