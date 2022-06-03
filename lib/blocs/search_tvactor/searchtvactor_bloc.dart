import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seriestv_jobcity/data/models/tv_actor_model.dart';
import 'package:seriestv_jobcity/data/models/params/tv_search_params.dart';
import 'package:seriestv_jobcity/data/usecases/search_tvactor.dart';

part 'searchtvactor_event.dart';
part 'searchtvactor_state.dart';

class SearchTvActorBloc extends Bloc<SearchTvActorEvent, SearchTvActorState> {
  final SearchTvActor searchTvActor;

  SearchTvActorBloc({required this.searchTvActor})
      : super(SearchTvActorInitial()) {
    on<SearchTermChangedEvent>((event, emit) async {
      emit(SearchTvActorLoading());

      final searchEither =
          await searchTvActor(TvSearchParams(searchTerm: event.searchTerm));

      searchEither.fold(
        (error) => emit(SearchTvActorError()),
        (tvActors) => emit(SearchTvActorLoaded(tvActors)),
      );
    });
  }
}
