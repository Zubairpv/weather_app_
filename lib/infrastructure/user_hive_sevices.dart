import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:weather_machine/domain/user_model/user_model.dart';
import 'package:weather_machine/presentation/pages/login_page_vars.dart';

abstract class UserHiveServices {
  Future init();
  Future addUserData();
  Future<UserModel?> getUserData();
  Future removeData();
}

class UserHiveServicesImpl implements UserHiveServices {
  @override
  Future init() async {
    Hive.registerAdapter(UserModelAdapter());
    debugPrint('called');
  }

  @override
  Future addUserData() async {
    await Hive.openBox<UserModel>('user');
    Box<UserModel> catBox = Hive.box<UserModel>('User');
    UserModel userModel = UserModel(email: AuthVars.email, loggedIn: true);
    await catBox.put("UserData", userModel);
  }

  @override
  Future<UserModel?> getUserData() async {
    await Hive.openBox<UserModel>('user');
    Box<UserModel> catBox = Hive.box<UserModel>('User');
    UserModel? model = catBox.get("UserData");
    return model;
  }

  @override
  Future removeData() async {
    await Hive.openBox<UserModel>('user');
    Box<UserModel> catBox = Hive.box<UserModel>('User');
    catBox.delete("UserData");
  }
}
