part of 'actortvshows_bloc.dart';

abstract class ActortvshowsState extends Equatable {
  const ActortvshowsState();

  @override
  List<Object> get props => [];
}

class ActortvshowsInitial extends ActortvshowsState {}

class ActortvshowsLoaded extends ActortvshowsState {
  final List<TvShow> tvshows;

  const ActortvshowsLoaded(this.tvshows);

  @override
  List<Object> get props => [tvshows];
}

class ActortvshowsError extends ActortvshowsState {}
