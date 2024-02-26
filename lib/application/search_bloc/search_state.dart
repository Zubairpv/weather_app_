part of 'search_bloc.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {
  final List<LocationModel>locationList;

  SearchInitial({required this.locationList});
}

class Searching extends SearchState { final List<LocationModel>locationList;

  Searching({required this.locationList});}
