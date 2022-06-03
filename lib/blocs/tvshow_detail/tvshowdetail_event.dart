part of 'tvshowdetail_bloc.dart';

abstract class TvShowDetailEvent extends Equatable {
  const TvShowDetailEvent();

  @override
  List<Object> get props => [];
}

class TvShowDetailLoadEvent extends TvShowDetailEvent {
  final TvShow tvShow;
  final bool isFromSaved;

  const TvShowDetailLoadEvent(this.tvShow, this.isFromSaved);

  @override
  List<Object> get props => [tvShow, isFromSaved];
}
