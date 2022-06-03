part of 'tvshows_grid_bloc.dart';

abstract class TvshowsGridState extends Equatable {
  const TvshowsGridState();

  @override
  List<Object?> get props => [];
}

class TvshowsGridInitial extends TvshowsGridState {}

class TvshowsGridTest extends TvshowsGridState {}

class TvshowsGridError extends TvshowsGridState {
  final AppErrorType errorType;

  const TvshowsGridError(this.errorType);
}

class TvshowsGridLoaded extends TvshowsGridState {
  final List<TvShow> tvShows;
  final bool hasReachLimit;

  const TvshowsGridLoaded({
    required this.tvShows,
    required this.hasReachLimit,
  });

  TvshowsGridLoaded copyWith(
      {required List<TvShow> tvShow, required bool hasReachLimit}) {
    return TvshowsGridLoaded(tvShows: tvShow, hasReachLimit: hasReachLimit);
  }

  @override
  List<Object?> get props => [
        tvShows,
      ];
}
