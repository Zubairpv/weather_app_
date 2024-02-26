import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_machine/application/weather_bloc/weather_bloc.dart';
import 'package:weather_machine/application/weather_bloc/weather_event.dart';
import 'package:weather_machine/domain/list_of_location.dart';

import '../../application/search_bloc/search_bloc.dart';

@RoutePage()
class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Container(
          height: size.height,
          width: size.width - 30,
          margin: const EdgeInsets.only(top: 15),
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.purple, Colors.blue],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.2, 0.8]),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20), topLeft: Radius.circular(20))),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  context
                      .read<SearchBloc>()
                      .add(SearchingEvent(keyWord: value));
                },
                decoration: InputDecoration(
                    hintText: 'Search',
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    filled: true),
              ),
              const SizedBox(
                height: 5,
              ),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial || state is Searching) {
                    List<LocationModel> list = state is SearchInitial
                        ? (state).locationList
                        : (state as Searching).locationList;
                    return Expanded(
                        child: ListView.separated(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            context
                                .read<WeatherBloc>()
                                .add(FetchWeather(locationModel: list[index]));
                            context.router.pop();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            width: size.width,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "place:${list[index].place}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: size.width / 40),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "lat:${list[index].latitude}    lon:${list[index].latitude}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: size.width / 40),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 5,
                      ),
                    ));
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
