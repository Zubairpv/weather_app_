// ignore_for_file: must_be_immutable

import 'package:auto_route/auto_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:weather_machine/infrastructure/auth_service.dart';
import 'package:weather_machine/infrastructure/user_hive_sevices.dart';
import 'package:weather_machine/presentation/pages/login_page_vars.dart';
import 'package:weather_machine/presentation/widgets/snack_bar.dart';
import 'package:weather_machine/core/routing/auto_route.gr.dart';

import '../../core/get_it_stup.dart';
import '../core/constants.dart';

@RoutePage()
class LoginORregister extends StatelessWidget {
  const LoginORregister({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 40),
          child: Form(
              key: AuthVars.loginformkey,
              child: Column(
                children: [
                  const Text(
                    'Weathereey!',
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Login now ',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: textinputdecoration.copyWith(
                        labelText: 'Email',
                        prefixIcon: Icon(
                          Icons.email,
                          color: Theme.of(context).primaryColor,
                        )),
                    onChanged: (value) {
                      AuthVars.email = value;
                    },
                    validator: (value) {
                      return RegExp(AuthVars.regX).hasMatch(value!)
                          ? null
                          : 'Enter valid Email';
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: textinputdecoration.copyWith(
                        labelText: 'Password',
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Theme.of(context).primaryColor,
                        )),
                    validator: (value) {
                      if (value!.length < 6) {
                        return 'password must be at least 6 characters';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {
                      AuthVars.password = value;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          if (AuthVars.loginformkey.currentState!.validate()) {
                            locator<AuthService>().loginuser().then((value) {
                              if (value == true) {
                                context.router.push(const HomeRoute());
                                locator<UserHiveServices>().addUserData();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    BasicWidgets.showsnackbar(
                                        context, Colors.red, value));
                              }
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            elevation: 0,
                            backgroundColor: Theme.of(context).primaryColor),
                        child: const Text(
                          'Sign in',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text.rich(TextSpan(
                      text: "don't have an account?",
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      children: [
                        TextSpan(
                            text: 'Register here',
                            style: const TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.router.push(const Register());
                              })
                      ]))
                ],
              )),
        ),
      ),
    );
  }

  logedin() async {}
}
