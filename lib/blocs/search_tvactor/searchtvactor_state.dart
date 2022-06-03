part of 'searchtvactor_bloc.dart';

abstract class SearchTvActorState extends Equatable {
  const SearchTvActorState();

  @override
  List<Object> get props => [];
}

class SearchTvActorInitial extends SearchTvActorState {}

class SearchTvActorLoaded extends SearchTvActorState {
  final List<TvActor> tvActors;

  const SearchTvActorLoaded(this.tvActors);

  @override
  List<Object> get props => [tvActors];
}

class SearchTvActorLoading extends SearchTvActorState {}

class SearchTvActorError extends SearchTvActorState {}
