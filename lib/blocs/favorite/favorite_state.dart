part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteTvShowLoaded extends FavoriteState {
  final List<TvShow> tvShows;

  const FavoriteTvShowLoaded(this.tvShows);

  @override
  List<Object> get props => [tvShows];
}

class FavoriteTvShowError extends FavoriteState {}

class IsFavoriteTvShow extends FavoriteState {
  final bool isFavoriteMovie;

  const IsFavoriteTvShow(this.isFavoriteMovie);

  @override
  List<Object> get props => [isFavoriteMovie];
}
