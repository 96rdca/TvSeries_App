part of 'tvshowdetail_bloc.dart';

abstract class TvShowDetailState extends Equatable {
  const TvShowDetailState();

  @override
  List<Object> get props => [];
}

class TvShowDetailInitial extends TvShowDetailState {}

class TvShowDetailLoading extends TvShowDetailState {}

class TvShowDetailError extends TvShowDetailState {}

class TvShowDetailLoaded extends TvShowDetailState {
  final TvShow tvShow;

  const TvShowDetailLoaded(this.tvShow);

  @override
  List<Object> get props => [tvShow];
}
