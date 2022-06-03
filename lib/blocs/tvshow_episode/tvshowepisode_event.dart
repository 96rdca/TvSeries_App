part of 'tvshowepisode_bloc.dart';

abstract class TvshowepisodeEvent extends Equatable {
  const TvshowepisodeEvent();

  @override
  List<Object> get props => [];
}

class TvShowEpisodeLoadEvent extends TvshowepisodeEvent {
  final int showId;

  const TvShowEpisodeLoadEvent({required this.showId});

  @override
  List<Object> get props => [showId];
}
