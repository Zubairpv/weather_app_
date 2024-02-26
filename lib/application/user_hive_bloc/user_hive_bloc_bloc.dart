import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_machine/infrastructure/user_hive_sevices.dart';

import '../../domain/user_model/user_model.dart';

part 'user_hive_bloc_event.dart';
part 'user_hive_bloc_state.dart';

class UserHiveBloc extends Bloc<UserHiveBlocEvent, UserHiveBlocState> {
  final UserHiveServices userHiveServices;
  UserHiveBloc(this.userHiveServices) : super(UserHiveBlocInitial()) {
    on<FetchUser>((event, emit) async{
      emit(UserDataLoading());
      UserModel? userModel =await userHiveServices.getUserData();
      if (userModel == null) {
        emit(UserDataNull());
      } else {
        emit(UserDataLoaded());
      }
    });
  }
}
