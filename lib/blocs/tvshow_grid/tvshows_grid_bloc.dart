import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seriestv_jobcity/blocs/loading/loading_cubit.dart';
import 'package:seriestv_jobcity/common/enums/apperror_type.dart';
import 'package:seriestv_jobcity/data/models/params/tvshow_params.dart';
import 'package:seriestv_jobcity/data/models/tvshow_model.dart';
import 'package:seriestv_jobcity/data/usecases/get_tvshows.dart';

part 'tvshows_grid_event.dart';
part 'tvshows_grid_state.dart';

const _tvShowLimit = 250;
int currentPage = 0;

class TvShowGridBloc extends Bloc<TvshowsGridEvent, TvshowsGridState> {
  final GetTvShows getTvShows;
  final LoadingCubit loadingCubit;

  TvShowGridBloc({
    required this.getTvShows,
    required this.loadingCubit,
  }) : super(TvshowsGridInitial()) {
    on<TvShowsLoadEvent>((event, emit) async {
      loadingCubit.show();

      final tvshowEither = await getTvShows(const TvShowParams(0));
      tvshowEither.fold(
        (error) => emit(TvshowsGridError(error.appErrorType)),
        (tvshows) =>
            emit(TvshowsGridLoaded(tvShows: tvshows, hasReachLimit: false)),
      );

      loadingCubit.hide();
    });

    on<TvShowGridLoadPageEvent>((event, emit) async {
      var oldTvCount = 0;
      if (state is TvshowsGridLoaded) {
        oldTvCount = (state as TvshowsGridLoaded).tvShows.length;
      }

      final pagenotFull = (oldTvCount - _tvShowLimit * (currentPage + 1)) <= 50
          ? _tvShowLimit * (currentPage + 1)
          : oldTvCount;
      final pageToRequest = pagenotFull ~/ _tvShowLimit;
      final requestMoreData = pagenotFull % _tvShowLimit == 0;

      // Avoid mutiple api calls if data not loaded yet
      if (!requestMoreData && !(pageToRequest > currentPage)) {
        return;
      }

      currentPage = pageToRequest;

      List<TvShow> olvTv = state is TvshowsGridLoaded
          ? (state as TvshowsGridLoaded).tvShows
          : [];

      final tvshowEither = await getTvShows(TvShowParams(currentPage));
      tvshowEither.fold((error) => emit(TvshowsGridError(error.appErrorType)),
          (tvshows) {
        tvshows.isEmpty
            ? emit(TvshowsGridLoaded(tvShows: olvTv, hasReachLimit: true))
            : emit(TvshowsGridLoaded(
                tvShows: olvTv + tvshows, hasReachLimit: false));
      });
    });
  }
}
