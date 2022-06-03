part of 'tvshowepisode_bloc.dart';

abstract class TvshowepisodeState extends Equatable {
  const TvshowepisodeState();

  @override
  List<Object> get props => [];
}

class TvshowepisodeInitial extends TvshowepisodeState {}

class TvshowepisodeLoaded extends TvshowepisodeState {
  final List<TvShowSeason> tvSeasons;

  const TvshowepisodeLoaded(this.tvSeasons);

  @override
  List<Object> get props => [tvSeasons];
}

class TvshowepisodeError extends TvshowepisodeState {}
