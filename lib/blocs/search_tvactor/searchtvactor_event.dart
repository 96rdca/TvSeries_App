part of 'searchtvactor_bloc.dart';

abstract class SearchTvActorEvent extends Equatable {
  const SearchTvActorEvent();

  @override
  List<Object> get props => [];
}

class SearchTermChangedEvent extends SearchTvActorEvent {
  final String searchTerm;

  const SearchTermChangedEvent(this.searchTerm);

  @override
  List<Object> get props => [searchTerm];
}
