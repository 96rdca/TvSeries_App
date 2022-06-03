part of 'searchtvshow_bloc.dart';

abstract class SearchTvShowState extends Equatable {
  const SearchTvShowState();

  @override
  List<Object> get props => [];
}

class SearchtvshowInitial extends SearchTvShowState {}

class SearchTvShowLoaded extends SearchTvShowState {
  final List<TvShow> tvShows;

  const SearchTvShowLoaded(this.tvShows);

  @override
  List<Object> get props => [tvShows];
}

class SearchTvShowLoading extends SearchTvShowState {}

class SearchTvShowError extends SearchTvShowState {}
