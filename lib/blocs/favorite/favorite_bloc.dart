import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seriestv_jobcity/common/extensions/iterable_extensions.dart';
import 'package:seriestv_jobcity/common/logger.dart';
import 'package:seriestv_jobcity/data/models/app_error.dart';
import 'package:seriestv_jobcity/data/models/params/no_params.dart';
import 'package:seriestv_jobcity/data/models/params/tvshow_params.dart';
import 'package:seriestv_jobcity/data/models/tvshow_model.dart';
import 'package:seriestv_jobcity/data/usecases/check_if_tvshow_favorite.dart';
import 'package:seriestv_jobcity/data/usecases/delete_favorite_tvshow.dart';
import 'package:seriestv_jobcity/data/usecases/get_favorites_tvshow.dart';
import 'package:seriestv_jobcity/data/usecases/save_tvshow.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final SaveTvShow saveTvShow;
  final DeleteFavoriteTvShow deleteFavoriteTvShow;
  final CheckIfFavoriteTvShow checkIfFavoriteTvShow;
  final GetFavoriteTvShows getFavoriteTvShows;
  final log = getLogger('FavoritebLOC');
  FavoriteBloc({
    required this.saveTvShow,
    required this.deleteFavoriteTvShow,
    required this.checkIfFavoriteTvShow,
    required this.getFavoriteTvShows,
  }) : super(FavoriteInitial()) {
    on<ToggleFavoriteTvShowEvent>((event, emit) async {
      if (event.isFavorite) {
        await deleteFavoriteTvShow(TvShowParams(event.tvshow.id!));
      } else {
        await saveTvShow(event.tvshow);
      }

      final response =
          await checkIfFavoriteTvShow(TvShowParams(event.tvshow.id!));

      response.fold(
        (l) => emit(FavoriteTvShowError()),
        (movies) => emit(IsFavoriteTvShow(movies)),
      );
    });
    on<LoadFavoriteTvShowEvent>((event, emit) async {
      await _getLoadFavoriteMovies(emit);
    });
    on<DeleteFavoriteTvShowEvent>((event, emit) async {
      await deleteFavoriteTvShow(TvShowParams(event.tvShowId));
      await _getLoadFavoriteMovies(emit);
    });
    on<CheckIfFavoriteTvShowEvent>((event, emit) async {
      final response =
          await checkIfFavoriteTvShow(TvShowParams(event.tvShowId));

      response.fold(
        (l) => emit(FavoriteTvShowError()),
        (r) => emit(IsFavoriteTvShow(r)),
      );
    });
    on<SortFavoriteTvShowEvent>((event, emit) async {
      if (state is FavoriteTvShowLoaded) {
        List<TvShow> sortedTV;

        if (event.isReversed) {
          sortedTV = (state as FavoriteTvShowLoaded)
              .tvShows
              .sortByDescending((e) => e.name!)
              .toList();
        } else {
          sortedTV = (state as FavoriteTvShowLoaded)
              .tvShows
              .sortedBy((e) => e.name!)
              .toList();
        }

        emit(FavoriteTvShowLoaded(sortedTV));
      }
    });
  }

  Future<void> _getLoadFavoriteMovies(Emitter<FavoriteState> emit) async {
    final Either<AppError, List<TvShow>> response =
        await getFavoriteTvShows(NoParams());

    response.fold(
      (l) => emit(FavoriteTvShowError()),
      (r) => emit(FavoriteTvShowLoaded(r)),
    );
  }
}
