part of 'searchtvshow_bloc.dart';

abstract class SearchTvShowEvent extends Equatable {
  const SearchTvShowEvent();

  @override
  List<Object> get props => [];
}

class SearchTermChangedEvent extends SearchTvShowEvent {
  final String searchTerm;

  const SearchTermChangedEvent(this.searchTerm);

  @override
  List<Object> get props => [searchTerm];
}
