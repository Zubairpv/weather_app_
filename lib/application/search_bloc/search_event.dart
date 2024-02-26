part of 'search_bloc.dart';

abstract class SearchEvent {}

class InitEvent extends SearchEvent {}

class SearchingEvent extends SearchEvent {
  final String keyWord;

  SearchingEvent({required this.keyWord});

}
