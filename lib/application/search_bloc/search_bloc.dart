import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_machine/domain/list_of_location.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial(locationList: locationList)) {
    on<SearchingEvent>((event, emit) {
      List<LocationModel> list = seachFromList(event.keyWord);
      
      emit(Searching(locationList: list));
    });
    on<InitEvent>((event, emit) {
      emit(SearchInitial(locationList: locationList));
    });
  }
  List<LocationModel> seachFromList(String query) {
    return locationList
        .where((location) =>
            location.place.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
