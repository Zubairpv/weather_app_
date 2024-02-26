import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_machine/application/user_hive_bloc/user_hive_bloc_bloc.dart';
import 'package:weather_machine/core/routing/auto_route.gr.dart';

@RoutePage()
class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  UserHiveBloc? userHiveBloc;
  @override
  void initState() {
    super.initState();

    userHiveBloc = BlocProvider.of<UserHiveBloc>(context);

    Future.delayed(const Duration(seconds: 3), () {
      if (userHiveBloc != null) {
        debugPrint(userHiveBloc!.state.toString());

        if (userHiveBloc!.state is UserDataLoaded) {
          context.router.push(const HomeRoute());
        } else if (userHiveBloc!.state is UserDataNull) {
          context.router.push(const LoginORregister());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(30)),
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
          ),
        ));
  }
}
