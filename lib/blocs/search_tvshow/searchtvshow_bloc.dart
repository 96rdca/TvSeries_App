import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seriestv_jobcity/data/models/tvshow_model.dart';
import 'package:seriestv_jobcity/data/models/params/tv_search_params.dart';
import 'package:seriestv_jobcity/data/usecases/search_tvshow.dart';

part 'searchtvshow_event.dart';
part 'searchtvshow_state.dart';

class SearchTvShowBloc extends Bloc<SearchTvShowEvent, SearchTvShowState> {
  final SearchTvShow searchTvShow;

  SearchTvShowBloc({required this.searchTvShow})
      : super(SearchtvshowInitial()) {
    on<SearchTermChangedEvent>((event, emit) async {
      emit(SearchTvShowLoading());

      final searchEither =
          await searchTvShow(TvSearchParams(searchTerm: event.searchTerm));
      searchEither.fold(
        (error) => emit(SearchTvShowError()),
        (tvShows) => emit(SearchTvShowLoaded(tvShows)),
      );
    });
  }
}
