part of 'user_hive_bloc_bloc.dart';

abstract class UserHiveBlocState {}

class UserHiveBlocInitial extends UserHiveBlocState {}

class UserDataLoading extends UserHiveBlocState {}

class UserDataLoaded extends UserHiveBlocState {}

class UserDataNull extends UserHiveBlocState {}
