part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class LoadFavoriteTvShowEvent extends FavoriteEvent {
  @override
  List<Object> get props => [];
}

class DeleteFavoriteTvShowEvent extends FavoriteEvent {
  final int tvShowId;

  const DeleteFavoriteTvShowEvent(this.tvShowId);

  @override
  List<Object> get props => [tvShowId];
}

class ToggleFavoriteTvShowEvent extends FavoriteEvent {
  final TvShow tvshow;
  final bool isFavorite;

  const ToggleFavoriteTvShowEvent(this.tvshow, this.isFavorite);

  @override
  List<Object> get props => [tvshow, isFavorite];
}

class CheckIfFavoriteTvShowEvent extends FavoriteEvent {
  final int tvShowId;

  const CheckIfFavoriteTvShowEvent(this.tvShowId);

  @override
  List<Object> get props => [tvShowId];
}

class SortFavoriteTvShowEvent extends FavoriteEvent {
  final bool isReversed;

  const SortFavoriteTvShowEvent(this.isReversed);

  @override
  List<Object> get props => [isReversed];
}
